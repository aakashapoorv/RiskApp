//
// Created by Aakash Apoorv on 27/9/15.
// Copyright (c) 2015 Deloitte. All rights reserved.
//

// Sign Up View Controller, gets name, email and password from user ahd calls signup method in RKLoginAgent

#import <UIKit/UIKit.h>
#import "RESideMenu.h"


@interface RKSignupViewController : UIViewController <UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *fullname; // to get full name
@property (weak, nonatomic) IBOutlet UITextField *password; // to get password
@property (weak, nonatomic) IBOutlet UITextField *email; // to get email
@property (weak, nonatomic) IBOutlet UITextField *paswordAgain; // to to verify password
- (IBAction)signup:(id)sender;

@end