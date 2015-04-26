//
//  MasterViewController.swift
//  Housing4PK
//
//  Created by Administrator on 25/04/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    
    var arrayServiceType = ["rent@2x.png","pg_hostels@2x.png","buy@2x.png","new_projects@2x.png","tweets@2x.png","post_request@2x.png","vaastu@2x.png", "about_us@2x.png"]
    
//    var objects = NSMutableArray()

    var checkedIndexRow : Int = 0
    var imgSelectedArrow : UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clearsSelectionOnViewWillAppear = false
        self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blue@2x.png")!)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.splitViewController?.maximumPrimaryColumnWidth = 120

//        imgSelectedArrow = UIImageView(frame: CGRect(x: 100, y: (AppUtil.APP_DELEGATE().selectedIndex*121)-60, width: 30, height: 30))
//        imgSelectedArrow?.image = UIImage(named: "arrow-right.png")
        
        imgSelectedArrow = UIImageView(frame: CGRect(x: 100+5, y: (AppUtil.APP_DELEGATE().selectedIndex*121)-70, width: 20, height: 20))
        imgSelectedArrow!.backgroundColor = UIColor.whiteColor()
//        imgSelectedArrow!.image = UIImage(named: "rightArrow.png")
        self.tableView.addSubview(imgSelectedArrow!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
//    func insertNewObject(sender: AnyObject) {
//        objects.insertObject(NSDate(), atIndex: 0)
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let controller2 = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
//            controller2.delegate = self
            var indexPath = self.tableView.indexPathForSelectedRow()!
            controller2.selectedSequenceCategoryIndex = indexPath.row
//            controller2.context = self.context
            checkedIndexRow = indexPath.row
//            controller2.tableView.reloadData()
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayServiceType.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        AppUtil.APP_DELEGATE().selectedIndex = indexPath.row + 1
        if indexPath.row == 5
        {
            self.performSegueWithIdentifier("reportSegue", sender: self)
        }
        else if indexPath.row == 4
        {
            self.performSegueWithIdentifier("tweetSegue", sender: self)
        }
        else if indexPath.row == 6
        {
            //vaastu
            self.performSegueWithIdentifier("vaastuSeque", sender: self)
        }
        else if indexPath.row == 7
        {
            //about us
            self.performSegueWithIdentifier("aboutUsSeque", sender: self)
        }
        else
        {
            self.performSegueWithIdentifier("showDetail", sender: self)
        }
        
        self.moveSelectedRow()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MasterTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as MasterTableViewCell
        cell.imgIcon.image = UIImage(named: arrayServiceType[indexPath.row])
//        cell.lblTitle.text = arrayServiceType[indexPath.row]
        
        if indexPath.row + 1 == AppUtil.APP_DELEGATE().selectedIndex
        {
            cell.imgIcon.layer.borderColor = UIColor.whiteColor().CGColor
            cell.imgIcon.layer.borderWidth = 2.0
        }
        else
        {
            cell.imgIcon.layer.borderColor = UIColor.grayColor().CGColor
            cell.imgIcon.layer.borderWidth = 1.0
        }
        
        cell.animateBackgroundImages()
        return cell
    }

    func moveSelectedRow()
    {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.imgSelectedArrow!.frame = CGRect(x: 100+5, y: (AppUtil.APP_DELEGATE().selectedIndex*121)-70, width: 20, height: 20)
            }) { (success : Bool) -> Void in
            
                self.tableView.reloadData()
        }
    }
}

