//
//  DetailViewController.swift
//  Housing4PK
//
//  Created by Administrator on 25/04/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit
import MapKit

var todaysTask = AppUtil.APP_DELEGATE().openTaskArray

var tempAnnotation:CustomPointAnnotation = CustomPointAnnotation()
var tempview:MKAnnotationView = MKAnnotationView()

//UITableViewDataSource,UITableViewDelegate

public extension Int {
    /**
    Create a random num Int
    :param: lower number Int
    :param: upper number Int
    :return: random number Int
    By DaRkDOG
    */
    public static func random (#lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(upper - lower + 1))
    }
    
}


class DetailViewController: BaseViewController, TableViewSelectorDelegate, UITextFieldDelegate, MKMapViewDelegate,CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var btnList: UIButton!
    @IBOutlet weak var btnMap: UIButton!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var mapVw: MKMapView!
//    @IBOutlet weak var tblSegmentView: UITableView!
    @IBOutlet weak var tblSegmentView: UICollectionView!
    
//    @IBOutlet weak var vwBlueArrow: UIImageView!
    var timerGlobal : NSTimer?


    var locationManager:CLLocationManager!
    var nearLocations : NSMutableArray = NSMutableArray()
    var custLocations : NSMutableArray = NSMutableArray()
    var nearlatArray : Array<CGFloat> = [-0.02,-0.02,0.01,0.03,0.02]
    var nearlongArray : Array<CGFloat> = [-0.02,0.04,0.04,0.03,-0.02]
//    var locationManager:CLLocationManager!
    var annotation = MKPointAnnotation()
    var currentLocation:CLLocation=CLLocation();
    var selectedString:String!

    var selectedSequenceCategoryIndex: Int = 0
    var selectedValueIndexRow : NSIndexPath!
    var currentTablePopover: UIPopoverController! = nil
    var selectedLabel : UILabel?

    var isInSearchMode: Bool!
    var selectedButton : UIButton?
    
    @IBOutlet weak var btnSecond : UIButton?
    @IBOutlet weak var btnFirst : UIButton?
    
//    var arrData : NSMutableArray!
    var arrSearchResults : NSMutableArray!
    var arrType = ["2 BHK Unfurnished","2 BHK Unfurnished","2 BHK Unfurnished","2 BHK Unfurnished","2 BHK Unfurnished","2 BHK Unfurnished","2 BHK Unfurnished","2 BHK Unfurnished"]
    var arrAddress = ["Yelahanka, Bangalore","Yelahanka, Bangalore","Jogupalaya , Bangalore","Pennya, Bangalore","Kothanur, Bangalore","Lingrajapuram, Bangalore","Shivaji Nagar, Bangalore","Muneshwara Nagar, Bangalore"]
    var arrPrice = ["12,000","11,000","12,000","14,000","12,000","11,000","12,000","17,000"]
    var arrImages = []
    
    func tableViewSelectedValues(arrSelectedValues: NSMutableArray?, segueName: NSString?)
    {
        var count = arrSelectedValues?.count
        
        if count > 0{
            selectedLabel?.text = arrSelectedValues!.objectAtIndex(0) as? String
            
            if arrSelectedValues?.count > 1{
                for i in 1...count!-1 {
                    selectedLabel!.text = selectedLabel!.text! + "," + (arrSelectedValues!.objectAtIndex(i) as? String)!
                }
            }
        }
        else
        {
            selectedLabel?.text = ""
        }
    }

    func configureView() {
        
        switch selectedSequenceCategoryIndex{
        case 0:
            detailDescriptionLabel.text = "Map Based Search. 100% verified listings. Real property pictures"
            navItem.title = "LOOK UP PLACES TO RENT"
        case 1:
            detailDescriptionLabel.text = ""
            navItem.title = "LOOK UP PGs AND HOSTELS"
        case 2:
            detailDescriptionLabel.text = "Explore your neighbourhood. 100% verified listings. Real property pictures"
            navItem.title = "LOOK UP A PLACE TO BUY"

        case 3:
            detailDescriptionLabel.text = ""
            navItem.title = "LOOK UP NEW PROJECTS"

        case 4:
            detailDescriptionLabel.text = ""
            navItem.title = "LOOK UP SERVICED APARTMENTS"
            
        case 5:
            detailDescriptionLabel.text = "3 Lac Active Home Seekers. 1.4 lac Satisfied Owners. 4 Lac Properties Viewed Daily"
            navItem.title = "TO SELL OR RENT"

        default: detailDescriptionLabel.text = ""
        }
//        txtSearch.layer.borderWidth = 1.0
//        txtSearch.layer.cornerRadius = 5.0
//        txtSearch.layer.borderColor = UIColor.whiteColor().CGColor
        
        locationManager=CLLocationManager()
        locationManager.delegate = self;
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        locationManager.startUpdatingLocation();
        //currentLocation = CLLocation(latitude: 37.331789, longitude: -122.029620)
        
        currentLocation = CLLocation(latitude: 12.933740189995227, longitude: 77.61455302932563)
        
        
        var latitude:CLLocationDegrees = 12.933740189995227
        var longitude:CLLocationDegrees = 77.61455302932563
        
        var spanlat:CLLocationDegrees=0.015
        var spanlong:CLLocationDegrees=0.015
        
        var span:MKCoordinateSpan=MKCoordinateSpanMake(spanlat, spanlong);
        
        var location:CLLocationCoordinate2D=CLLocationCoordinate2DMake(latitude,longitude)
        
        var region:MKCoordinateRegion=MKCoordinateRegionMake(location, span)
        
        self.mapVw.setRegion(region, animated:true)

        annotation.coordinate = location
        mapVw.addAnnotation(annotation)
        selectedString = "Current"
        AppUtil.APP_DELEGATE().CompileTodayTaskList(selectedString)
        if todaysTask.count > 0
        {
            for arr in 0...todaysTask.count - 1
            {
                var nearAnnotation = CustomPointAnnotation()
                nearAnnotation.coordinate = CLLocationCoordinate2DMake(todaysTask[arr].latitude , todaysTask[arr].longitude)
                nearAnnotation.title = NSString(format: "%d", arr + 1)
                
                nearAnnotation.isHazard = todaysTask[arr].isHazard
                nearAnnotation.isPolice = todaysTask[arr].isPolice
                nearAnnotation.isKey = todaysTask[arr].isSecurityKey
                nearAnnotation.isCash = todaysTask[arr].isCash
                nearAnnotation.isCompleted = todaysTask[arr].isCompleted
                
                nearLocations.addObject(nearAnnotation)
            }
            
            self.mapVw.addAnnotations(nearLocations)
            self.mapVw.addAnnotation(annotation)
            
            self.mapVw.showAnnotations(self.mapVw.annotations, animated: true)
        }

        // Update the user interface for the detail item.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
        
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapVw.delegate = self
        mapVw.showsUserLocation = true
        //AppUtil.APP_DELEGATE().CompileTodayTaskList(selectedString)
        
        arrSearchResults = NSMutableArray()

        isInSearchMode = false
        self.tblSegmentView.reloadData()
        
        mapVw.hidden = true
        self.tblSegmentView.hidden = true
        
        btnFirst?.selected = false
        
        btnMap?.selected = true
        btnList?.selected = false
        
//        lblFirst.layer.borderWidth = 1.0
//        lblFirst.layer.cornerRadius = 5.0
//        lblFirst.layer.borderColor = UIColor.grayColor().CGColor
//        lblSecond.layer.borderWidth = 1.0
//        lblSecond.layer.cornerRadius = 5.0
//        lblSecond.layer.borderColor = UIColor.grayColor().CGColor
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        btnList.backgroundColor = UIColor(patternImage: UIImage(named: "blue.png")!)
        btnMap.backgroundColor = UIColor(patternImage: UIImage(named: "blue.png")!)
        
        self.configureView()
        
//        btnList.layer.borderWidth = 3.0
//        btnList.layer.borderColor = UIColor(patternImage: UIImage(named: "color6.png")!).CGColor
//        
//        btnMap.layer.borderWidth = 3.0
//        btnMap.layer.borderColor = UIColor(patternImage: UIImage(named: "color7.png")!).CGColor
        
        self.tblSegmentView.hidden = false
        mapVw.hidden = true
        
        
//        txtSearch.attributedPlaceholder = NSAttributedString(string:"Enter Search Text",
//            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])

        txtSearch.attributedPlaceholder = NSAttributedString(string: "Enter Search Text",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 13.0)!])
        
        
        
        switch AppUtil.APP_DELEGATE().selectedIndex
        {
        case 1:
            println("Rent")
            lblSecond.text = "Range"
        case 2:
            println("PG")
            lblSecond.text = "Gender"
        case 3:
            println("Buy")
            lblSecond.text = "Range"
        case 4:
            println("New Projects")
            lblSecond.text = "Range"
        case 5:
            println("Tweet")
            lblSecond.text = "Range"
        case 6:
            println("Post Request")
            lblSecond.text = "Range"
        default:
            println("first index")
        }
        
        selectedButton = btnList
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        isInSearchMode = true
        
        //fitler and reload
        self.filterAndReload()
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        isInSearchMode = true
        //filter and reload
        
//        self.filterAndReload(textField.text + string)
        
//        if string == ""
//        {
//            tblSegmentView.hidden = true
//        }
//        else
//        {
//            tblSegmentView.hidden = false
//        }
        
        
        if timerGlobal != nil
        {
            timerGlobal?.invalidate()
            timerGlobal = nil
        }
        
        timerGlobal = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "filterAndReload", userInfo: nil, repeats: false)
        
        return true
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true

    }
    
    @IBAction func btnSearchTapped(sender: AnyObject)
    {
//        if btnFirst?.selected == true
//        {
//            println("selected true")
//        }
//        else
//        {
        
            println("selected false")

            isInSearchMode = true
        //filter and reload
        self.filterAndReload()
        //tblSegmentView.hidden = true
        txtSearch.resignFirstResponder()
        
        
        locationManager=CLLocationManager()
        locationManager.delegate = self;
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        selectedString = txtSearch.text
        AppUtil.APP_DELEGATE().CompileTodayTaskList(selectedString)
        locationManager.startUpdatingLocation();
        //currentLocation = CLLocation(latitude: 37.331789, longitude: -122.029620)
        
        currentLocation = CLLocation(latitude: 13.03, longitude: 77.65)
        
        mapVw.removeAnnotations(mapVw.annotations)
        
        var latitude:CLLocationDegrees = 13.03
        var longitude:CLLocationDegrees = 77.65
        
        var spanlat:CLLocationDegrees=0.015
        var spanlong:CLLocationDegrees=0.015
        
        var span:MKCoordinateSpan=MKCoordinateSpanMake(spanlat, spanlong);
        
        var location:CLLocationCoordinate2D=CLLocationCoordinate2DMake(latitude,longitude)
        
        var region:MKCoordinateRegion=MKCoordinateRegionMake(location, span)
        
        self.mapVw.setRegion(region, animated:true)
        
        annotation.coordinate = location
        mapVw.addAnnotation(annotation)
        if todaysTask.count > 0
        {
            for arr in 0...todaysTask.count - 1
            {
                var nearAnnotation = CustomPointAnnotation()
                nearAnnotation.coordinate = CLLocationCoordinate2DMake(todaysTask[arr].latitude , todaysTask[arr].longitude)
                nearAnnotation.title = NSString(format: "%d", arr + 1)

                nearAnnotation.isHazard = todaysTask[arr].isHazard
                nearAnnotation.isPolice = todaysTask[arr].isPolice
                nearAnnotation.isKey = todaysTask[arr].isSecurityKey
                nearAnnotation.isCash = todaysTask[arr].isCash
                nearAnnotation.isCompleted = todaysTask[arr].isCompleted

                nearLocations.addObject(nearAnnotation)
            }
            self.mapVw.addAnnotations(nearLocations)
            self.mapVw.addAnnotation(annotation)

        }
//        }
    }
    
    @IBAction func segControl(sender: AnyObject) {
        
        var btnSender : UIButton = sender as UIButton
        selectedButton = btnSender
        
        
        if btnSender == btnList
        {
            btnMap?.selected = true
            btnList?.selected = false

            btnList.titleLabel?.textColor = UIColor.whiteColor()
            btnMap.titleLabel?.textColor = UIColor.blackColor()
            
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                
//                self.vwBlueArrow.frame = CGRect(x: 259, y: 221, width: 31, height: 25)
//            })
            
            
            btnFirst?.setBackgroundImage(UIImage(named: "blue.png"), forState: UIControlState.Selected)
            btnFirst?.setBackgroundImage(UIImage(named: "blue.png"), forState: UIControlState.Normal)

            btnFirst?.selected = false
            
//            btnList.layer.borderWidth = 3.0
//            btnList.layer.borderColor = UIColor(patternImage: UIImage(named: "color6.png")!).CGColor
//            
//            btnMap.layer.borderWidth = 3.0
//            btnMap.layer.borderColor = UIColor(patternImage: UIImage(named: "color7.png")!).CGColor


//            UIView.animateWithDuration(0.5, animations: { () -> Void in
//                self.vwBlueArrow.frame = CGRect(x: 259, y: 221, width: 31, height: 25)
//            })
            
            

            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.btnSecond?.hidden = false
                self.btnFirst?.hidden = false
                
                self.lblSecond.hidden = false
                self.lblFirst.hidden = false
                
                self.btnSecond?.frame = CGRect(x: 531, y: 117, width: 102, height: 40)
                self.btnFirst?.frame = CGRect(x: 416, y: 117, width: 102, height: 40)
                
                self.lblFirst.frame = CGRect(x: 428, y: 118, width: 88, height: 40)
                self.lblSecond.frame = CGRect(x: 545, y: 118, width: 88, height: 40)
                
                self.lblFirst.numberOfLines = 2
                self.lblFirst.text = "2 BHK"

            })
            
            self.tblSegmentView.hidden = false
            mapVw.hidden = true

        }
        else
        {
            
            btnMap?.selected = false
            btnList?.selected = true
            
            btnList.titleLabel?.textColor = UIColor.blackColor()
            btnMap.titleLabel?.textColor = UIColor.whiteColor()

//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                
//                //self.vwBlueArrow.frame = CGRect(x: 639, y: 221, width: 31, height: 25)
//            })
            
            
            
            btnFirst?.setBackgroundImage(UIImage(named: "color10.png"), forState: UIControlState.Selected)
            btnFirst?.setBackgroundImage(UIImage(named: "blue.png"), forState: UIControlState.Normal)
            
            btnFirst?.selected = true
            

            self.mapVw.showAnnotations(self.mapVw.annotations, animated: true)

            var latitude:CLLocationDegrees = 12.933740189995227
            var longitude:CLLocationDegrees = 77.61455302932563
            
            var spanlat:CLLocationDegrees=0.015
            var spanlong:CLLocationDegrees=0.015
            
            var span:MKCoordinateSpan=MKCoordinateSpanMake(spanlat, spanlong);
            
            var location:CLLocationCoordinate2D=CLLocationCoordinate2DMake(latitude,longitude)
            
            var region:MKCoordinateRegion=MKCoordinateRegionMake(location, span)
            
            self.mapVw.setRegion(region, animated:true)

            
//            btnList.layer.borderWidth = 3.0
//            btnList.layer.borderColor = UIColor(patternImage: UIImage(named: "color7.png")!).CGColor
//            
//            btnMap.layer.borderWidth = 3.0
//            btnMap.layer.borderColor = UIColor(patternImage: UIImage(named: "color6.png")!).CGColor

           
//            UIView.animateWithDuration(0.5, animations: { () -> Void in
//                self.vwBlueArrow.frame = CGRect(x: 639, y: 221, width: 31, height: 25)
//            })
            
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in

                
                self.btnSecond?.frame = CGRect(x: 531, y: 117, width: 0, height: 0)
                self.btnFirst?.frame = CGRect(x: 416, y: 117, width: 102+100, height: 40)
                
                self.lblFirst.frame = CGRect(x: 428, y: 118, width: 88+100, height: 40)
                self.lblSecond.frame = CGRect(x: 545, y: 118, width: 0, height: 0)
                
                
                self.btnSecond?.hidden = true
                self.btnFirst?.hidden = false
                
                self.lblSecond.hidden = true
                self.lblFirst.hidden = false
                
                
                self.lblFirst.numberOfLines = 2
                self.lblFirst.text = "Enter Zipper\n Code"
            })
            
            self.tblSegmentView.hidden = true
            self.mapVw.hidden = false

        }
    }

    @IBAction func btnFirstTapped(sender: AnyObject) {
        
        btnFirst!.selected = !btnFirst!.selected
        
        if selectedButton == btnMap
        {
            println("map clicked")
        }
        else
        {
        
        var tableQuestionVC : TableQuestionViewController?
        
        if !(tableQuestionVC != nil)
        {
            tableQuestionVC = self.storyboard?.instantiateViewControllerWithIdentifier("tableQuestionVC") as TableQuestionViewController?
            tableQuestionVC!.delegate = self
        }
        
        tableQuestionVC!.delegate = self
        tableQuestionVC!.arrAllValues = NSMutableArray(array: DropDownArrayData.getBHK())
        tableQuestionVC!.arrSelectedValues = NSMutableArray(objects: " ")
        selectedLabel = lblFirst
        tableQuestionVC!.isMultipleSelection = false
        //         destController.delegate = self
        tableQuestionVC!.reloadAllData()
        if currentTablePopover != nil {
            currentTablePopover.dismissPopoverAnimated(true)
            currentTablePopover = nil
        }
        
        currentTablePopover = UIPopoverController(contentViewController: tableQuestionVC!)
        currentTablePopover.presentPopoverFromRect(sender.frame, inView: (sender as UIButton).superview!, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        currentTablePopover.popoverContentSize = CGSizeMake(320, 182)
        }
    }
    
    @IBAction func btnSecondTapped(sender: AnyObject) {
        var tableQuestionVC : TableQuestionViewController?
        
        if !(tableQuestionVC != nil)
        {
            tableQuestionVC = self.storyboard?.instantiateViewControllerWithIdentifier("tableQuestionVC") as TableQuestionViewController?
            tableQuestionVC!.delegate = self
        }
        
        tableQuestionVC!.delegate = self
        
        var arrSearchObj : NSArray?
        switch AppUtil.APP_DELEGATE().selectedIndex
        {
        case 1:
            println("Rent")
            lblSecond.text = "Range"
            arrSearchObj = DropDownArrayData.getBudget()
        case 2:
            println("PG")
            lblSecond.text = "Gender"
            arrSearchObj = DropDownArrayData.getGender()
        case 3:
            println("Buy")
            lblSecond.text = "Range"
            arrSearchObj = DropDownArrayData.getBuy()
        case 4:
            println("New Projects")
            lblSecond.text = "Project Name"
            arrSearchObj = DropDownArrayData.getProjectName()
        case 5:
            println("Tweet")
            lblSecond.text = "Range"
            arrSearchObj = DropDownArrayData.getBudget()
        case 6:
            println("Post Request")
            lblSecond.text = "Range"
            arrSearchObj = DropDownArrayData.getBudget()
        default:
            println("first index")
            arrSearchObj = DropDownArrayData.getBudget()
        }
        
        
        tableQuestionVC!.arrAllValues = NSMutableArray(array: arrSearchObj!)
        tableQuestionVC!.arrSelectedValues = NSMutableArray(objects: " ")
        selectedLabel = lblSecond
        tableQuestionVC!.isMultipleSelection = false
        //         destController.delegate = self
        tableQuestionVC!.reloadAllData()
        if currentTablePopover != nil {
            currentTablePopover.dismissPopoverAnimated(true)
            currentTablePopover = nil
        }
        
        currentTablePopover = UIPopoverController(contentViewController: tableQuestionVC!)
        currentTablePopover.presentPopoverFromRect(sender.frame, inView: (sender as UIButton).superview!, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        currentTablePopover.popoverContentSize = CGSizeMake(320, 182)

    }
    
    func filterAndReload()
    {
        if timerGlobal != nil
        {
            timerGlobal?.invalidate()
            timerGlobal = nil
        }
         
        arrSearchResults.removeAllObjects()
        
        if txtSearch.text == ""
        {
            arrSearchResults.addObjectsFromArray(AppUtil.APP_DELEGATE().arrProperties!)
        }
        else {
            
            var arrComp : NSArray? = txtSearch.text.componentsSeparatedByString(",")
            var strSearchText : String = ""
            
            
            if arrComp != nil && arrComp?.count > 0
            {
                strSearchText = arrComp?.objectAtIndex(0) as String
            }
            
            var filteredArray : NSArray! = AppUtil.APP_DELEGATE().arrProperties!.filteredArrayUsingPredicate(NSPredicate(format: "strBHKType CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strAddress CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strPropertyType CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strArea CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strLease CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strFacing CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strBathrooms CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strPowerBackup CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strAdded CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strAvailability CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strPrice CONTAINS[c] \"\(strSearchText.lowercaseString)\"")!)
            
            if filteredArray == nil || filteredArray?.count == 0
            {
                if arrComp != nil && arrComp?.count > 1
                {
                    strSearchText = arrComp?.objectAtIndex(1) as String
                }
                
                var filteredArray : NSArray! = AppUtil.APP_DELEGATE().arrProperties!.filteredArrayUsingPredicate(NSPredicate(format: "strBHKType CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strAddress CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strPropertyType CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strArea CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strLease CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strFacing CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strBathrooms CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strPowerBackup CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strAdded CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strAvailability CONTAINS[c] \"\(strSearchText.lowercaseString)\" OR strPrice CONTAINS[c] \"\(strSearchText.lowercaseString)\"")!)
                
                if filteredArray != nil && filteredArray?.count > 0
                {
                    arrSearchResults.addObjectsFromArray(filteredArray)
                }
                else
                {
                    println("no results found")
                }
            }
            else
            {
                arrSearchResults.addObjectsFromArray(filteredArray)
            }
        }
        
        self.tblSegmentView.reloadData()
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var rows : Int = 0
        if isInSearchMode == true
        {
            rows = arrSearchResults.count
        }
        else
        {
            rows = AppUtil.APP_DELEGATE().arrProperties!.count
        }
        
        return rows
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var objProperty : Property!
        

        if isInSearchMode == true
        {
            objProperty = arrSearchResults!.objectAtIndex(indexPath.row) as? Property
        }
        else
        {
            objProperty = AppUtil.APP_DELEGATE().arrProperties!.objectAtIndex(indexPath.row) as? Property
        }
        
        let cell : PropertyListCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as PropertyListCollectionViewCell
        
        
        var totalImageCount : Int = objProperty.arrImages!.count-1
        
        var randomImageNumber = Int.random(lower: 0, upper: totalImageCount)

        cell.imgLogo.image = objProperty.arrImages![randomImageNumber] as? UIImage
        
//        cell.imgLogo.animationImages = objProperty.arrImages
//        cell.imgLogo.animationDuration = 10.0
//        cell.imgLogo.startAnimating()
        
        cell.lblPropertyType.text = objProperty.strPropertyType
        cell.lblPrice.text = objProperty.strPrice
        cell.lblBed.text = objProperty.strBHKType
        cell.lblAddress.text = objProperty.strAddress
        cell.lblArea.text = objProperty.strArea
        
       //cell.imgLogo?.alpha = 1.0
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            (cell as PropertyListCollectionViewCell).imgLogo!.alpha = 0.0
            
            }, completion: { (success : Bool) -> Void in
               (cell as PropertyListCollectionViewCell).imgLogo!.alpha = 1.0
        })

        
    }
    
     func scrollViewDidScroll(scrollView: UIScrollView) {
        
//        UIView.animateWithDuration(0.5, animations: { () -> Void in
//            for cell in self.tblSegmentView?.visibleCells() as [PropertyListCollectionViewCell] {
//                cell.imgLogo!.alpha = 0.0
//            }
//            
//            }, completion: { (success : Bool) -> Void in
//                for cell in self.tblSegmentView?.visibleCells() as [PropertyListCollectionViewCell] {
//                    cell.imgLogo!.alpha = 1.0
//                }
//        })
        
        
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       
        var didSelectVC : DidSelectViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DidSelectViewController") as DidSelectViewController
        didSelectVC.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        
        var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var objPropertyRef : Property?
        
        if isInSearchMode == true
        {
            objPropertyRef = arrSearchResults[indexPath.row] as? Property
        }
        else
        {
            objPropertyRef = appDelegate.arrProperties![indexPath.row] as? Property
        }
        
        didSelectVC.objProperty = objPropertyRef

        didSelectVC.textType = objPropertyRef?.strBHKType
        
        didSelectVC.textAddress = objPropertyRef?.strAddress
        didSelectVC.textPrice = objPropertyRef?.strPrice
        self.presentViewController(didSelectVC, animated: true, completion: nil)
    }

func mapView(mapView: MKMapView!, viewForAnnotation annotation: CustomPointAnnotation!) -> MKAnnotationView! {
        let reuseId="annotation"
        var custom=mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        custom = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        //custom = CustomAnnotation(annotation: annotation, reuseIdentifier: reuseId)
        custom.canShowCallout=false
        custom.annotation=annotation
        var view = CustomView(frame : CGRectMake(0, 0, 30, 40))
        view.backgroundColor = UIColor.clearColor()
        if (currentLocation.coordinate.latitude == custom.annotation.coordinate.latitude && currentLocation.coordinate.longitude == custom.annotation.coordinate.longitude)
        {
            custom.image = UIImage(named: "icon-map.png")
                
            
            //            view.imageView.image = UIImage(named: "icon-map.png")
            //            custom.addSubview(view)
        }
        else if annotation.title != nil && annotation.title != "Current Location"
        {
            view.lblText.text = annotation.title
            
            if annotation.isCash == true
            {
                view.lblCash.text = "$"
            }
            
            if annotation.isHazard == true
            {
                custom.image = UIImage.createAvatar(UIImage.resizeImage(UIImage(named: "property_image1.png")!, sizeChange: CGSize(width: 150, height: 150)), ringColor: UIColor(patternImage: UIImage(named: "blue.png")!))
                
                //view.imageView.image = UIImage(named: "icon-map-red.png")
            }
            else if annotation.isPolice == true
            {
                custom.image = UIImage.createAvatar(UIImage.resizeImage(UIImage(named: "property_image2.png")!, sizeChange: CGSize(width: 150, height: 150)), ringColor: UIColor(patternImage: UIImage(named: "blue.png")!))
                //view.imageView.image = UIImage(named: "icon-map-red.png")
            }
            else if annotation.isKey == true
            {
                custom.image = UIImage.createAvatar(UIImage.resizeImage(UIImage(named: "property_image3.png")!, sizeChange: CGSize(width: 150, height: 150)), ringColor: UIColor(patternImage: UIImage(named: "blue.png")!))
                //view.imageView.image = UIImage(named: "icon-map-red.png")
            }
            else if annotation.isCompleted == true
            {
                custom.image = UIImage.createAvatar(UIImage.resizeImage(UIImage(named: "property_image4.png")!, sizeChange: CGSize(width: 150, height: 150)), ringColor: UIColor(patternImage: UIImage(named: "blue.png")!))
                
            }
            else
            {
                custom.image = UIImage.createAvatar(UIImage.resizeImage(UIImage(named: "property_image5.png")!, sizeChange: CGSize(width: 150, height: 150)), ringColor: UIColor(patternImage: UIImage(named: "blue.png")!))
                //view.imageView.image = UIImage(named: "icon-map-red.png")
            }
            
            if annotation.isCompleted == true
            {
                custom.image = UIImage.createAvatar(UIImage.resizeImage(UIImage(named: "property_image6.png")!, sizeChange: CGSize(width: 150, height: 150)), ringColor: UIColor(patternImage: UIImage(named: "blue.png")!))
            }
            
            custom.addSubview(view)
            
        }
        
        //        var point = mapView.convertCoordinate(annotation.coordinate, toPointToView: self.view)
        //        var customerNo : UILabel = UILabel(frame: CGRectMake(point.x, point.y, 20, 10))
        //        customerNo.text = "1"
        //        customerNo.textColor = UIColor.blackColor()
        //        mapView.addSubview(customerNo)
        
        custLocations.addObject(custom)
        
        return custom
    }
    
    func selectAnnotation()
    {
//        if AppUtil.APP_DELEGATE().selectedController != nil
////        {
//            var selectedAnnotation: MKAnnotation!
//            var customer = AppUtil.APP_DELEGATE().selectedCustomer as TodayTask
//            
//            for arr in nearLocations
//            {
//                selectedAnnotation = arr as MKAnnotation
//                if ((selectedAnnotation.coordinate.latitude == customer.latitude) && (selectedAnnotation.coordinate.longitude == customer.longitude))
//                {
//                    break
//                }
//            }
//            
//            //annView = custLocations[1] as MKAnnotationView
//            
//            var popOver : PopOverViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PopOverViewController") as PopOverViewController
//            popOver.hazard = true
//            //popOver.police = true
//            popOver.keys = true
//            popOver.controller = self
//            popOver.selectedAnnotation = selectedAnnotation
//            
//            var ann : CLLocationCoordinate2D = CLLocationCoordinate2DMake(customer.latitude , customer.longitude)
//            
//            var point = mapView.convertCoordinate(ann, toPointToView: self.view)
//            var rect = CGRect(x: point.x, y: point.y, width: 0, height: 0)
//            
//            popover = UIPopoverController(contentViewController: popOver)
//            popover?.presentPopoverFromRect(rect, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
//            popover?.popoverContentSize = CGSizeMake(400, 550)
//            
//        }
        
    }

    
    func mapViewDidFinishLoadingMap(mapView: MKMapView!) {
        //first = false
        selectAnnotation()
    }
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        if view.annotation.title != nil
        {
            var indexPathRow : Int!

            
            if view.annotation.isKindOfClass(CustomPointAnnotation) {
                indexPathRow = (view.annotation.title!).toInt()
                tempview = view
                tempAnnotation = view.annotation as CustomPointAnnotation
                
                var didSelectVC : DidSelectViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DidSelectViewController") as DidSelectViewController
                didSelectVC.modalPresentationStyle = UIModalPresentationStyle.FormSheet
                //            var indexPathRow = tableView.indexPathForSelectedRow()!.row
                
                if indexPathRow != nil
                {
                    didSelectVC.textType = arrType[indexPathRow!]
                    didSelectVC.textAddress = arrAddress[indexPathRow!]
                    didSelectVC.textPrice = arrPrice[indexPathRow!]
                    
                    didSelectVC.objProperty = AppUtil.APP_DELEGATE().arrProperties![0] as? Property
                    self.presentViewController(didSelectVC, animated: true, completion: nil)
                    
                }
            }
        }
    }
}

