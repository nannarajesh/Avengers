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
    
    func trainClassifier() {
    
        
    
    }

}
