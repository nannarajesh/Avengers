//
//  VaastuViewController.swift
//  HousingForPK
//
//  Created by Rajesh Nanna on 26/04/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit

class VaastuViewController: BaseViewController {

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
        
        UIAlertView(title: "Alert!", message: "This feature is in progress.", delegate: nil, cancelButtonTitle: "Ok")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
