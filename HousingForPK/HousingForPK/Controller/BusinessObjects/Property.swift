//
//  Property.swift
//  HousingForPK
//
//  Created by Rajesh Nanna on 25/04/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit

class Property: NSObject {
    var strBHKType : String?
    var strAddress : String?
    var strPropertyType : String?
    var strArea : String?
    var strLease : String?
    var strFacing : String?
    var strBathrooms : String?
    var strPowerBackup : String?
    var strAdded : String?
    var strAvailability : String?
    var strPrice : String?

    var dictFlatAmenities : NSMutableDictionary?
    //AC - No AC
    //TV - No TV
    //Cupboards - No Cupboards
    //Bed - No Bed
    //Sofa - No Sofa
    //DiningTable - No Dining Table
    //Microwave - No Microwave
    //Fridge - No Fridge
    //Stove - No Stove
    //WashingMachine - 
    //ServeantRoom -
    
    var dictSocietyAmenities : NSMutableDictionary?
    
    //Lift - 
    //GasPipeline
    //Gym
    //SwimmingPool
    //Parking
    var arrImages : NSMutableArray?
}
