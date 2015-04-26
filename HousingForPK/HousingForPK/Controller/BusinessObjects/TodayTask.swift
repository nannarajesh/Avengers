//
//  TodayTask.swift
//  XcelEnergy
//
//  Created by Karthik on 12/12/14.
//  Copyright (c) 2014 Karthik. All rights reserved.
//

import Foundation
import MapKit

class TodayTask : NSObject
{
    var slNo : String
    var accountName : String
    var accountNo :String
    var meterLocation : String
    var meterReading : String
    var meterNo : String
    var DistanceInMiles : String
    var CustomerAddress : String
    var isHazard : Bool
    var isPolice : Bool
    var isSecurityKey : Bool
    var isCash : Bool
    var TotalArrears : Int
    var latitude : CLLocationDegrees
    var longitude : CLLocationDegrees
    var isCompleted : Bool
    var completedDate : String
    
    //var latitude : CLLocationDegrees
    
    init(slNo : String, accountNo: String,accountName : String ,meterNo: String,meterLocation : String,meterReading : String,distance : String, address : String, isHaz : Bool, isPol : Bool, isSecKey : Bool, isCash : Bool, arrears : Int , latitude : CLLocationDegrees, longitude : CLLocationDegrees,isCompleted : Bool,completedDate: String)
    {
        
        self.slNo = slNo
        self.accountNo = accountNo
        self.accountName = accountName
        self.meterNo = meterNo
        self.meterLocation = meterLocation
        self.meterReading = meterReading
        self.DistanceInMiles = distance
        self.CustomerAddress = address
        self.isHazard = isHaz
        self.isPolice = isPol
        self.isSecurityKey = isSecKey
        self.isCash = isCash
        self.TotalArrears = arrears
        self.latitude = latitude
        self.longitude = longitude
        self.isCompleted = isCompleted
        self.completedDate = completedDate
    }
    
    
}