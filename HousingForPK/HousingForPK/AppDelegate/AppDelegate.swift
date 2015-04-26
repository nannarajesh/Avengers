    //
//  AppDelegate.swift
//  HousingForPK
//
//  Created by Administrator on 25/04/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var TodayTaskList : Array <TodayTask>!
    var openTaskArray:Array<TodayTask> = []
    var closedTaskArray:Array<TodayTask> = []
//    var login:XELoginViewController?
    var strCompileTodayTask: String! = ""
//    var selectedController : XETaskListViewController?
    var selectedCustomer : TodayTask!
	var arrProperties : NSMutableArray?
    var selectedIndex : Int = 1

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        TodayTaskList = []
        self.fillStaticData()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func fillStaticData()
    {
        self.arrProperties = NSMutableArray()
        
        var i : Int = 0
        
        for i in 0 ... 20
        {
            var objProperty : Property = Property()
            
//            objProperty.strBHKType = "2 BHK, Unfurnished"
//            objProperty.strAddress = "First main road, Ford road, Near Ford show room, Lingarajapuram, Nagavara"
//            objProperty.strPropertyType = "Independent House"
//            objProperty.strArea = "500 sq.ft."
//            objProperty.strLease = "No Restrictions"
//            objProperty.strFacing = "East"
//            objProperty.strBathrooms = "1"
//            objProperty.strPowerBackup = "None"
//            objProperty.strAdded = "About a month ago"
//            objProperty.strAvailability = "Ready to move"

            objProperty.strBHKType = "2 BHK"
            objProperty.strAddress = "Manayatha Tech Park, Near Hospital Hut, Bangalore, Karnataka"
            objProperty.strPropertyType = "Independent House"
            objProperty.strArea = "500 sq.ft."
            objProperty.strLease = "No Restrictions"
            objProperty.strFacing = "East"
            objProperty.strBathrooms = "1"
            objProperty.strPowerBackup = "None"
            objProperty.strAdded = "About a month ago"
            objProperty.strAvailability = "Ready to move"
            objProperty.strPrice = "45 Lakh"
            
            objProperty.dictFlatAmenities = NSMutableDictionary()
            
            objProperty.dictFlatAmenities?.setObject("1 AC", forKey: "AC")
            objProperty.dictFlatAmenities?.setObject("1 TV", forKey: "TV")
            objProperty.dictFlatAmenities?.setObject("2 Cupboards", forKey: "Cupboards")
            objProperty.dictFlatAmenities?.setObject("2 Bed", forKey: "Bed")
            objProperty.dictFlatAmenities?.setObject("No Sofa", forKey: "Sofa")
            objProperty.dictFlatAmenities?.setObject("1 Dining Table", forKey: "DiningTable")
            objProperty.dictFlatAmenities?.setObject("No Microwave", forKey: "Microwave")
            objProperty.dictFlatAmenities?.setObject("No Fridge", forKey: "Fridge")
            objProperty.dictFlatAmenities?.setObject("1 Stove", forKey: "Stove")
            objProperty.dictFlatAmenities?.setObject("No Washing Machine", forKey: "WashingMachine")
            objProperty.dictFlatAmenities?.setObject("No Servant Room", forKey: "ServeantRoom")
            
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
            
            
            objProperty.dictSocietyAmenities = NSMutableDictionary()
            objProperty.dictSocietyAmenities?.setObject("No Lift", forKey: "Lift")
            objProperty.dictSocietyAmenities?.setObject("Yes", forKey: "GasPipeline")
            objProperty.dictSocietyAmenities?.setObject("No Gym", forKey: "Gym")
            objProperty.dictSocietyAmenities?.setObject("No Swimming Pool", forKey: "SwimmingPool")
            objProperty.dictSocietyAmenities?.setObject("Yes", forKey: "Parking")
            
            //Lift -
            //GasPipeline
            //Gym
            //SwimmingPool
            //Parking
            
            objProperty.arrImages = NSMutableArray()
            
            var j : Int = 1
            
            for j in 1 ... 10
            {
                var imageProperty : UIImage?
                var strImageName : String = "property_image\(j).png"
                imageProperty = UIImage(named: strImageName)
                objProperty.arrImages?.addObject(imageProperty!)
            }

            
            self.arrProperties!.addObject(objProperty)
        }
    }

func CompileTodayTaskList(strSelectedText : String)
    {
        //var ann : CLLocationCoordinate2D = CLLocationCoordinate2DMake(37.351789 , -122.049620)
        
        TodayTaskList.removeAll(keepCapacity: false)
        var taskObject = TodayTask(slNo:"1", accountNo:"3 BHK",accountName : "John Smith",meterNo: "M0050",meterLocation :"Rear End",meterReading :"78856",distance: "41.2 miles", address: "414 Nicollet Mall Minneapolls,MN 55401", isHaz: false, isPol: false, isSecKey: false, isCash: true, arrears : 312, latitude : 13.030425, longitude: 77.6619, isCompleted : true,completedDate:"11-Dec-2014 9:00AM")
        AppUtil.APP_DELEGATE().TodayTaskList.append(taskObject)
        taskObject = TodayTask(slNo:"2",accountNo:"Hospital",accountName : "William Johan",meterNo: "M0051",meterLocation :"Front Yard",meterReading: "56444",distance: "10 miles", address: "414 Nicollet Mall Minneapolls,MN 55401", isHaz: true, isPol: false, isSecKey: true, isCash: false, arrears : 1432, latitude : 13, longitude: 77.61, isCompleted : true,completedDate:"11-Dec-2014 8:00PM")
        AppUtil.APP_DELEGATE().TodayTaskList.append(taskObject)
        taskObject = TodayTask(slNo:"3",accountNo:"3 BHK",accountName : "Daniel Smith",meterNo: "M0052",meterLocation:"Rear End",meterReading: "54566", distance: "16 miles", address: "414 Nicollet Mall Minneapolls,MN 55401", isHaz: false, isPol: true, isSecKey: true, isCash: true,  arrears : 132, latitude : 13.033, longitude: 77.68,isCompleted : false,completedDate:"20-Dec-2014 9:00AM")
        AppUtil.APP_DELEGATE().TodayTaskList.append(taskObject)
        taskObject = TodayTask(slNo:"4",accountNo:"School",accountName : "Ryan Matthew",meterNo: "M0053",meterLocation :"Front Yard",meterReading: "54566",distance: "2 miles", address: "414 Nicollet Mall Minneapolls,MN 55401", isHaz: true, isPol: false, isSecKey: true, isCash: true, arrears : 534, latitude : 13.03323, longitude: 77.6289620,isCompleted : false,completedDate:"11-Dec-2014 9:00AM")
        AppUtil.APP_DELEGATE().TodayTaskList.append(taskObject)
        taskObject = TodayTask(slNo:"5",accountNo:"3 BHK",accountName : "Joshua ",meterNo: "M0054",meterLocation :"Rear End",meterReading: "43434",distance: "33.8 miles", address: "414 Nicollet Mall Minneapolls,MN 55401", isHaz: false, isPol: false, isSecKey: false, isCash: false, arrears : 876, latitude : 13.03011789, longitude: 77.6292620,isCompleted : false,completedDate:"11-Dec-2014 9:00AM")
        AppUtil.APP_DELEGATE().TodayTaskList.append(taskObject)
        taskObject = TodayTask(slNo:"6",accountNo:"Hospital",accountName : "Christopher",meterNo: "M0054",meterLocation :"Front Yard",meterReading: "10028",distance: "4 miles", address: "414 Nicollet Mall Minneapolls,MN 55401", isHaz: false, isPol: true, isSecKey: true, isCash: true, arrears : 786, latitude : 13.03013789, longitude: 77.6250620,isCompleted : false,completedDate:"11-Dec-2014 9:00AM")
        AppUtil.APP_DELEGATE().TodayTaskList.append(taskObject)
        taskObject = TodayTask(slNo:"7",accountNo:"School",accountName : "3 BHK House",meterNo: "M0056",meterLocation :"Rear End",meterReading: "98675",distance: "7 miles", address: "414 HRBR Layout,BLR 560045", isHaz: true, isPol: false, isSecKey: true, isCash: false, arrears : 365, latitude : 13.03001789, longitude: 77.6269620,isCompleted : false,completedDate:"11-Dec-2014 9:00AM")
        AppUtil.APP_DELEGATE().TodayTaskList.append(taskObject)
        taskObject = TodayTask(slNo:"8",accountNo:"Hospital",accountName : "Nicholas",meterNo: "M0057",meterLocation :"Front Yard",meterReading: "12536",distance: "14 miles", address: "414 Nicollet Mall Minneapolls,MN 55401", isHaz: false, isPol: true, isSecKey: false, isCash: false, arrears : 657, latitude : 13.03991789, longitude: 77.6255620,isCompleted : true,completedDate:"11-Dec-2014 2:00PM")
        AppUtil.APP_DELEGATE().TodayTaskList.append(taskObject)
        taskObject = TodayTask(slNo:"9",accountNo:"3 BHK",accountName : "Samuel",meterNo: "M0058",meterLocation :"Rear End",meterReading: "64589",distance: "25.6 miles", address: "414 Nicollet Mall Minneapolls,MN 55401", isHaz: false, isPol: false, isSecKey: false, isCash: true, arrears : 314, latitude : 13.03978789, longitude: 77.6240620,isCompleted : true,completedDate:"11-Dec-2014 11:00AM")
        AppUtil.APP_DELEGATE().TodayTaskList.append(taskObject)
        taskObject = TodayTask(slNo:"10",accountNo:"School",accountName : "Andrew",meterNo: "M0059",meterLocation :"Front Yard",meterReading: "78523",distance: "22 miles", address: "414 Nicollet Mall Minneapolls,MN 55401", isHaz: false, isPol: false, isSecKey: false, isCash: false, arrears : 867, latitude : 13.03967789, longitude: 77.6250620,isCompleted : false,completedDate:"11-Dec-2014 9:00AM")
        AppUtil.APP_DELEGATE().TodayTaskList.append(taskObject)
        taskObject = TodayTask(slNo:"11",accountNo:"Hospital",accountName : "Jackson",meterNo: "M0060",meterLocation :"Rear End",meterReading: "12243",distance: "17 miles", address: "414 Nicollet Mall Minneapolls,MN 55401", isHaz: false, isPol: false, isSecKey: false, isCash: true, arrears : 289, latitude : 13.03953789, longitude: 77.6241620,isCompleted : false,completedDate:"11-Dec-2014 9:00AM")
        AppUtil.APP_DELEGATE().TodayTaskList.append(taskObject)
        taskObject = TodayTask(slNo:"12",accountNo:"3 BHK",accountName : "David Warner",meterNo: "M0061",meterLocation :"Front Yard",meterReading: "65656",distance: "36.8 miles", address: "414 Nicollet Mall Minneapolls,MN 55401", isHaz: false, isPol: false, isSecKey: false, isCash: false, arrears : 465, latitude : 13.03950789, longitude: 77.6252820,isCompleted : false,completedDate:"11-Dec-2014 9:00AM")
        AppUtil.APP_DELEGATE().TodayTaskList.append(taskObject)
        
        taskObject = TodayTask(slNo:"5",accountNo:"Current",accountName : "Joshua ",meterNo: "M0054",meterLocation :"Rear End",meterReading: "43434",distance: "33.8 miles", address: "414 Nicollet Mall Minneapolls,MN 55401", isHaz: false, isPol: false, isSecKey: false, isCash: false, arrears : 876, latitude : 12.9323, longitude: 77.6292620,isCompleted : false,completedDate:"11-Dec-2014 9:00AM")
        AppUtil.APP_DELEGATE().TodayTaskList.append(taskObject)
        taskObject = TodayTask(slNo:"5",accountNo:"Current",accountName : "Joshua ",meterNo: "M0054",meterLocation :"Rear End",meterReading: "43434",distance: "33.8 miles", address: "414 Nicollet Mall Minneapolls,MN 55401", isHaz: false, isPol: false, isSecKey: false, isCash: false, arrears : 876, latitude : 12.9423, longitude: 77.6292620,isCompleted : false,completedDate:"11-Dec-2014 9:00AM")
        AppUtil.APP_DELEGATE().TodayTaskList.append(taskObject)
        taskObject = TodayTask(slNo:"5",accountNo:"Current",accountName : "Joshua ",meterNo: "M0054",meterLocation :"Rear End",meterReading: "43434",distance: "33.8 miles", address: "414 Nicollet Mall Minneapolls,MN 55401", isHaz: false, isPol: false, isSecKey: false, isCash: false, arrears : 876, latitude : 12.9422, longitude: 77.6292620,isCompleted : false,completedDate:"11-Dec-2014 9:00AM")
        AppUtil.APP_DELEGATE().TodayTaskList.append(taskObject)
        taskObject = TodayTask(slNo:"5",accountNo:"Current",accountName : "Joshua ",meterNo: "M0054",meterLocation :"Rear End",meterReading: "43434",distance: "33.8 miles", address: "414 Nicollet Mall Minneapolls,MN 55401", isHaz: false, isPol: false, isSecKey: false, isCash: false, arrears : 876, latitude : 12.9334, longitude: 77.6292620,isCompleted : false,completedDate:"11-Dec-2014 9:00AM")
        AppUtil.APP_DELEGATE().TodayTaskList.append(taskObject)
        taskObject = TodayTask(slNo:"5",accountNo:"Current",accountName : "Joshua ",meterNo: "M0054",meterLocation :"Rear End",meterReading: "43434",distance: "33.8 miles", address: "414 Nicollet Mall Minneapolls,MN 55401", isHaz: false, isPol: false, isSecKey: false, isCash: false, arrears : 876, latitude : 12.933232, longitude: 77.6292620,isCompleted : false,completedDate:"11-Dec-2014 9:00AM")
        AppUtil.APP_DELEGATE().TodayTaskList.append(taskObject)
        
        //modify array based on the array account name match string
        
        strCompileTodayTask = strSelectedText
        var arrAllTasks : NSMutableArray! = NSMutableArray()
        arrAllTasks.addObjectsFromArray(AppUtil.APP_DELEGATE().TodayTaskList)
        arrAllTasks.filterUsingPredicate(NSPredicate(format: "accountNo CONTAINS[c] \"\(strSelectedText.lowercaseString)\"")!)
        
        //        AppUtil.APP_DELEGATE().TodayTaskList.removeAll(keepCapacity: false)
        
        AppUtil.APP_DELEGATE().TodayTaskList = nil
        
        AppUtil.APP_DELEGATE().TodayTaskList = []
        var index : Int! = 0
        var i : Int! = 0
        
        if arrAllTasks.count > 0
        {
            
            for i in 0...arrAllTasks.count-1
            {
                var taskObject : TodayTask = arrAllTasks.objectAtIndex(index) as TodayTask
                index = index + 1
                AppUtil.APP_DELEGATE().TodayTaskList.append(taskObject)
            }
        }
        
        openTaskArray = AppUtil.APP_DELEGATE().TodayTaskList.filter({ obj in !obj.isCompleted })
        todaysTask = openTaskArray
        closedTaskArray = AppUtil.APP_DELEGATE().TodayTaskList.filter({ obj in obj.isCompleted })
        
    }
    func getOpenOrderList() -> Array<TodayTask>
    {
        return openTaskArray
    }



}

