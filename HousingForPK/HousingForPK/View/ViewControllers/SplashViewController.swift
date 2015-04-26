//
//  SplashViewController.swift
//  HousingForPK
//
//  Created by Rajesh Nanna on 25/04/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit
import MediaPlayer

class SplashViewController: UIViewController {

    var videoPlayer : MPMoviePlayerController?
    
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
        
        //self.initilizeAllVideo()
        self.MovieComplete(nil)
        
    }
    func initilizeAllVideo()
    {
        
        var strVideoName : String = "splash_video.m4v"
//        var strVideoName : String = "launchMovie.m4v"
    
    
    
    
        var mediaPath : String = NSBundle.mainBundle().resourcePath!.stringByAppendingPathComponent(strVideoName)
        
        videoPlayer = MPMoviePlayerController(contentURL: NSURL(fileURLWithPath: mediaPath))
        videoPlayer?.view.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "MovieComplete:", name: MPMoviePlayerPlaybackDidFinishNotification, object: videoPlayer?)

        videoPlayer?.movieSourceType = MPMovieSourceType.Unknown
        videoPlayer?.controlStyle = MPMovieControlStyle.None
        videoPlayer?.scalingMode = MPMovieScalingMode.Fill
        videoPlayer?.backgroundView.backgroundColor = UIColor.whiteColor()
        videoPlayer?.view.tag = 9876
        videoPlayer?.play()
        self.view.addSubview(videoPlayer!.view)
    }
    
    func MovieComplete(aNotification : NSNotification?)
    {
        var player : MPMoviePlayerController? = aNotification?.object as? MPMoviePlayerController
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MPMoviePlayerPlaybackDidFinishNotification, object: player?)
        
        
        
        var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        var splitController : UISplitViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HousingBaseSplitViewController") as UISplitViewController
        appDelegate.window?.rootViewController = splitController
        
//        self.presentViewController(splitController, animated: true) { () -> Void in
//        println("split is presented")
//        }
    }
    
}
