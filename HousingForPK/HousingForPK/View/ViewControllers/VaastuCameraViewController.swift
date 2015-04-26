//
//  VaastuCameraViewController.swift
//  HousingForPK
//
//  Created by Rajesh Nanna on 26/04/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit


protocol VaastuCameraDelegate
{
    func backFromCameraController()
}
//UIImagePickerController, UINavigationControllerDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate
class VaastuCameraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var imagePickerVasastu : UIImagePickerController?
        var lblDirection : UILabel?
        var lblPlace : UILabel?
        var strDirection : String?
        var directionManager : CLLocationManager?
        var viewAppear : Int?
        var lblHeaderInfo : UILabel?
        var vwOverlayView : UIView?
        var tap : UITapGestureRecognizer?
        
        var delegate : VaastuCameraDelegate?
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

    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        var magnitude : CLHeadingComponentValue = (newHeading.x*newHeading.x) + (newHeading.z*newHeading.z)
        
        var direction : CLLocationDirection = newHeading.magneticHeading
        
        //self.reloadDataWithDirection(direction)


    }
    
    
    /*
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        if error.code == 1
        {
            manager.stopUpdatingHeading()
        }
        else if error.code == 3
        {
            
        }
        
        if imagePickerVasastu != nil
        {
            [imagePickerVasastu release];
            imagePickerVasastu = nil;
        }
        
        imagePickerVasastu = UIImagePickerController()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
    }
    -(void) viewDidAppear:(BOOL)animated
    {
    [super viewDidAppear:YES];
    appDelegate = (MagicBricksAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    self.view.backgroundColor = [UIColor blackColor];
    if(appDelegate.viewAppear == 1)
    {
    UIImageView *imgView_background = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 768, 1024)];
    imgView_background.tag = 45555;
    imgView_background.hidden = YES;
    imgView_background.image=[UIImage imageNamed:@"main.png"];
    imgView_background.hidden = YES;
    [self.view addSubview:imgView_background];
    [imgView_background release];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    
    if(imagePickerVasastu)
    {
    [imagePickerVasastu release];
    imagePickerVasastu = nil;
    }
    
    imagePickerVasastu = [[UIImagePickerController alloc] init];
    [imagePickerVasastu setAllowsEditing:NO];
    [imagePickerVasastu setEditing:NO];
    
    vwOverlayView = [[UIView alloc] init];
    vwOverlayView.backgroundColor = [UIColor clearColor];
    
    [imagePickerVasastu setSourceType:UIImagePickerControllerSourceTypeCamera];
    imagePickerVasastu.showsCameraControls = NO;
    imagePickerVasastu.delegate = self;
    if(appDelegate.isPortait)
    {
    imagePickerVasastu.cameraOverlayView.frame = CGRectMake(0, 0, 768, 1024);
    vwOverlayView.frame = CGRectMake(0, 0, 768, 1024);
    }
    else
    {
    imagePickerVasastu.cameraOverlayView.frame = CGRectMake(0, 0, 1024, 768);
    vwOverlayView.frame = CGRectMake(0, 0, 1024, 768);
    }
    
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnCamera:)];
    tap.numberOfTapsRequired = 1;
    
    [vwOverlayView addGestureRecognizer:tap];
    
    [appDelegate.window addSubview:vwOverlayView];
    [appDelegate.window bringSubviewToFront:vwOverlayView];
    
    
    [self addInterfaceOnCamera];
    
    appDelegate.viewAppear ++;
    [self presentModalViewController:imagePickerVasastu animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
    
    }
    else
    {
    appDelegate.viewAppear ++;
    backBtn = [[UIButton alloc] init];
    backBtn.frame=CGRectMake(0, 408.5, 60, 207);
    [backBtn setImage:[UIImage imageNamed:@"backCamera.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:backBtn atIndex:3];
    }
    }
    [appDelegate.window bringSubviewToFront:vwOverlayView];
    
    //for camera view controller, logic writen at appdelegate, supportedinterfaceorientations is giving conflict
    
    if([[UIApplication sharedApplication] statusBarFrame].size.width == 20)
    {
    appDelegate.interFaceOrientation = (UIInterfaceOrientation)UIInterfaceOrientationLandscapeRight;
    appDelegate.isPortait = NO;
    }
    else if([[UIApplication sharedApplication] statusBarFrame].size.width == 768)
    {
    appDelegate.interFaceOrientation = (UIInterfaceOrientation)UIInterfaceOrientationPortrait;
    appDelegate.isPortait = YES;
    }
    else
    {
    appDelegate.interFaceOrientation = (UIInterfaceOrientation)UIInterfaceOrientationPortrait;
    appDelegate.isPortait = YES;
    }
    
    
    [self detectOrientation:appDelegate.interFaceOrientation];
    }
    
    -(void) viewWillDisappear:(BOOL)animated
    {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
    }
    -(void) viewWillAppear:(BOOL)animated
    {
    
    }
    
    - (void)viewDidLoad
    {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
    
    self.directionManager = [[[CLLocationManager alloc] init] autorelease];
    directionManager.delegate = self;
    
    // check if the hardware has a compass
    if ([CLLocationManager headingAvailable] == NO) {
    // No compass is available. This application cannot function without a compass,
    // so a dialog will be displayed and no magnetic data will be measured.
    self.directionManager = nil;
    UIAlertView *noCompassAlert = [[UIAlertView alloc] initWithTitle:@"No Compass!" message:@"This device does not have the ability to measure magnetic fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [noCompassAlert show];
    [noCompassAlert release];
    } else {
    // heading service configuration
    directionManager.headingFilter = kCLHeadingFilterNone;
    
    // setup delegate callbacks
    directionManager.delegate = self;
    
    UIInterfaceOrientation orientation =   [[UIApplication sharedApplication] statusBarOrientation];
    if(orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown){
    NSLog(@"CLDeviceOrientationPortrait in didload");
    [directionManager setHeadingOrientation:CLDeviceOrientationPortrait];
    }
    else{
    NSLog(@"CLDeviceOrientationLandscapeLeft in didload");
    [directionManager setHeadingOrientation:CLDeviceOrientationLandscapeLeft];
    }
    
    // start the compass
    [directionManager startUpdatingHeading];
    }
    
    }
    
    -(void) tappedOnCamera:(UITapGestureRecognizer *)gesture
    {
    //get direction from label text
    
    CGPoint touched_Point=[gesture locationInView:imagePickerVasastu.cameraOverlayView];
    
    
    BOOL isBackClicked = NO;
    
    for(UIView *views in imagePickerVasastu.cameraOverlayView.subviews)
    {
    if([views isKindOfClass:[UIButton class]])
    {
    if(CGRectContainsPoint(views.frame, touched_Point))
    {
    UIButton *btnGeneric = (UIButton *)views;
    if(btnGeneric && btnGeneric.tag == 7414)
    isBackClicked=YES;
    break;
    }
    }
    }
    
    if(isBackClicked)
    {
    [self goBack];
    return;
    }
    
    
    //compare direction with specified direction and show alert accordingly.
    NSString *strMessage = self.objSelPlace.strComment;
    NSString *strHeader = @"Vaastu Non Compliant";
    
    NSString *strDirections = nil;
    strDirections = self.objSelPlace.strDirection;
    strDirections = strDirections ? strDirections : @"";
    NSArray *arrDirections = [strDirections componentsSeparatedByString:@","];
    
    BOOL isExists = NO;
    for(NSString *strGeneric in arrDirections)
    {
    strGeneric = [strGeneric stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([[strGeneric lowercaseString] isEqualToString:[strDirection lowercaseString]])
    {
    isExists = YES;
    
    strMessage = self.objSelPlace.strComment;
    strHeader = @"Vaastu Compliant";
    
    break;
    }
    }
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strHeader message:strMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    }
    -(void) reloadDataWithDirection:(double) directionRadians
    {
    
    if(directionRadians>0)
    {
    /*
    north                  0.0
    north by east          11.25
    north north east       22.5
    north east by north    33.75
    north east             45
    north east by east     56.25
    east north east        67.5
    east by north          78.75
    east                   90
    east by south          101.25
    east south east        112.5
    south east by east     123.75
    south east             135
    south east by south    146.25
    south south east       157.5
    south by east          168.75
    south                  180
    south by West          191.25
    south south west       202.5
    south west by south    213.75
    south west             225
    south west by west     236.25
    west south west        247.5
    west by south          258.75
    west                   270
    west by north          281.25
    west north west        292.5
    north west by west     303.75
    north west             315
    north west by north    326.25
    north north west       337.5
    north by west          348.75
    
    */
    //North, South, East, West, SouthWest, SouthEast, NorthEast, NorthWest
    //north
    
    if(directionRadians < 11.25)
    {
    strDirection = @"North";
    }
    else if(directionRadians < 56.25)
    {
    strDirection = @"NorthEast";
    }
    else if(directionRadians < 101.25)
    {
    strDirection = @"East";
    }
    else if(directionRadians < 146.25)
    {
    strDirection = @"SouthEast";
    }
    else if(directionRadians < 191.25)
    {
    strDirection = @"South";
    }
    else if(directionRadians < 236.25)
    {
    strDirection = @"SouthWest";
    }
    else if(directionRadians < 281.25)
    {
    strDirection = @"West";
    }
    else if(directionRadians < 326.25)
    {
    strDirection = @"NorthWest";
    }
    else
    {
    strDirection = @"NorthWest";
    }
    }
    
    if(!strDirection || [strDirection isEqualToString:@"(null)"])
    {
    strDirection = @"--";
    }
    
    lblDirection.text = [NSString stringWithFormat:@"%@",strDirection];
    lblPlace.text = [NSString stringWithFormat:@"%@ :",strSelArea];
    
    
    //make hidden NO
    
    
    backBtn.hidden = NO;
    
    
    imgViewInfo.hidden = NO;
    
    
    lblHeaderInfo.hidden = NO;
    
    
    imgViewHeader.hidden = NO;
    
    lblDirection.hidden = NO;
    lblPlace.hidden = NO;
    UIImageView *imgView_background = (UIImageView *) [self.view viewWithTag:45555];
    if(imgView_background)
    {
    imgView_background.hidden = NO;
    }
    
    }
    
    #pragma mark
    #pragma mark imagePickerController delegate
    - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
    
    [picker setEditing:NO];
    [picker dismissModalViewControllerAnimated:NO];
    }
    
    
    -(void) goBack
    {
    appDelegate.viewAppear = 0;
    if(imagePickerVasastu)
    {
    [imagePickerVasastu.cameraOverlayView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [imagePickerVasastu dismissModalViewControllerAnimated:NO];
    [imagePickerVasastu release];
    imagePickerVasastu = nil;
    }
    
    if(self.delegate!=nil&&[self.delegate respondsToSelector:@selector(backFromCameraController)])
    {
    [self.delegate performSelector:@selector(backFromCameraController) withObject:nil];
    }
    }
    
    - (void)viewDidUnload
    {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    }
    
    - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
    {
    // Return YES for supported orientations
    return NO;
    }
    
    // New Autorotation support.
    - (BOOL)shouldAutorotate
    {
    return NO;
    }
    - (NSUInteger)supportedInterfaceOrientations
    {
    return 0;
    }
    
    -(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    //[self detectOrientation:toInterfaceOrientation];
    
    
    }
    -(void)detectOrientation:(UIInterfaceOrientation)toInterfaceOrientation
    {
    
    NSLog(@"detect orientation");
    //    UIImageView *imgViewInfo=(UIImageView *)[imagePickerVasastu.cameraOverlayView viewWithTag:6312];
    //    UILabel *lblHeaderInfo=(UILabel *)[imagePickerVasastu.cameraOverlayView  viewWithTag:4567];
    //    UIImageView *imgViewHeader=(UIImageView *)[imagePickerVasastu.cameraOverlayView  viewWithTag:6313];
    //    UIButton *btnBack=(UIButton *)[imagePickerVasastu.cameraOverlayView  viewWithTag:7414];
    
    [appDelegate.window bringSubviewToFront:vwOverlayView];
    
    if (toInterfaceOrientation==UIInterfaceOrientationPortrait ||
    (toInterfaceOrientation == UIDeviceOrientationPortraitUpsideDown))
    {
    
    NSLog(@"CLDeviceOrientationPortrait in detect Orientation");
    
    [directionManager stopUpdatingHeading];
    directionManager.delegate = nil;
    [directionManager release];
    directionManager = nil;
    
    self.directionManager = [[[CLLocationManager alloc] init] autorelease];
    directionManager.delegate = self;
    directionManager.headingFilter = kCLHeadingFilterNone;
    directionManager.delegate = self;
    [directionManager setHeadingOrientation:CLDeviceOrientationPortrait];
    [directionManager startUpdatingHeading];
    
    
    appDelegate.isPortait =YES;
    imagePickerVasastu.cameraOverlayView.frame = CGRectMake(0, 0, 768, 1024);
    vwOverlayView.frame = CGRectMake(0, 0, 768, 1024);
    
    [self addInterfaceOnCamera];
    
    imgViewInfo.frame=CGRectMake(0,904, 768, 120);
    
    lblHeaderInfo.frame=CGRectMake(0, 904, 768, 120);
    
    imgViewHeader.frame=CGRectMake(0,0, 768, 60);
    
    
    lblPlace.frame = CGRectMake(0, 10, 300, 60);
    
    lblDirection.frame = CGRectMake(310, 10, 400, 60);
    
    backBtn.frame=CGRectMake(0, 408.5, 60, 207);
    }
    else if ((toInterfaceOrientation == UIDeviceOrientationLandscapeLeft) ||
    (toInterfaceOrientation   == UIDeviceOrientationLandscapeRight))
    {
    
    NSLog(@"CLDeviceOrientationLandscapeRight in detect Orientation");
    
    [directionManager stopUpdatingHeading];
    directionManager.delegate = nil;
    [directionManager release];
    directionManager = nil;
    
    self.directionManager = [[[CLLocationManager alloc] init] autorelease];
    directionManager.delegate = self;
    directionManager.headingFilter = kCLHeadingFilterNone;
    directionManager.delegate = self;
    [directionManager setHeadingOrientation:CLDeviceOrientationLandscapeRight];
    [directionManager startUpdatingHeading];
    
    
    appDelegate.isPortait =NO;
    imagePickerVasastu.cameraOverlayView.frame = CGRectMake(0, 0, 1024, 768);
    vwOverlayView.frame = CGRectMake(0, 0, 1024, 1024);
    
    [self addInterfaceOnCamera];
    
    imgViewInfo.frame=CGRectMake(0,648, 1024, 120);
    
    
    lblHeaderInfo.frame=CGRectMake(0, 648, 1024, 120);
    
    
    imgViewHeader.frame=CGRectMake(0,0, 1024, 60);
    
    
    lblPlace.frame = CGRectMake(0, 10, 350, 60);
    
    
    lblDirection.frame = CGRectMake(360, 10, 400, 60);
    
    
    backBtn.frame=CGRectMake(0, 280.5, 60, 207);
    }
    
    //[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(callAfterfewMilliSeconds) userInfo:nil repeats:NO];
    }
    
    
    -(void) callAfterfewMilliSeconds
    {
    if (appDelegate.isPortait == YES)
    {
    imagePickerVasastu.cameraOverlayView.frame = CGRectMake(0, 0, 768, 1024);
    vwOverlayView.frame = CGRectMake(0, 0, 768, 1024);
    //return;
    
    [self addInterfaceOnCamera];
    
    imgViewInfo.frame=CGRectMake(0,904, 768, 120);
    
    lblHeaderInfo.frame=CGRectMake(0, 904, 768, 120);
    
    imgViewHeader.frame=CGRectMake(0,0, 768, 60);
    
    
    lblPlace.frame = CGRectMake(0, 10, 300, 60);
    
    lblDirection.frame = CGRectMake(310, 10, 400, 60);
    
    backBtn.frame=CGRectMake(0, 408.5, 60, 207);
    }
    else if (appDelegate.isPortait == NO)
    {
    imagePickerVasastu.cameraOverlayView.frame = CGRectMake(0, 0, 1024, 768);
    vwOverlayView.frame = CGRectMake(0, 0, 1024, 1024);
    //return;
    
    [self addInterfaceOnCamera];
    
    imgViewInfo.frame=CGRectMake(0,648, 1024, 120);
    
    
    lblHeaderInfo.frame=CGRectMake(0, 648, 1024, 120);
    
    
    imgViewHeader.frame=CGRectMake(0,0, 1024, 60);
    
    
    lblPlace.frame = CGRectMake(0, 10, 350, 60);
    
    
    lblDirection.frame = CGRectMake(360, 10, 400, 60);
    
    
    backBtn.frame=CGRectMake(0, 280.5, 60, 207);
    }
    }

    
    func reloadDataWithDirection(direction : CLLocationDirection){
        
    }
    */
    
}
