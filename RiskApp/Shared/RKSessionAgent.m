//
// Created by Aakash Apoorv on 30/9/15.
// Copyright (c) 2015 Deloitte. All rights reserved.
//

#import "RKSessionAgent.h"


@implementation RKSessionAgent

@synthesize session, isLoggedin;

+ (id)sharedManager {
    static RKSessionAgent *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        session = @"nilSession";
        isLoggedin = 0;
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end