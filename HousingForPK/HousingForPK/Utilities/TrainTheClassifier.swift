//
//  TrainTheClassifier.swift
//  ValidationOfTweets
//
//  Created by Ashis Laha on 25/04/15.
//  Copyright (c) 2015 Ashis Laha. All rights reserved.
//

import UIKit

class TrainTheClassifier: NSObject {
    
    var jsonParser = JsonParser()
   
    func trainTheEssentialClassifier()-> [String] {
    
        var essentialDict : NSDictionary = jsonParser.getEssentials()
        println("\(essentialDict)")
        return ["13.036873", "77.620007","true","true","true","true"]
        
    }

    func trainTheGoOutClassifier() -> [String] {
        return ["13.036873", "77.620007","true","true","true"]
    }
    
    func trainTheUtilitiesClassifier() -> [String] {
        return ["13.036873", "77.620007","true","true","true"]
    }
    
    func trainTheCommunicationClassifier() -> [String] {
        return ["13.036873", "77.620007","true","true","true"]
    }
    
    // calculation is below How to compute the prob.
    
    func trainClassifier1()-> [Double] {
    
        var essentialDict : NSDictionary = jsonParser.getEssentials()
        println("\(essentialDict)")
        
        
        
        let SessionsArray : NSArray = essentialDict.valueForKey("Nagavara") as NSArray
        
        var countBankOrATMs : Int = 0
        var countHospitals : Int = 0
        var countSchools : Int = 0
        var countParks : Int = 0
        var probabilityEssentialArr  = [0.0, 0.0, 0.0, 0.0]
        var countVar = SessionsArray.count
        
        
        for index in 0...SessionsArray.count - 1
        {
            if ((SessionsArray[index] as NSDictionary).valueForKey("BankOrATMs") as String == "Yes" )
            {
                ++countBankOrATMs
            }
            
            if ((SessionsArray[index] as NSDictionary).valueForKey("Hospitals") as String == "Yes" )
            {
                ++countHospitals
            }
            if ((SessionsArray[index] as NSDictionary).valueForKey("Schools") as String == "Yes" ){
                ++countSchools
                
            }
            if ((SessionsArray[index] as NSDictionary).valueForKey("Parks") as String == "Yes" ){
                ++countParks
                
            }
        }
        
        probabilityEssentialArr[0] = Double(countBankOrATMs) / Double(countVar)
        probabilityEssentialArr[1] = Double(countHospitals) / Double(countVar)
        probabilityEssentialArr[2] = Double(countSchools) / Double(countVar)
        probabilityEssentialArr[3] = Double(countVar) / Double(countVar)
        
        println("@@@ Show count Value : \(countBankOrATMs) : \(countHospitals) : \(countSchools) : \(countVar) ")
        println("@@@ probabilityEssentialArr : \(probabilityEssentialArr)")
        
        return probabilityEssentialArr
    
    }
    
    
    func trainClassifier2()-> [Double] {
        
        var essentialDict : NSDictionary = jsonParser.getEssentials()
        println("\(essentialDict)")
        
        
        
        let SessionsArray : NSArray = essentialDict.valueForKey("Nagavara") as NSArray
        
        var countBankOrATMs : Int = 0
        var countHospitals : Int = 0
        var countSchools : Int = 0
        var countParks : Int = 0
        var probabilityEssentialArr  = [0.0, 0.0, 0.0, 0.0]
        var countVar = SessionsArray.count
        
        
        for index in 0...SessionsArray.count - 1
        {
            if ((SessionsArray[index] as NSDictionary).valueForKey("BankOrATMs") as String == "Yes" )
            {
                ++countBankOrATMs
            }
            
            if ((SessionsArray[index] as NSDictionary).valueForKey("Hospitals") as String == "Yes" )
            {
                ++countHospitals
            }
            if ((SessionsArray[index] as NSDictionary).valueForKey("Schools") as String == "Yes" ){
                ++countSchools
                
            }
            if ((SessionsArray[index] as NSDictionary).valueForKey("Parks") as String == "Yes" ){
                ++countParks
                
            }
        }
        
        probabilityEssentialArr[0] = Double(countBankOrATMs) / Double(countVar)
        probabilityEssentialArr[1] = Double(countHospitals) / Double(countVar)
        probabilityEssentialArr[2] = Double(countSchools) / Double(countVar)
        probabilityEssentialArr[3] = Double(countVar) / Double(countVar)
        
        println("@@@ Show count Value : \(countBankOrATMs) : \(countHospitals) : \(countSchools) : \(countVar) ")
        println("@@@ probabilityEssentialArr : \(probabilityEssentialArr)")
        
        return probabilityEssentialArr
        
    }


}
