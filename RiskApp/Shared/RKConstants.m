//
// Created by Aakash Apoorv on 27/9/15.
// Copyright (c) 2015 Deloitte. All rights reserved.
//

#import "RKConstants.h"

#define kServerUrl                  @"http://adist.in"
#define kRiskUrl                    kServerUrl@"/riskauth"

@implementation RKConstants

NSString *const kLoginEndPoint = kRiskUrl@"/login.php";
NSString *const kSignupEndPoint = kRiskUrl@"/signup.php";
NSString *const kUploadEndPoint = kRiskUrl@"/upload.php";

@end