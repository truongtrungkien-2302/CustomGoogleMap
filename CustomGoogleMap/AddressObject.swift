//
//  AddressObject.swift
//  DrawPolyline
//
//  Created by Truong Trung Kien on 08/02/2024.
//

import Foundation
import ObjectMapper

class AddressObject: Mappable {
    private let kRoutingObjectLayoutCodeKey: String = "LayoutCode"
    private let kRoutingObjectModifiedDateKey: String = "ModifiedDate"
    private let kRoutingObjectEntityIDKey: String = "EntityID"
    private let kRoutingObjectCycleIDTextKey: String = "CycleIDText"
    private let kRoutingObjectEndDateKey: String = "EndDate"
    private let kRoutingObjectIDKey: String = "ID"
    private let kRoutingObjectCodeKey: String = "Code"
    private let kRoutingObjectNameKey: String = "Name"
    private let kRoutingObjectAddressKey: String = "Address"
    private let kRoutingObjectStartDateKey: String = "StartDate"
    private let kRoutingObjectCycleIDKey: String = "CycleID"
    private let kBaseClassIsOpenKey: String = "IsOpen"
    private let kBaseClassDescription: String = "Description"
    private let kBaseClassActivityID: String = "ActivityID"
    
    // MARK: Properties
    public var layoutCode: String?
    public var modifiedDate: String?
    public var entityID: Int?
    public var cycleIDText: String?
    public var endDate: String?
    public var iD: Int?
    public var code: String?
    public var name: String?
    public var address: String?
    public var startDate: String?
    public var cycleID: Int?
    
    public var batteryStatus: Int?
    public var routeAddress: String?
    public var checkInTime: Date?
    public var checkOutTime: Date?
    public var distance: Double?
    public var isOpen: Bool?
    public var description: String?
    public var activityID: Int?
    
    public var latitude : Double?
    public var longitude : Double?
    public var latitudeCheckIn : Double?
    public var longitudeCheckIn : Double?
    
    public var lat : Double?
    public var long : Double?
    
    public var journey :  Double? = 0
    public var isCorrectRoute :  Bool = false
   
    public var countStartActivity: Int? ///số lượng bản ghi bắt đầu đi tuyến
    public var countEndActivity: Int? ///số lượng bản ghi kết thúc đi tuyến
    
    public var distanceByUser: Double? ///khoảng cách
    ///
    
    public var formLayoutID: Int?
    
    public var routingTypeID: Int?
    public var routingTypeIDText: String?
    public var entityName: String?
    public var companyName: String?
    public var type: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        layoutCode <- map[kRoutingObjectLayoutCodeKey]
        modifiedDate <- map[kRoutingObjectModifiedDateKey]
        entityID <- map[kRoutingObjectEntityIDKey]
        cycleIDText <- map[kRoutingObjectCycleIDTextKey]
        endDate <- map[kRoutingObjectEndDateKey]
        iD <- map[kRoutingObjectIDKey]
        activityID <- map[kBaseClassActivityID]
        formLayoutID <- map["FormLayoutID"]
        routingTypeID <- map["RoutingTypeID"]
        routingTypeIDText <- map["RoutingTypeIDText"]
        companyName <- map["CompanyName"]
        entityName <- map["EntityName"]
        code <- map[kRoutingObjectCodeKey]
        name <- map[kRoutingObjectNameKey]
        self.address <- map[kRoutingObjectAddressKey]
        self.latitude  <- map["Latitude"]
        self.longitude  <- map["Longitude"]
        self.latitudeCheckIn  <- map["LatitudeCheckIn"]
        self.longitudeCheckIn  <- map["LongitudeCheckIn"]
        self.type  <- map["Type"]
        
        startDate <- map[kRoutingObjectStartDateKey]
        cycleID <- map[kRoutingObjectCycleIDKey]
        
        checkInTime <- (map["CheckInTime"], DateTransform())
        checkOutTime <- (map["CheckOutTime"], DateTransform())
        batteryStatus <- map["BatteryStatus"]
        countStartActivity <- map["CountStartActivity"]
        countEndActivity <- map["CountEndActivity"]
        routeAddress <- map["RouteAddress"]
        distance <- map["Distance"]
        isOpen <- map[kBaseClassIsOpenKey]
        description <- map[kBaseClassDescription]
        
       
        isCorrectRoute <- map["IsCorrectRoute"]
        distanceByUser <- map["DistanceByUser"]
        lat  <- map["Lat"]
        long  <- map["Long"]
        
    }
}

