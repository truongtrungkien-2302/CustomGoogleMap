//
//  LocationBusiness.swift
//  DrawPolyline
//
//  Created by Truong Trung Kien on 08/02/2024.
//

import Foundation
import CoreLocation
import MapKit
import Permission

/// Lớp quản lý các vấn đề về Vị trí địa lý
class LocationBusiness: NSObject {
    
    let locationManager = CLLocationManager()
    
    static let shared = LocationBusiness()
    /// Tọa độ hiện tại của người dùng
    var currentLocation: CLLocationCoordinate2D?
    /// Vị trí hiện tại của người dùng
    var currentAddress: String?
    
    var didUpdateLocation: ((_ location: CLLocationCoordinate2D) -> Void)?
    
    var didFailGetLocation: (() -> Void)?
    
    var isUpdatingLocation: Bool = false
    
    override init() {
        
    }
    
    /// Bắt đầu cập nhật vị trí người dùng
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 20/04/2019
    func startUpdateLocation(){
        AppDelegate.locationCountDebound = 1
        if self.isUpdatingLocation == true {
            return
        }
        self.requestLocationPermission {[weak self] (isAllow) in
            guard let self = self else { return }
            if isAllow {
                self.locationManager.delegate = self
                //self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
                self.isUpdatingLocation = true
            }
        }
    }
    
    func requestLocationPermission(_ completion: @escaping (_ isAllow: Bool) -> Void){
        if AppDelegate.isLocationAuthorized{
            completion(true)
            return
        }
        
        let permission = Permission.locationWhenInUse
        permission.presentDisabledAlert = false
        permission.presentDeniedAlert = false
        self.setupPermissAlertContent(alertView: permission.deniedAlert, content: "Common_RequireLocationPermission")
        self.setupPermissAlertContent(alertView: permission.disabledAlert, content: "Common_RequireLocationPermission")
        permission.request { (status) in
            
            if status == .authorized{
                AppDelegate.isLocationAuthorized = true
                completion(true)
            }else{
                AppDelegate.isLocationAuthorized = false
                Thread.runOnMain(after: 1, block: {
                    if AppDelegate.locationCountDebound == 1{
                        let permission2 = Permission.locationWhenInUse
                        permission2.presentDisabledAlert = true
                        permission2.presentDeniedAlert = true
                        self.setupPermissAlertContent(alertView: permission2.deniedAlert, content: "Common_RequireLocationPermission")
                        self.setupPermissAlertContent(alertView: permission2.disabledAlert, content: "Common_RequireLocationPermission")
                        permission2.request { (status) in}
                    }
                    AppDelegate.locationCountDebound = AppDelegate.locationCountDebound + 1
                })
                completion(false)
            }
        }
    }
    
    func setupPermissAlertContent(alertView: PermissionAlert, content: String){
        alertView.title = "AppTitle"
        alertView.message = content
        alertView.cancel = "Common_Reject"
        alertView.confirm = "Common_Allow"
        alertView.settings = "Common_Setting"
    }
    
    /// Ngừng cập nhật vị trí người dùng
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 20/04/2019
    func stopUpdateLocation(){
        self.didUpdateLocation = nil
        self.locationManager.stopUpdatingLocation()
        self.isUpdatingLocation = false
    }
    
    /// Lấy tên địa điểm dựa vào tọa độ
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 20/04/2019
    func getAddress(coordinate: CLLocationCoordinate2D?, completion: @escaping ((_ name: String) -> Void)){
        
        guard let point = coordinate ?? self.currentLocation else {
            completion("")
            return
        }
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: point.latitude, longitude: point.longitude)
        geoCoder.reverseGeocodeLocation(location) {[weak self] (placemarks, error) in
            guard let self = self else { return }
            if let placemark = placemarks?.first, let addressLines = placemark.addressDictionary?["FormattedAddressLines"] as? [String] {
                let address = addressLines.joined(separator: ", ")
                if coordinate == nil {
                    self.currentAddress = address
                }
                completion(address)
            }else{
                completion("")
            }
        }
        
       
    }
    
    /// Lấy tọa độ dựa vào tên địa điểm
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 20/04/2019
    func getCoordinate(address: String, completion: @escaping ((_ coordinate: CLLocationCoordinate2D?) -> Void)){
        if address.isEmpty == true {
            completion(nil)
            return
        }
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            if let placemark = placemarks?.first, let location = placemark.location {
                completion(location.coordinate)
            }else{
                
                completion(nil)
            }
        }
    }
    
    ///  Lấy tọa độ dựa vào tên địa điểm
    /// - Author: GIANG PHAN BA
    /// - Date: 28/02/2023
    func getLocationLocationByAddress(_ address: String,completion:@escaping((CLLocationCoordinate2D) -> ())){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location else {  return }
            DispatchQueue.main.async {
                completion(location.coordinate)
            }
        }
    }
    
    /// Hàm chỉ đường dùng bản đồ Apple Maps, điểm đến là 1 tọa độ
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 25/04/2019
    private func directOnAppleMaps(destination: CLLocationCoordinate2D){
        
        guard let sourceLocation = LocationBusiness.shared.currentLocation else { return }
        let sourceItem = MKMapItem(placemark: MKPlacemark(coordinate: sourceLocation))
        let destinationItem = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        MKMapItem.openMaps(with: [sourceItem, destinationItem], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    
    /// Hàm chỉ đường dùng bản đồ Apple Maps, điểm đến là 1 địa chỉ cụ thể
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 25/04/2019
    private func directOnAppleMaps(destination: String?){
        guard let destination = destination?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) else { return }
//        if let directionURL = URL(string: AppConstants.kAppleMapsScheme + "?daddr=\(destination)&dirflg=d") {
//            UIApplication.shared.open(directionURL, options: [:], completionHandler: nil)
//            return
//        }
    }
    
    /// Hàm hiển thị một tọa độ trên Apple Maps
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 25/04/2019
    private func showOnAppleMaps(location: CLLocationCoordinate2D,address :String? = nil ){
        let locationItem = MKMapItem(placemark: MKPlacemark(coordinate: location))
        if !(address?.isEmpty ?? true) {
            locationItem.name = address
        }
        MKMapItem.openMaps(with: [locationItem], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    /// Hàm hiển thị một địa chỉ trên Apple Maps
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 25/04/2019
    private func showOnAppleMaps(location: String?){
        guard let location = location?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) else { return }
//        if let directionURL = URL(string: AppConstants.kAppleMapsScheme + "?q=\(location)") {
//            UIApplication.shared.open(directionURL, options: [:], completionHandler: nil)
//            return
//        }
    }
    /// Hàm chỉ đường dùng bản đồ Google Maps, điểm đến là 1 tọa độ
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 25/04/2019
    private func directOnGoogleMaps(destination: CLLocationCoordinate2D){
//        if let directionURL = URL(string: AppConstants.kGoogleMapsScheme + "?daddr=\(destination.latitude),\(destination.longitude)&directionsmode=driving") {
//            UIApplication.shared.open(directionURL, options: [:], completionHandler: nil)
//            return
//        }
    }
    
    
    /// Hàm chỉ đường dùng bản đồ Google Maps, điểm đến là 1 địa chỉ cụ thể
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 25/04/2019
    private func directOnGoogleMaps(destination: String?){
        guard let destination = destination else { return }
//        if let directionURL = URL(string: AppConstants.kGoogleMapsScheme + "?daddr=\(destination)&directionsmode=driving") {
//            UIApplication.shared.open(directionURL, options: [:], completionHandler: nil)
//            return
//        }
    }
    
    
    /// Hàm hiển thị một tọa độ trên Google Maps
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 25/04/2019
    private func showOnGoogleMaps(location: CLLocationCoordinate2D){
//        if let directionURL = URL(string: AppConstants.kGoogleMapsScheme + "?daddr=\(location.latitude),\(location.longitude),zoom=14&views=traffic") {
//            UIApplication.shared.open(directionURL, options: [:], completionHandler: nil)
//            return
//        }
    }
    
    
    /// Hàm hiển thị một địa chỉ trên Google Maps
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 25/04/2019
    private func showOnGoogleMaps(location: String?){
        guard let location = location else { return }
//        if let directionURL = URL(string: AppConstants.kGoogleMapsScheme + "?q=\(location),zoom=14&views=traffic") {
//            UIApplication.shared.open(directionURL, options: [:], completionHandler: nil)
//            return
//        }
    }
    
    /// Hàm hiển thị một địa chỉ trên bản đồ
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 25/04/2019
    func showOnMaps(location: String?){
//        if MSCache.string(key: .mapSetting) == AppConstants.kGoogleMaps {
//            if let url = URL(string: AppConstants.kGoogleMapsScheme) {
//                if UIApplication.shared.canOpenURL(url) {
//                    self.showOnGoogleMaps(location: location)
//                    return
//                }
//            }
//        }
        self.showOnAppleMaps(location: location)
    }
    
    /// Hàm hiển thị một tọa độ trên bản đồ
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 25/04/2019
    func showOnMaps(location: CLLocationCoordinate2D,address : String? ){
//        if MSCache.string(key: .mapSetting) == AppConstants.kGoogleMaps {
//            if let url = URL(string: AppConstants.kGoogleMapsScheme) {
//                if UIApplication.shared.canOpenURL(url) {
//                    self.showOnGoogleMaps(location: location)
//                    return
//                }
//            }
//        }
        self.showOnAppleMaps(location: location,address: address)
    }
    
    /// Hàm chỉ đường dùng bản đồ, điểm đến là 1 địa chỉ cụ thể
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 25/04/2019
    func directOnMaps(destination: String?){
//        if MSCache.string(key: .mapSetting) == AppConstants.kGoogleMaps {
//            if let url = URL(string: AppConstants.kGoogleMapsScheme) {
//                if UIApplication.shared.canOpenURL(url) {
//                    self.directOnGoogleMaps(destination: destination)
//                    return
//                }
//            }
//        }
        self.directOnAppleMaps(destination: destination)
    }
    
    /// Hàm chỉ đường dùng bản đồ, điểm đến là 1 tọa độ
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 25/04/2019
    func directOnMaps(destination: CLLocationCoordinate2D){
//        if MSCache.string(key: .mapSetting) == AppConstants.kGoogleMaps {
//            if let url = URL(string: AppConstants.kGoogleMapsScheme) {
//                if UIApplication.shared.canOpenURL(url) {
//                    self.directOnGoogleMaps(destination: destination)
//                    return
//                }
//            }
//        }
        self.directOnAppleMaps(destination: destination)
    }
    
    
    class func isRegion(center: CLLocationCoordinate2D, radius: Double, contains location: CLLocationCoordinate2D) -> Bool{
        let cicularRegion = CLCircularRegion(center: center, radius: radius*1000, identifier: "cicularRegion")
        return cicularRegion.contains(location)
    }
}


extension LocationBusiness: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locValue = locations.last?.coordinate {
            self.currentLocation = locValue
            self.didUpdateLocation?(locValue)
        } else {
            self.didFailGetLocation?()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.didFailGetLocation?()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse{
            
            self.locationManager.delegate = self
            //self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
            self.isUpdatingLocation = true
        }
    }
}


extension MKMapView{
    func setRegion(region: CLCircularRegion) {
        let mkRegion = MKCoordinateRegion(center: region.center, latitudinalMeters: region.radius*2, longitudinalMeters: region.radius*2)
        self.setRegion(mkRegion, animated: true)
    }
}

