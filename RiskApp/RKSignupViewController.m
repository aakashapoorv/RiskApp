//
// Created by Aakash Apoorv on 27/9/15.
// Copyright (c) 2015 Deloitte. All rights reserved.
//

// Sign Up View Controller, gets name, email and password from user ahd calls signup method in RKLoginAgent

#import "RKSignupViewController.h"
#import "RKLoginAgent.h"
#import "MBProgressHUD.h"

@interface RKSignupViewController ()

@end

@implementation RKSignupViewController

// calls signup method and show progress spinner
- (IBAction)signup:(id)sender {
    
    if (![self.password.text isEqualToString:self.paswordAgain.text])
    {
        
        [self alertStatus:@"Password did'nt match." :@"Error!" :1];
    } else {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Signing Up";

        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            // Do something...
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSelector:@selector(doSignUp) withObject:self afterDelay:0.1 ];
            });
        });
    }
}

// perfrom sign un by sending name, email and password to login agent
- (BOOL)doSignUp
{
    if ([RKLoginAgent doSignUp:[self.email text] password:[self.password text] andFullName:[self.fullname text]])
    {
        // Show success message and hide progress spinner
        [self alertStatus:@"Signed up successfully, Login now" :@"Success!" :1];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //Trigger left menu
        [self.navigationController presentLeftMenuViewController:self];
        return true;
    } else {
        // Show error if email is already in use 
        [self alertStatus:@"Email already resigtered, use different email" :@"Error!" :1];
        return true;
    }
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