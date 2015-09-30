//
// Created by Aakash Apoorv on 27/9/15.
// Copyright (c) 2015 Deloitte. All rights reserved.
//

#import "RKDefine.h"
#import <UIKit/UIKit.h>

@interface RKConnectionAgent : NSObject
+ (NSData *) callServerWithPostParameter:(NSString *) parameter andApiEndPoint:(NSString *) endPoint;
+ (BOOL)callServerToUpload:(UIImage*) image withTitle:(NSString *) title andLatitude:(NSString *) latitude andLongitude:(NSString *) longitude;
@end