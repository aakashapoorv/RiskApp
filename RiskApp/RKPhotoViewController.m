//
//  RKPhotoViewController.m
//  RiskApp
//
//  Created by Aakash Apoorv on 29/9/15.
//  Copyright © 2015 Deloitte. All rights reserved.
//

// Photo View Controller, gets incident Title, Photo and GPS location and send to callServerToUpload in RKConnectionAgent

#import "RKPhotoViewController.h"
#import "UIImage+Resize.h"
#import "RKConnectionAgent.h"
#import "MBProgressHUD.h"
#import "RKSessionAgent.h"
#import "RKLoginViewController.h"

@interface RKPhotoViewController ()

@end

@implementation RKPhotoViewController

// this method is called after view is loaded in the memory
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageTakenFlag = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOut:) name:@"logOutNotification" object:nil];
    [self startLocationManager];
}

// Recieve memory warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// call camera, this will open camera on user device
-(void)takePhoto {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
#if TARGET_IPHONE_SIMULATOR // Use camera roll for simulator because camera only works in device
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#else
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
#endif
    
    imagePickerController.editing = YES;
    imagePickerController.delegate = (id)self;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

// call takePhoto method
- (IBAction)btnTakePhotoTapped:(id)sender
{
    [self takePhoto];
}

// Check is user have filled description and taken photo, if both are done then call uploadToServer method and show progress spinner
- (IBAction)btnPostTapped:(id)sender
{
    if(riskTitle.text.length == 0)
    {
        [self alertStatus:@"Enter Description" :@"Incomplete Information" :1];
    } else if (self.imageTakenFlag == 0) {
        [self alertStatus:@"Take Photo" :@"Incomplete Information" :1];
    } else {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Uploading";
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            // performing upload in GDC to avoid ui freeze
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSelector:@selector(uploadToServer) withObject:self afterDelay:0.1 ];
            });
        });
    }
}

// uploads incident (photo) to server
- (BOOL)uploadToServer
{
    CLLocation *curPos = self.locationManager.location;
    NSString *latitude = [[NSNumber numberWithDouble:curPos.coordinate.latitude] stringValue];
    NSString *longitude = [[NSNumber numberWithDouble:curPos.coordinate.longitude] stringValue];
    
    if ([RKConnectionAgent callServerToUpload:self.tempImage withTitle:riskTitle.text andLatitude:latitude andLongitude:longitude] )
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self alertStatus:@"Your photo is successfully submitted." :@"Success" :1];
        riskTitle.text = @"";
        return true;
    }
    [self alertStatus:@"Your photo is not submitted, There was some error" :@"Error" :1];
    
    return false;
}

// Hide keyboard when user press return key
-(BOOL) textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Image picker delegate methods
// select image after user have take the photo
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    // Resize the image from the camera
    UIImage *scaledImage = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(photo.frame.size.width, photo.frame.size.height) interpolationQuality:kCGInterpolationHigh];
    // Crop the image to a square (yikes, fancy!)
    UIImage *croppedImage = [scaledImage croppedImage:CGRectMake((scaledImage.size.width -photo.frame.size.width)/2, (scaledImage.size.height -photo.frame.size.height)/2, photo.frame.size.width, photo.frame.size.height)];
    // Show the photo on the screen
    photo.image = scaledImage;
    self.tempImage = croppedImage;
    self.imageTakenFlag = 1;
    [picker dismissViewControllerAnimated:NO completion:nil];
}

// remove image picker when user cancel
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:NO completion:nil];
}

// show alert message
- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}

// perform logout
- (void) logOut:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"logOutNotification"])
        [self.navigationController popToRootViewControllerAnimated:YES];
}

// Start location manager to get gps location
-(void)startLocationManager
{
    if (self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        self.locationManager.delegate = self;
    }
    [self.locationManager startUpdatingLocation];
}

// Stop location manager after getting location
- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%@", @"Core location has a position.");
    [self.locationManager stopUpdatingLocation];
}

// This will be called if Location Manager Failed
- (void) locationManager:(CLLocationManager *)manager
        didFailWithError:(NSError *)error
{
    NSLog(@"%@", @"Core location can't get a fix.");
}

@end
