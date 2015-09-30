//
//  RKPhotoViewController.h
//  RiskApp
//
//  Created by Aakash Apoorv on 29/9/15.
//  Copyright © 2015 Deloitte. All rights reserved.
//

// Photo View Controller, gets incident Title, Photo and GPS location and send to callServerToUpload in RKConnectionAgent

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "RESideMenu.h"

@interface RKPhotoViewController : UIViewController<UIImagePickerControllerDelegate,UITextFieldDelegate,RESideMenuDelegate,CLLocationManagerDelegate>
{
    IBOutlet UIImageView *photo; // to display clicked photo
    __weak IBOutlet UITextField *riskTitle; // to get incident title
}

@property (strong, nonatomic) UIImage *tempImage; // for referencing clicked image which uploaded to server later
@property NSInteger *imageTakenFlag; // To check if user have taken photo or not
@property (nonatomic, retain) CLLocationManager *locationManager;
- (IBAction)btnTakePhotoTapped:(id)sender; // button to take photo
- (IBAction)btnPostTapped:(id)sender; // button to post photo


@end
