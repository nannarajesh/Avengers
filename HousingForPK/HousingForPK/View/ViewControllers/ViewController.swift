//
//  ViewController.swift
//  ValidationOfTweets
//
//  Created by Ashis Laha on 25/04/15.
//  Copyright (c) 2015 Ashis Laha. All rights reserved.
//

import UIKit

class ViewController: BaseViewController , TableViewSelectorDelegate,UITextFieldDelegate{

    
    var essentialArr : [String] = []
    var goOutArr : [String] = []
    var utilitiesArr : [String] = []
    var communicationArr : [String] = []
    var objTrainTheClassifier = TrainTheClassifier()
    
    var nagavara : [String] = ["70%","30%","75%","60%","90%","80%","0%", "100%","80%","70%","80%","30%","0%"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBOutlet weak var txtEssentials: UITextField!
    @IBOutlet weak var txtGoOut: UITextField!
    @IBOutlet weak var txtUtilities: UITextField!
    @IBOutlet weak var txtCommunications: UITextField!
    
    
    // status report
    
    @IBOutlet weak var txtBank: UITextField!
    @IBOutlet weak var txtHospitals: UITextField!
    @IBOutlet weak var txtSchools: UITextField!
    @IBOutlet weak var txtParks: UITextField!
    @IBOutlet weak var txtResturants: UITextField!
    @IBOutlet weak var txtMovieTheater: UITextField!
    @IBOutlet weak var txtBars: UITextField!
    @IBOutlet weak var txtGrocery: UITextField!
    @IBOutlet weak var txtFarmacy: UITextField!
    @IBOutlet weak var txtTrain: UITextField!
    @IBOutlet weak var txtShoppingMall: UITextField!
    @IBOutlet weak var txtBus: UITextField!
    @IBOutlet weak var txtAirport: UITextField!
    
    
    var selectedTextField : UITextField?
    var currentTablePopover: UIPopoverController! = nil
    
    
    @IBAction func btnEssentialsTapped(sender: AnyObject) {
        var tableQuestionVC : TableQuestionViewController?
        
        if !(tableQuestionVC != nil)
        {
            tableQuestionVC = self.storyboard?.instantiateViewControllerWithIdentifier("tableQuestionVC") as TableQuestionViewController?
            tableQuestionVC!.delegate = self
        }
        
        tableQuestionVC!.delegate = self
        tableQuestionVC!.arrAllValues = NSMutableArray(array: DropDownArrayData.getEssentials())
        tableQuestionVC!.arrSelectedValues = NSMutableArray(objects: " ")
        selectedTextField = txtEssentials
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
    
    
    @IBAction func btnGoOut(sender: AnyObject) {
        var tableQuestionVC : TableQuestionViewController?
        
        if !(tableQuestionVC != nil)
        {
            tableQuestionVC = self.storyboard?.instantiateViewControllerWithIdentifier("tableQuestionVC") as TableQuestionViewController?
            tableQuestionVC!.delegate = self
        }
        
        tableQuestionVC!.delegate = self
        tableQuestionVC!.arrAllValues = NSMutableArray(array: DropDownArrayData.getGoOuts())
        tableQuestionVC!.arrSelectedValues = NSMutableArray(objects: " ")
        selectedTextField = txtGoOut
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
    
    

    @IBAction func btnUtilities(sender: AnyObject) {
        var tableQuestionVC : TableQuestionViewController?
        
        if !(tableQuestionVC != nil)
        {
            tableQuestionVC = self.storyboard?.instantiateViewControllerWithIdentifier("tableQuestionVC") as TableQuestionViewController?
            tableQuestionVC!.delegate = self
        }
        
        tableQuestionVC!.delegate = self
        tableQuestionVC!.arrAllValues = NSMutableArray(array: DropDownArrayData.getUtilities())
        tableQuestionVC!.arrSelectedValues = NSMutableArray(objects: " ")
        selectedTextField = txtUtilities
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
   
    
    @IBAction func btnCommunications(sender: AnyObject) {
        var tableQuestionVC : TableQuestionViewController?
        
        if !(tableQuestionVC != nil)
        {
            tableQuestionVC = self.storyboard?.instantiateViewControllerWithIdentifier("tableQuestionVC") as TableQuestionViewController?
            tableQuestionVC!.delegate = self
        }
        
        tableQuestionVC!.delegate = self
        tableQuestionVC!.arrAllValues = NSMutableArray(array: DropDownArrayData.getCommunications())
        tableQuestionVC!.arrSelectedValues = NSMutableArray(objects: " ")
        selectedTextField = txtCommunications
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
    
    
    @IBAction func btnValidateIt(sender: AnyObject) {
        
        
        essentialArr = objTrainTheClassifier.trainTheEssentialClassifier()
        goOutArr = objTrainTheClassifier.trainTheGoOutClassifier()
        utilitiesArr = objTrainTheClassifier.trainTheUtilitiesClassifier()
        communicationArr = objTrainTheClassifier.trainTheCommunicationClassifier()
        
        var trainClass : [Double] = objTrainTheClassifier.trainClassifier1() // calculate value for trainClassifier1
        
        
        
        txtBank.text = "Prob :" + "\(trainClass[0])"
        txtHospitals.text = "Prob" + "\(trainClass[1])"
        txtSchools.text = "Prob" + "\(trainClass[2])"
        txtParks.text = "Prob" + "\(trainClass[3])"
        
        
        // Rest of them is calculate as like previous time
        txtResturants.text = nagavara[4] + essentialArr[2]
        txtMovieTheater.text = nagavara[5] + essentialArr[2]
        txtBars.text = nagavara[6] + essentialArr[2]
        txtGrocery.text = nagavara[7] + essentialArr[2]
        txtFarmacy.text = nagavara[8] + essentialArr[2]
        txtTrain.text = nagavara[9] + essentialArr[2]
        txtShoppingMall.text = nagavara[10] + essentialArr[2]
        txtBus.text = nagavara[11] + essentialArr[2]
        txtAirport.text = nagavara[12] + essentialArr[2]
        
        
    }
    
    
    
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
        
        if selectedTextField == txtEssentials{
        
        }
        
        else if selectedTextField == txtGoOut {
        
        }
        else if selectedTextField == txtUtilities {
            
        }
        else if selectedTextField == txtCommunications {
            
        }
        
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        return textField.resignFirstResponder()
    }
}

