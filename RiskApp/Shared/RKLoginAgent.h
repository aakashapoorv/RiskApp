//
// Created by Aakash Apoorv on 27/9/15.
// Copyright (c) 2015 Deloitte. All rights reserved.
//

#import "RKConstants.h"

@interface RKLoginAgent : NSObject
+ (BOOL)doLogin:(NSString *)username andPassword:(NSString *)password;
+ (BOOL)doSignUp:(NSString *)email password:(NSString *)password andFullName:(NSString *) fullName;
extern NSString *errorMessage;
@end