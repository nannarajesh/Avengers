//
//  RequestViewController.swift
//  HousingForPK
//
//  Created by Administrator on 25/04/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit

class RequestViewController: BaseViewController,UIImagePickerControllerDelegate, AnnotationControllerDelegate, UICollectionViewDelegate,AnnotationCollectionViewCellDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var viewCollection: UIView!
    @IBOutlet weak var txtRequiredRequest: UITextView!
    @IBOutlet weak var txtSearch: UITextField!
    var viewAnnotation : UIView!
    var tblView: UITableView!

    var cellImage: UIImageView = UIImageView()
    var collectionCount: Int = Int()
    var imageArray :NSMutableArray = []
    var captionArray : NSMutableArray = []
    var photoImageView: UIImageView?
    var indexValue : Int = Int()
    var indexValuePath : NSIndexPath!
    var longPress : UILongPressGestureRecognizer = UILongPressGestureRecognizer()
    var labelNoPhoto : UILabel = UILabel()
    var indexPathRemove: NSIndexPath!
    var newView : UIView = UIView()
    var isInSearchMode: Bool!
    var arrData : NSMutableArray!
    var arrSearchResults : NSMutableArray!

    func initializeData ()
    {
        arrData = NSMutableArray()
        arrData.addObject("School")
        arrData.addObject("3 BHK")
        arrData.addObject("Hospital")
        
        
        arrSearchResults = NSMutableArray()
    }
    func designScreen ()
    {
        if tblView != nil
        {
            tblView.removeFromSuperview()
        }
        tblView = UITableView(frame: CGRect(x: 16, y: 149, width: 408, height: (arrSearchResults.count*44 + 30)), style: UITableViewStyle.Plain)
        tblView.delegate = self
        tblView.dataSource = self
        tblView.layer.borderWidth = 1.0
        tblView.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
        tblView.layer.cornerRadius = 5.0
        self.view.addSubview(tblView)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearch.layer.borderWidth = 1.0
        txtSearch.layer.cornerRadius = 5.0
        txtSearch.layer.borderColor = UIColor.grayColor().CGColor

        self.initializeData()
        isInSearchMode = false
        self.designScreen()
        tblView.hidden = true

        
        longPress = UILongPressGestureRecognizer(target: self, action: "longPressDetected:")
        longPress.minimumPressDuration = 0.5
        longPress.delaysTouchesBegan = true
        longPress.delegate = self
        longPress.cancelsTouchesInView = false
        newView.frame = CGRect(x: 0, y: 1, width: 852, height: 225)
        newView.backgroundColor = UIColor.whiteColor()
        labelNoPhoto.frame = CGRect(x: 27, y: 9, width: 200, height: 60)
        labelNoPhoto.text = "No Existing Photos"
        labelNoPhoto.textColor = UIColor.lightGrayColor()
        labelNoPhoto.font = UIFont(name: "HelveticaNeue", size: 17)
        viewCollection.addSubview(newView)
        newView.addSubview(labelNoPhoto)
        var tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapAction:")
        tapGesture.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(tapGesture)
        
        photoCollectionView.showsHorizontalScrollIndicator = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "backGround:",name:"back", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "stopWiggling:",name:"stop", object: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        isInSearchMode = true
        
        //fitler and reload
        self.filterAndReload(textField.text)
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        isInSearchMode = true
        //filter and reload
        
        self.filterAndReload(textField.text + string)
        if tblView != nil
        {
            designScreen()
        }
        
        
        if string == ""
        {
            tblView.hidden = true
        }
        else
        {
            tblView.hidden = false
        }
        return true
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
        
    }
    

    @IBAction func plusButtonAction(sender: AnyObject) {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let sourceView = UIView()
        
        let imagePicker:UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        
        
        sheet.addAction(UIAlertAction(title: NSLocalizedString("Take New Photo",comment:"Take new photo"), style:
            UIAlertActionStyle.Default, handler: { (action) -> Void in
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                imagePicker.cameraCaptureMode = .Photo
                imagePicker.cameraDevice =  UIImagePickerControllerCameraDevice.Rear
                self.presentViewController(imagePicker, animated: true, completion: nil)
        }))
        sheet.addAction(UIAlertAction(title: NSLocalizedString("Choose Existing",comment:"Choose existing"), style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.modalPresentationStyle = UIModalPresentationStyle.Popover;
            imagePicker.popoverPresentationController?.sourceView = self.addButton
            imagePicker.popoverPresentationController?.sourceRect = self.addButton.bounds
            imagePicker.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.Unknown
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }))
        
        sheet.popoverPresentationController?.sourceView = addButton
        sheet.popoverPresentationController?.sourceRect = addButton.bounds
        
        sheet.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.Unknown
        sheet.preferredContentSize = CGSize(width: 200, height: 100)
        self.presentViewController(sheet, animated: true, completion: nil)
        
    }
    
    func filterAndReload(strTextEntered : String)
    {
        arrSearchResults.removeAllObjects()
        
        if strTextEntered == ""
        {
            arrSearchResults.addObjectsFromArray(arrData)
        }
        else {
            var filteredArray : NSArray! = arrData.filteredArrayUsingPredicate(NSPredicate(format: "SELF CONTAINS[c] \"\(strTextEntered.lowercaseString)\"")!)
            
            if filteredArray != nil
            {
                arrSearchResults.addObjectsFromArray(filteredArray)
            }
        }
        
        tblView.reloadData()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var rows : Int = arrData.count
        if isInSearchMode == true
        {
            rows = arrSearchResults.count
        }
        return rows
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        if isInSearchMode == true
        {
            cell!.textLabel?.text = arrSearchResults.objectAtIndex(indexPath.row) as? String
            
        }
        else
        {
            cell!.textLabel?.text = arrData.objectAtIndex(indexPath.row) as? String
        }
        
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if tableView == tblView
        {
            if isInSearchMode == true
            {
                txtSearch.text = arrSearchResults.objectAtIndex(indexPath.row) as? String
                
            }
            else
            {
                txtSearch.text = arrData.objectAtIndex(indexPath.row) as? String
            }
            txtSearch.resignFirstResponder()
            tblView.removeFromSuperview()
        }
        else
        {
            
        }
    }

    
    @IBAction func btnSubmitTapped(sender: AnyObject) {
        UIAlertView(title: "Submitted", message: "Your request has been successfully submitted", delegate: self, cancelButtonTitle: "OK").show()
        txtSearch.text = ""
        txtRequiredRequest.text = ""
        collectionCount = 0
        imageArray = []
        captionArray = []
        self.photoCollectionView.reloadData()

        
    }
    
    //MARK: - Image Annotation Controller
    
    func ProgressNoteCancelButtonClicked() {
        if viewAnnotation != nil {
            viewAnnotation?.removeFromSuperview()
            viewAnnotation = nil
        }
    }
    
    func popoverControllerDidDismissPopover(popoverController: UIPopoverController) {
        if viewAnnotation != nil {
            viewAnnotation = nil
        }
    }
    
    func cancelButtonClicked() {
        if viewAnnotation != nil {
            viewAnnotation?.removeFromSuperview()
            viewAnnotation = nil
        }
    }
    
    func saveButtonClicked(newImage: UIImage, newCaption : String) {
        if viewAnnotation != nil {
            viewAnnotation?.removeFromSuperview()
            viewAnnotation = nil
        }
        
        if photoImageView!.image != nil {
            photoImageView!.image = newImage
            imageArray[indexValue]  = newImage as UIImage
            captionArray[indexValue] = newCaption as String
        }
        photoCollectionView.reloadData()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var mode:Int = 0 {
        didSet {
            self.onModeSet(self.mode)
        }
    }
    
    private func onModeSet(mode:Int) {
        var i = 0
        
        let cells:[AnyObject] = photoCollectionView.visibleCells() as [AnnotationCollectionViewCell]
        if cells.count > 0 {
            for i in 0...cells.count-1 {
                if cells[i].isKindOfClass(AnnotationCollectionViewCell) {
                    (cells[i] as AnnotationCollectionViewCell).mode = mode
                }
            }
        }
    }
    
    // long press func for images
    func longPressDetected(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if (collectionCount > 0) {
            if (gestureRecognizer.state != UIGestureRecognizerState.Began) {
                return
            }
            addButton.userInteractionEnabled = false
            let p: CGPoint = gestureRecognizer.locationInView(photoCollectionView)
            let indexPath: NSIndexPath = photoCollectionView.indexPathForItemAtPoint(p)!
            indexValuePath = indexPath
            
            if let indexPath:NSIndexPath? = photoCollectionView.indexPathForItemAtPoint(p) {
                let cell: AnnotationCollectionViewCell = photoCollectionView.cellForItemAtIndexPath(indexPath!)! as AnnotationCollectionViewCell
                var val = indexPath?.item
                
                if indexPath != nil {
                    self.mode = 1
                }
            }
            
        }
        
    }
    
    //UITapGestureRecognizer Action
    func tapAction(sender : AnyObject) {
        addButton.userInteractionEnabled = true
        NSNotificationCenter.defaultCenter().postNotificationName("stop", object: nil)
    }
    
    func annotationCollectionViewCellOnRemove(indexPos: NSIndexPath) {
        self.removePhoto(indexPos)
    }
    
    private func removePhoto(indexPos:NSIndexPath) {
        self.imageArray.removeObjectAtIndex(indexPos.item)
        self.captionArray.removeObjectAtIndex(indexPos.item)
        
        collectionCount--
        //        self.mode = 0
        photoCollectionView.reloadData()
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
    }
    
    func backGround(notification: NSNotification){
        //load data here
        if mode == 1 {
            mode = 1
        }
    }
    
    func stopWiggling(notification: NSNotification) {
        self.mode = 0
        
    }
    
    //MARK: - Image Picker Method
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        var tempImage:UIImage?
        
        photoImageView = UIImageView(image: image)
        imageAnnotation.image = photoImageView?.image
        tempImage = photoImageView?.image!
        imageArray[collectionCount] = tempImage!
        captionArray[collectionCount] = ""
        collectionCount++
        photoCollectionView.hidden = false
        labelNoPhoto.hidden = true
        newView.hidden = true
        photoCollectionView.reloadData()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionCount == 0 {
            return 1
        }
        return collectionCount
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell : AnnotationCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as AnnotationCollectionViewCell
        cell.backgroundColor = UIColor.whiteColor()
        cell.indexValue = indexPath
        cell.delegate = self
        cell.addGestureRecognizer(longPress)
        longPress = UILongPressGestureRecognizer(target: self, action: "longPressDetected:")
        
        if collectionCount == 0 {
            
            cell.imgAnnoted.image = UIImage(named: "annotationPhoto.png")
            self.photoCollectionView.hidden = true
            self.newView.hidden = false
            self.labelNoPhoto.hidden = false
            self.txtRequiredRequest.userInteractionEnabled = false
            self.txtRequiredRequest.text = ""
            
        }
        else {
            cell.imgAnnoted.image = imageArray[indexPath.row] as? UIImage
            self.txtRequiredRequest.userInteractionEnabled = true

        }
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        var c = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as AnnotationCollectionViewCell
        c.layer.cornerRadius = 5.0
        c.delegate = self
        c.indexValue = indexPath
        if cell.isKindOfClass(AnnotationCollectionViewCell) {
            (cell as AnnotationCollectionViewCell).mode = mode
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if self.mode == 0 {
            if photoImageView != nil {
                let viewBindings = ["photoImageView": imageArray[indexPath.row]]
                if viewAnnotation != nil {
                    viewAnnotation?.removeFromSuperview()
                    viewAnnotation = nil
                }
                
                //annotationVC
                var annotationVC : AnnotationController? = AnnotationController(nibName: "AnnotationController", bundle: NSBundle.mainBundle()) as AnnotationController
                annotationVC!.callBack = self
                
                annotationVC?.selectedImage!.image = imageArray[indexPath.row] as? UIImage
                annotationVC?.txtAnnotationDetails.text = captionArray[indexPath.row] as? String
                indexValue = indexPath.row
                indexValuePath = indexPath
//                self.navigationController?.pushViewController(annotationVC!, animated: false)
                annotationVC!.modalPresentationStyle = UIModalPresentationStyle.FormSheet
                self.presentViewController(annotationVC!, animated: true, completion: nil)
                collectionView.reloadData()
                
            }
            
            
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

}
