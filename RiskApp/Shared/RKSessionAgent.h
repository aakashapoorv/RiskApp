//
// Created by Aakash Apoorv on 30/9/15.
// Copyright (c) 2015 Deloitte. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RKSessionAgent : NSObject {
    NSString *session;
    NSInteger isLoggedin;
}
@property (nonatomic, retain) NSString *session;
@property (nonatomic) NSInteger isLoggedin;

+ (id)sharedManager;

@end