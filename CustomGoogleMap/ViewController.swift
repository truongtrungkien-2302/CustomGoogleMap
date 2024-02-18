//
//  ViewController.swift
//  CustomGoogleMap
//
//  Created by Truong Trung Kien on 16/02/2024.
//

import UIKit
import GoogleMaps
import CoreLocation
import SVGKit
import ObjectMapper

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var viewFilter: UIView!
    @IBOutlet weak var lblFilter: UILabel!
    
    @IBOutlet weak var viewCurrentUser: UIView!
    
    @IBOutlet weak var lblLocationAccount: UILabel!
    @IBOutlet weak var viewLocationAccount: UIView!
    
    private var isNotVisited: Bool = true {
        didSet {
            self.lblFilter.text = isNotVisited ? "Chưa ghé thăm" : "Đã ghé thăm"
            if !self.isNotVisited {
                self.drawPath()
            } else {
                self.mapView.clear()
            }
        }
    }
    
    private var isLocationAccount: Bool = false {
        didSet {
            self.lblLocationAccount.text = isLocationAccount ? "VTKH~true" : "VTKH~false"
            if !self.isNotVisited {
                self.drawPath()
            } else {
                self.mapView.clear()
            }
        }
    }
    
    private let locationManager = CLLocationManager()
    private let customMarkerWidth: Int = 36
    private let customMarkerHeight: Int = 42
    private var timer: Timer?
    private var listDataLocation: [AddressObject] = []
    private var listDataCheckIn: [AddressObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpView()
        self.setUpLocationManager()
        self.startUpdateUserLocation()
        
        let dictionaryLocation = self.convertStringToObject(jsonString: AppDelegate().dataLocation26012024)
        let listLocation = Mapper<AddressObject>().mapArray(JSONArray: dictionaryLocation).sorted(by: {$0.checkInTime ?? Date() < $1.checkInTime ?? Date()})
        self.listDataLocation = listLocation
        
        let dictionaryCheckIn = self.convertStringToObject(jsonString: AppDelegate().dataCheckIn26012024)
        let listCheckIn = Mapper<AddressObject>().mapArray(JSONArray: dictionaryCheckIn).sorted(by: {$0.checkInTime ?? Date() < $1.checkInTime ?? Date()})
        self.listDataCheckIn = listCheckIn
    }
    
    private func setUpView() {
        self.mapView.delegate = self
        
        self.lblFilter.text = isNotVisited ? "Chưa ghé thăm" : "Đã ghé thăm"
        self.lblLocationAccount.text = isLocationAccount ? "VTKH~true" : "VTKH~false"
        
        self.viewCurrentUser.addTapGesture(tapNumber: 1, target: self, action: #selector(self.showCurrentLocationUser(_:)))
        self.viewFilter.addTapGesture(tapNumber: 1, target: self, action: #selector(self.showFilter(_:)))
        self.viewLocationAccount.addTapGesture(tapNumber: 1, target: self, action: #selector(self.actionClickLocationAccount(_:)))
    }
    
    @IBAction func showCurrentLocationUser(_ sender: Any) {
        self.mapView.isMyLocationEnabled = true
        let camera = GMSCameraPosition.camera(withLatitude: 21.065424, longitude: 105.797717, zoom: 15)
        self.mapView.camera = camera
    }
    
    @IBAction func showFilter(_ sender: Any) {
        self.isNotVisited = !self.isNotVisited
    }
    
    @IBAction func actionClickLocationAccount(_ sender: Any) {
        self.isLocationAccount = !self.isLocationAccount
    }
    
    private func setUpLocationManager() {
        locationManager.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.pausesLocationUpdatesAutomatically = false
        
        
        locationManager.startUpdatingLocation()
        
        // Set up timer to update location every 15 minutes
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            self.locationManager.startUpdatingLocation()
            
        }
        self.view.backgroundColor = .gray
    }
    
    ///  bắt đầu lấy vị trí hiện tại của user
    private func startUpdateUserLocation(){
        self.mapView.isMyLocationEnabled = true
        let camera = GMSCameraPosition.camera(withLatitude: 21.065424, longitude: 105.797717, zoom: 15)
        self.mapView.camera = camera
    }
    
    
    private func drawPath() {
        self.mapView.clear()
        let pathCheckIn = GMSMutablePath()
        
        if self.isLocationAccount {
            Thread.runOnMain {
                for (index, itemAddress) in self.listDataCheckIn.enumerated() {
                    if let latitude = itemAddress.latitude, let longitude = itemAddress.longitude {
                        let pos = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        self.addMarker(isOrange: true, index: index + 1, position: pos)
                        
                        if let latitudeCheckIn = itemAddress.latitudeCheckIn,
                           let longitudeCheckIn = itemAddress.longitudeCheckIn,
                           let index = self.listDataLocation.firstIndex(where: {($0.latitude == latitude) && ($0.longitude == longitude) && ($0.latitudeCheckIn == latitudeCheckIn	) && ($0.longitudeCheckIn == longitudeCheckIn)}),
                           let latitudeCheckInAtIndex = self.listDataLocation[index].latitudeCheckIn,
                           let longitudeCheckInAtIndex = self.listDataLocation[index].longitudeCheckIn{
                            let path = GMSMutablePath()
                            path.addLatitude(latitude, longitude: longitude)
                            path.addLatitude(latitudeCheckInAtIndex, longitude: longitudeCheckInAtIndex)
                            
                            let polyline = GMSPolyline(path: path)
                            polyline.strokeWidth = 2.0
                            polyline.geodesic = true
                            polyline.strokeColor = .orange
                            polyline.map = self.mapView
                        }
                    }
                }
            }
        }
        
        Thread.runOnMain {
            var index = 0
            self.listDataLocation.forEach({itemAddress in
                if let latitude = itemAddress.latitudeCheckIn, let longitude = itemAddress.longitudeCheckIn {
                    pathCheckIn.addLatitude(latitude, longitude: longitude)
                    let pos = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    index = index + 1
                    self.addMarker(isOrange: false, index: index, position: pos)
                } else {
                    if let latitude = itemAddress.latitude, let longitude = itemAddress.longitude {
                        pathCheckIn.addLatitude(latitude, longitude: longitude)
                    }
                }
            })
        }
        
        let polylinepathCheckIn = GMSPolyline(path: pathCheckIn)
        polylinepathCheckIn.strokeWidth = 2.0
        polylinepathCheckIn.geodesic = true
        polylinepathCheckIn.strokeColor = .blue
        polylinepathCheckIn.map = self.mapView
    }
    
    private func addMarker(isOrange: Bool, index: Int, position: CLLocationCoordinate2D) {
        let marker=GMSMarker()
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: self.customMarkerWidth, height: self.customMarkerHeight), title: String(index), borderColor: .link, tag: index, isOrange)
        marker.iconView=customMarker
        marker.position = position
        marker.tracksViewChanges = false
        marker.zIndex = Int32(index)
        marker.isTappable = true
        marker.map = self.mapView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func convertStringToObject(jsonString: String) -> [[String: Any]] {
        if let jsonString = jsonString.data(using: .utf8) {
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: jsonString, options: []) as? [[String: Any]] {
                    return jsonObject
                }
            } catch {
                
            }
        }
        return [[:]]
    }
    
}

extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        self.mapView.isMyLocationEnabled = true
        let camera = GMSCameraPosition.camera(withLatitude: marker.position.latitude, longitude: marker.position.longitude, zoom: 20)
        self.mapView.camera = camera
        return false
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        mapView.mapStyle
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locValue = manager.location?.coordinate {
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
            
        case .authorizedAlways, .authorizedWhenInUse:
            
            print("Location access granted")
            
            
        case .denied, .restricted:
            
            print("Location access denied")
            
            
        default:
            
            break
            
        }
    }
}
