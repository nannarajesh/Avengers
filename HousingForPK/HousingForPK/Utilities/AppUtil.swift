//
//  AppUtil.swift
//  XcelEnergy
//
//  Created by Administrator on 25/11/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit


class AppUtil: NSObject {
    
    //use this function to access appDelegate shared Instance
    class func APP_DELEGATE () -> AppDelegate {
        
        var delegate : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        return delegate
    }
    class func applicationDocPath () -> String
    {
        var directory : String = ((NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray).count > 0 ? (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray).objectAtIndex(0) : "") as String
        
        return directory
    }

    class func annotationPath (fileName : String) -> String
    {
        var annotationPath : String = AppUtil.applicationDocPath() + "/" + fileName
        return annotationPath
    }

}
