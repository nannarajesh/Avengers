//
//  DidSelectViewController.swift
//  HousingForPK
//
//  Created by Administrator on 25/04/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit

class DidSelectViewController: BaseViewController,iCarouselDataSource, iCarouselDelegate, UITableViewDelegate,UITableViewDataSource {

    var textType : String!
    var textAddress : String!
    var textPrice : String!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var tblLeft: UITableView!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var scrollVv: UIScrollView!
    @IBOutlet weak var tblRight: UITableView!
    var tapGesture : UITapGestureRecognizer!
//    var vwCarousel : UIView?
    var carousel: iCarousel!
    var objProperty : Property?
    var arrayType1 = ["Property","Lease","Bathroom","Added"]
    var arrayDetail1 = ["Independent Floor","Family Only","2","5 days ago"]
    var arrayType2 = ["Build-Up Area","Facing","Power Back-Up","Availability"]
    var arrayDetail2 = ["850 sq.ft.","East","None","Ready to move"]
    @IBOutlet weak var vwCarousel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblType.text = objProperty?.strBHKType
        lblAddress.text = objProperty?.strAddress
        lblPrice.text = objProperty?.strPrice
        
        scrollVv.contentSize = CGSize(width: 550, height: 1200+53-200)
        // Do any additional setup after loading the view.
        
        self.addUpdateSingleView()

    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tapAction(sender : AnyObject) {
        //self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : DetailsTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as DetailsTableViewCell
        if tableView == tblLeft
        {
            cell.lblTitle.text = arrayType1[indexPath.row]
            cell.lblExplanation.text = arrayDetail1[indexPath.row]
        }
        else
        {
            cell.lblTitle.text = arrayType2[indexPath.row]
            cell.lblExplanation.text = arrayDetail2[indexPath.row]
        }
        return cell
    }
    
    
    func addUpdateSingleView ()
    {
//        if vwCarousel == nil
//        {
//            vwCarousel = UIView(frame: CGRect(x: 0, y: 100, width: 1024, height: 768-100))
            vwCarousel!.backgroundColor = UIColor.clearColor()
            
            //add carousel view on single
            
            carousel = iCarousel(frame: CGRect(x: 0, y: 0, width: 516, height: 363))
            carousel.delegate = self
            carousel.dataSource = self
            
            carousel.type = .CoverFlow
            
            vwCarousel!.addSubview(carousel)
            vwCarousel!.bringSubviewToFront(carousel)
            
            
//            self.view.addSubview(vwCarousel!)
//            self.view.bringSubviewToFront(vwCarousel!)
            println("singleview added")
//        }
//        
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
        var pCount = objProperty?.arrImages?.count
        return pCount!
    }
    
    func carousel(carousel: iCarousel!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView?
    {
        var retView = view
        
        
        //create new view if no view is available for recycling
        if (view == nil)
        {
            retView = UIImageView(frame:CGRectMake(0, 0, 300, 300))
            (retView as UIImageView).image = objProperty!.arrImages![index] as? UIImage
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

    @IBAction func btnCancelTouchUpInside(sender: UIButton)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
