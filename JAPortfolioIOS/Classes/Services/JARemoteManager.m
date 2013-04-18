//
//  JARemoteServices.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "JARemoteManager.h"



#define kFlickrAPIKey       @""
#define kFlickrAPISecret    @""

@implementation JARemoteManager

+ (JARemoteManager *)sharedManager
{
    static id singleton = nil;
    if (singleton == nil)
        singleton = [[JARemoteManager alloc] init];
    
    return singleton;
}

- (void)retrieveFlickrMostInteresting:(NSInteger)page completion:(JABasicBlock)completion
{
    
}

@end
