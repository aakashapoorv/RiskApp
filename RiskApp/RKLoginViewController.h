//
// Created by Aakash Apoorv on 27/9/15.
// Copyright (c) 2015 Deloitte. All rights reserved.
//

// Login View Controller, gets email and password from user ahd calls login method in RKLoginAgent

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface RKLoginViewController : UIViewController

- (IBAction)signIn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end
