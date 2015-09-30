//
// Created by Aakash Apoorv on 27/9/15.
// Copyright (c) 2015 Deloitte. All rights reserved.
//

#import "RKLoginAgent.h"
#import "RKConnectionAgent.h"
#import "RKApiFactory.h"
#import "RKConstants.h"

@implementation RKLoginAgent

NSString* errorMessage;

+ (BOOL)doLogin:(NSString *)username andPassword:(NSString *)password {
    NSInteger success = 0;
    
    NSError *error = nil;
    NSDictionary *jsonData = [NSJSONSerialization
                              JSONObjectWithData:[RKConnectionAgent callServerWithPostParameter:[NSString stringWithFormat:@"username=%@&password=%@",username,password] andApiEndPoint:kLoginEndPoint]
                              options:NSJSONReadingMutableContainers
                              error:&error];
    
    success = [jsonData[@"success"] integerValue];
    [RKApiFactory logger:[NSString stringWithFormat:@"Success: %ld",(long)success]];

    if(success)
    {
        [RKApiFactory logger:@"Login SUCCESS"];
        return true;
    } else {
        NSString *error_msg = (NSString *) jsonData[@"error_message"];
        errorMessage = error_msg;
        [RKApiFactory logger:error_msg];
    }

    return false;
}


+ (BOOL)doSignUp:(NSString *)email password:(NSString *)password andFullName:(NSString *) fullName
{
    NSInteger success = 0;

    NSError *error = nil;
    NSDictionary *jsonData = [NSJSONSerialization
            JSONObjectWithData:[RKConnectionAgent callServerWithPostParameter:[NSString stringWithFormat:@"email=%@&password=%@&name=%@",email,password,fullName] andApiEndPoint:kSignupEndPoint]
                       options:NSJSONReadingMutableContainers
                         error:&error];

    success = [jsonData[@"success"] integerValue];
    [RKApiFactory logger:[NSString stringWithFormat:@"Success: %ld",(long)success]];

    if(success)
    {
        [RKApiFactory logger:@"Login SUCCESS"];
        return true;
    } else {
        NSString *error_msg = (NSString *) jsonData[@"error_message"];
        errorMessage = error_msg;
        [RKApiFactory logger:error_msg];
    }

    return false;
}

@end