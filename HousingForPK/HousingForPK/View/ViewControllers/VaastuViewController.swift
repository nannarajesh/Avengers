//
//  VaastuViewController.swift
//  HousingForPK
//
//  Created by Rajesh Nanna on 26/04/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit

class VaastuViewController: BaseViewController, TableViewSelectorDelegate {
    var currentTablePopover: UIPopoverController! = nil
    var selectedTextField : UITextField?
    @IBOutlet var txtFieldVaastu : UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnOpenCameraTouchUpInside(sender: UIButton) {
        
        //UIAlertView(title: "Alert!", message: "This feature is in progress.", delegate: nil, cancelButtonTitle: "Ok")
        
        var tableQuestionVC : TableQuestionViewController?
        
        if !(tableQuestionVC != nil)
        {
            tableQuestionVC = self.storyboard?.instantiateViewControllerWithIdentifier("tableQuestionVC") as TableQuestionViewController?
            tableQuestionVC!.delegate = self
        }
        
        tableQuestionVC!.delegate = self
        tableQuestionVC!.arrAllValues = NSMutableArray(array: DropDownArrayData.getVaastuPlaces())
        tableQuestionVC!.arrSelectedValues = NSMutableArray(objects: " ")
        selectedTextField = txtFieldVaastu
        tableQuestionVC!.isMultipleSelection = true
        
        tableQuestionVC!.reloadAllData()
        if currentTablePopover != nil {
            currentTablePopover.dismissPopoverAnimated(true)
            currentTablePopover = nil
        }
        
        currentTablePopover = UIPopoverController(contentViewController: tableQuestionVC!)
        currentTablePopover.presentPopoverFromRect(sender.frame, inView: (sender as UIButton).superview!, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        currentTablePopover.popoverContentSize = CGSizeMake(320, 182)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func tableViewSelectedValues(arrSelectedValues: NSMutableArray?, segueName: NSString?)
    {
        var count = arrSelectedValues?.count
        
        if count > 1{
            selectedTextField?.text = arrSelectedValues!.objectAtIndex(1) as? String
            
            if arrSelectedValues?.count > 2{
                for i in 2...count!-1 {
                    selectedTextField!.text = selectedTextField!.text! + "," + (arrSelectedValues!.objectAtIndex(i) as? String)!
                }
            }
        }
        else
        {
            selectedTextField?.text = ""
        }
        
        
        if currentTablePopover != nil {
            currentTablePopover.dismissPopoverAnimated(true)
            currentTablePopover = nil
        }
        
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        return textField.resignFirstResponder()
    }
    
}
