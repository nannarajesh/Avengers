//
//  TableQuestionViewController.swift
//  CaresDemo
//
//  Created by Administrator on 13/11/14.
//  Copyright (c) 2014 Nirupama Miriam Abraham. All rights reserved.
//

import UIKit

protocol TableViewSelectorDelegate {
    func tableViewSelectedValues(arrSelectedValues: NSMutableArray?, segueName: NSString?)
}

class TableQuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var tblSepList: UITableView!
    var delegate : TableViewSelectorDelegate?
    var segueName: NSString?
    var arrAllValues: NSMutableArray?
    var arrSelectedValues: NSMutableArray?
    var isMultipleSelection: Bool?
    var indexPathSelected : NSIndexPath?
    
    @IBOutlet weak var btnDone: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredContentSize = CGSize(width: 250,height: 300)
        
        // Do any additional setup after loading the view.
        
        
        
    }
    
    @IBAction func btnDoneTouchUpInside(sender: AnyObject) {
        if delegate != nil {
            delegate!.tableViewSelectedValues(arrSelectedValues, segueName: segueName)
        }
    
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    func reloadAllData(){
//        println("arrAllValues count: \(arrAllValues!.count) arrSelectedValues count: \(arrSelectedValues!.count)")
        
        if tblSepList != nil
        {
            tblSepList!.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAllValues!.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        
        var strTitle : String = arrAllValues!.objectAtIndex(indexPath.row) as String
        
        let indexNumber : Int = arrSelectedValues!.indexOfObject(strTitle)
        if isMultipleSelection == true {
        if indexNumber >= 0 && indexNumber < arrSelectedValues!.count {
//            cell?.accessoryType = UITableViewCellAccessoryType.UITableViewCellAccessoryCheckmark
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        }
        else
        {
            if indexPath == indexPathSelected
            {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
        }
        cell.textLabel?.text = strTitle
       
        cell.textLabel?.font = UIFont(name: "HelveticaNeue", size: 14.0)
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var strTitle : String = arrAllValues!.objectAtIndex(indexPath.row) as String
        
        
        let indexNumber : Int = arrSelectedValues!.indexOfObject(strTitle)
        
        if isMultipleSelection == true {
            if indexNumber >= 0 && indexNumber < arrSelectedValues!.count {
                arrSelectedValues!.removeObjectAtIndex(indexNumber)
            }
            else
            {
                arrSelectedValues!.addObject(strTitle)
            }
        }
        else {
                indexPathSelected = indexPath
                arrSelectedValues?.removeAllObjects()
                arrSelectedValues!.addObject(strTitle)
        }
        
        if delegate != nil {
            //delegate!.tableViewSelectedValues(arrSelectedValues, segueName: segueName)
        }
        
        tableView.reloadData()
    }
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
