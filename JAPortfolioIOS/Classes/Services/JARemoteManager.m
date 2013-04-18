//
//  JARemoteServices.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "JARemoteManager.h"

#import "AFNetworking.h"

#define kFlickrAPIKey       @"6657762eead99eca9fb4389fbbf9df1c"
#define kFlickrAPISecret    @"c5a99b2e2da00a7b"

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
    NSString* urlStr		= [NSString stringWithFormat:@"%@/?api_key=%@&method=%@&format=json&&nojsoncallback=1",
							   kFlickrAPIURLKey,
							   kFlickrAPIKey,
							   @"flickr.interestingness.getList"];
	
    AFJSONRequestOperation* operation   = nil;
    NSURLRequest *request               = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    
     operation = [AFJSONRequestOperation
                  JSONRequestOperationWithRequest:request
                  success:^(NSURLRequest *req, NSHTTPURLResponse *resp, id j) {
                      JALogD(@"%@", j);
                  }
                  failure:^(NSURLRequest *req, NSHTTPURLResponse *resp, NSError *err, id j) {
                      JALogE(@"[%@] - Error : %@", req.URL, err);
                      JALogE(@"Json : %@, %@", j, req.HTTPBody);
                  }];
    [operation start];
}

@end
