//
//  AboutUsViewController.swift
//  HousingForPK
//
//  Created by Rajesh Nanna on 26/04/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit

class AboutUsViewController: BaseViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    var activityInd : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var url : String = "https://housing.com/about"
        var request = NSURLRequest(URL: NSURL(string: url)!)
        webView.loadRequest(request)
        webView.delegate = self
        
        activityInd = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityInd.bounds = webView.bounds
        activityInd.hidesWhenStopped = true
        webView.addSubview(activityInd)
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        webView.delegate = nil
    }
    
    func webViewDidStartLoad(webView: UIWebView)
    {
        activityInd.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView)
    {
        activityInd.stopAnimating()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError)
    {
        activityInd.stopAnimating()
    }
}
