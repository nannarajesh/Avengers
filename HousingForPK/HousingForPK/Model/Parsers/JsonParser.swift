//
//  JsonParser.swift
//  ValidationOfTweets
//
//  Created by Ashis Laha on 25/04/15.
//  Copyright (c) 2015 Ashis Laha. All rights reserved.
//

import UIKit
import Foundation

class JsonParser: NSObject {
    
        
        var jsonDataFromServer : NSData
    
        var arrayLength : Int = 1
        var index: Int = 0
        
        override init(){
            var path = NSBundle.mainBundle().pathForResource("Essentials", ofType: "json")
            jsonDataFromServer = NSData.dataWithContentsOfMappedFile(path!) as NSData
        }
        
    
    // REMARK: - getEssentials
    
    func getEssentials()-> NSDictionary {
            var error : NSError?
        
            let jsonDict:NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonDataFromServer, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        
        /*
            let SessionsArray : NSArray = jsonDict.valueForKey("SessionData") as NSArray
            
            var position : Int = 0
            for index in 0...SessionsArray.count - 1
            {
                if ((SessionsArray[index] as NSDictionary).valueForKey("SessionDay") as Int == day )
                {
                    var tempTuple = (time:String(), topic:String(), venue:String(), speakers:[String](), eventType: String())
                    tempTuple.time = (SessionsArray[index] as NSDictionary).valueForKey("Time") as String
                    tempTuple.topic = (SessionsArray[index] as NSDictionary).valueForKey("SessionName") as String
                    tempTuple.venue = (SessionsArray[index] as NSDictionary).valueForKey("Venue") as String
                    tempTuple.eventType = (SessionsArray[index] as NSDictionary).valueForKey("SessionType") as String
                    
                    for speakercount in 0...((SessionsArray[index] as NSDictionary).valueForKey("Speakers") as NSArray).count - 1
                    {
                        if (((SessionsArray[index] as NSDictionary).valueForKey("Speakers") as NSArray)[speakercount] as String) != ""
                        {
                            tempTuple.speakers.append(((SessionsArray[index] as NSDictionary).valueForKey("Speakers") as NSArray)[speakercount] as String)
                        }
                    }
                    returnTuple.insert(tempTuple, atIndex: position)
                    position++
                }
            }
            */
            println("\(jsonDict)")
            return  jsonDict
            
        }
    

   
}
