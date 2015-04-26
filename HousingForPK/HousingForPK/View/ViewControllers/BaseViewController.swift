//
//  BaseViewController.swift
//  HousingForPK
//
//  Created by Rajesh Nanna on 25/04/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var bannerView : GADBannerView?
    var bannerView2 : GADBannerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.createAD()
    }
    
    func createAD()
    {
        //return
        
        var heightView : CGFloat = 50.0
        
        bannerView = GADBannerView(frame: CGRect(x:100, y: self.view.frame.size.height - heightView, width: 320, height: heightView))

        bannerView?.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        
        self.view.addSubview(bannerView!)
        bannerView?.rootViewController = self
        var request1 : GADRequest = GADRequest()
        request1.testDevices = [GAD_SIMULATOR_ID]
        self.bannerView?.loadRequest(request1)
        
        bannerView2 = GADBannerView(frame: CGRect(x: 328+140, y: self.view.frame.size.height - heightView, width: 320, height: heightView))
        
        bannerView2?.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        
        self.view.addSubview(bannerView2!)
        bannerView2?.rootViewController = self
        var request2 : GADRequest = GADRequest()
        request2.testDevices = [GAD_SIMULATOR_ID]
        self.bannerView2?.loadRequest(request2)

    }
}
