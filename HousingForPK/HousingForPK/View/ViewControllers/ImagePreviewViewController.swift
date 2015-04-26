//
//  ImagePreviewViewController.swift
//  HousingForPK
//
//  Created by Rajesh Nanna on 25/04/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit

class ImagePreviewViewController: UIViewController, iCarouselDataSource, iCarouselDelegate, UIGestureRecognizerDelegate {
    
    var vwSingle : UIView?
    var carousel: iCarousel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.addUpdateSingleView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addUpdateSingleView ()
    {
        if vwSingle == nil {
            vwSingle = UIView(frame: CGRect(x: 0, y: 100, width: 1024, height: 768-100))
            vwSingle!.backgroundColor = UIColor.clearColor()
            
            //add carousel view on single
            
            carousel = iCarousel(frame: CGRect(x: 0, y: 0, width: 924, height: 660))
            carousel.delegate = self
            carousel.dataSource = self
            
            carousel.type = .CoverFlow
            
            vwSingle!.addSubview(carousel)
            vwSingle!.bringSubviewToFront(carousel)
            
            
            self.view.addSubview(vwSingle!)
            self.view.bringSubviewToFront(vwSingle!)
            println("singleview added")
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func numberOfItemsInCarousel(carousel: iCarousel!) -> Int
    {
        var pCount = 10
        return pCount
    }
    
    func carousel(carousel: iCarousel!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView?
    {
        var retView = view
        
        
        //create new view if no view is available for recycling
        if (view == nil)
        {
            retView = UIImageView(frame:CGRectMake(0, 0, 300, 300))
            (retView as UIImageView).image = UIImage(named: "splash.png")
            retView.contentMode = UIViewContentMode.ScaleAspectFill
            retView.backgroundColor = UIColor.whiteColor()
            retView.layer.cornerRadius = 5.0
            retView.tag = 100
        }
        else
        {
            //get a reference to the label in the recycled view
            retView = view?.viewWithTag(100)
        }
        
//        retView = UIImageView(frame:CGRectMake(0, 0, 290, 440))
//        (view as UIImageView).image = UIImage(named: "splash.png")
//        retView.contentMode = .Top
//        //view.backgroundColor = ColorConstant.COLOR_EDIT
//        retView.backgroundColor = UIColor.whiteColor()
//        retView.layer.cornerRadius = 5.0
//        retView.tag = 100
        
        return retView
    }
    
    
    func carousel(carousel: iCarousel!, didSelectItemAtIndex index: Int) {
        
    }
    
    
    func carouselCurrentItemIndexDidChange(carousel: iCarousel)
    {
        //carousel.reloadData()
        
    }
    
    func carouselDidEndScrollingAnimation(carousel: iCarousel)
    {
        var indexOfView = carousel.indexOfItemView(carousel)
        
    }

}
