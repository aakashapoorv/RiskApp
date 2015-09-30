//
// Created by Aakash Apoorv on 27/9/15.
// Copyright (c) 2015 Deloitte. All rights reserved.
//

// Login View Controller, gets email and password from user ahd calls login method in RKLoginAgent

#import "RKLoginViewController.h"
#import "RKLoginAgent.h"
#import "MBProgressHUD.h"
#import "RKSessionAgent.h"
#import "RKPhotoViewController.h"

@interface RKLoginViewController ()

@end

@implementation RKLoginViewController

// calls doSignIn method and show progress spinner
- (IBAction)signIn:(id)sender {

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Logging in";

    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
         // performing doSignIn in GDC to avoid ui freeze
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSelector:@selector(doSignIn) withObject:self afterDelay:0.1 ];
        });
    });
}

// perfrom sign in by sending email and password to login agent
- (BOOL)doSignIn
{
    // if signin success then show Photo View
    if ([RKLoginAgent doLogin:[self.email text] andPassword:[self.password text]])
    {
        // Show success message and hide progress spinner
        [self alertStatus:@"Logged in successfully" :@"Success!" :1];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        // Change session to true and save email for further reference
        RKSessionAgent *session = [RKSessionAgent sharedManager];
        session.isLoggedin = 1;
        [defaults setObject:[self.email text] forKey:@"email"];
        [defaults synchronize];
        
        // call photo view
        RKPhotoViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"photoViewController"];
        [self.navigationController pushViewController:viewController animated:YES];

        return true;
    }

    // this will be called when sign in is not sucessfull
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self alertStatus:@"Username and/or password is invalid." :@"Error!" :0];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"nil@nil.com" forKey:@"email"];
    [defaults synchronize];

    return false;
}

// Show alert message
- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}

@end