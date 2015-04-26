//
//  DropDownArrayData.swift
//  ESI
//
//  Created by Administrator on 15/12/14.
//  Copyright (c) 2014 Ashis. All rights reserved.
//

import Foundation

class DropDownArrayData: NSObject {
    
    
    class func getBudget () -> NSArray
    {
        var arrayBudget = ["3500-7000","7000-14.0K", "14.0K-21.0K","21.0K-28.0K","28.0K-35.0K"]
        return arrayBudget
    }
    class func getBHK () -> NSArray
    {
        var arrayBHK = ["1 RK", "1 BHK","2 BHK", "3 BHK","3+ BHK" ]
        return arrayBHK
    }
    class func getGender () -> NSArray
    {
        var arrayVisitInfoPatientId = ["Boys", "Girls"]
        return arrayVisitInfoPatientId
    }
    class func getRent () -> NSArray
    {
        var arrayVisitInfoPatientId = ["Facial Recognition", "Date of Birth","Address", "Other"]
        return arrayVisitInfoPatientId
    }
   
    class func getBuy () -> NSArray
    {
        var arrayVisitInfoPatientId = ["10-25 Lac", "25-35 Lac","35-55 Lac", "55-1 Cr","1 Cr-More"]
        return arrayVisitInfoPatientId
    }
    
    class func getProjectName () -> NSArray
    {
        var arrayVisitInfoPatientId = ["Project 1", "Project 2","Project 3", "Project 4"]
        return arrayVisitInfoPatientId
    }
    
    
    class func getEssentials() -> NSArray {
        
        return ["Bank/ATMs","Hospital","Schools","Parks"]
    }
    
    class func getGoOuts()-> NSArray {
        return ["Restaurants","Movie Theater","Bars/NightClubs"]
    }
    class func getUtilities() -> NSArray {
        return ["Grocery","Farmacy","Shopping Mall"]
    }
    
    class func getCommunications()-> NSArray{
        return ["Bus","Train","AirPort"]
    }
   
}