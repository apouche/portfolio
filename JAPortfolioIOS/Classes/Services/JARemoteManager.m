//
//  JARemoteServices.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "JARemoteManager.h"

#import "AFNetworking.h"

#define kFlickrAPIKey       @""
#define kFlickrAPISecret    @""

#define kFlickrAPIURLKey    @"http://api.flickr.com/services/rest"

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
    NSString* urlStr		= [NSString stringWithFormat:@"%@/?api_key=%@method=%@&format=json",
							   kFlickrAPIURLKey,
							   kFlickrAPIKey,
							   @"flickr.interestingness.getList"];
	
    AFJSONRequestOperation* operation   = nil;
    NSURLRequest *request               = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    
     operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                 success:^(NSURLRequest *req, NSHTTPURLResponse *resp, id j) {
                                                                     JALogD(@"%@", j);
                                                                 }
                                                                 failure:^(NSURLRequest *req, NSHTTPURLResponse *resp, NSError *err, id j) {
                                                                     JALogE(@"%@", err);
                                                                 }];
    [operation start];
}

@end
