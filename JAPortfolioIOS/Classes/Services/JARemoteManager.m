//
//  JARemoteServices.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "JARemoteManager.h"

#import "AFNetworking.h"

// Business Objects
#import "FlickrPhotoList.h"

#define kFlickrAPIKey       @"6657762eead99eca9fb4389fbbf9df1c"
#define kFlickrAPISecret    @"c5a99b2e2da00a7b"

#define kFlickrAPIURLKey    @"http://api.flickr.com/services/rest"

@implementation JARemoteManager

#pragma mark -
#pragma mark Shared
#pragma mark -

+ (JARemoteManager *)sharedManager
{
    static id singleton = nil;
    if (singleton == nil)
        singleton = [[JARemoteManager alloc] init];
    
    return singleton;
}

- (void)handleJsonResult:(id)json withClass:(Class)iClass completion:(JABasicBlock)completion
{   
    // build the objects in a background thread so that no ui penalty result from it
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        id builtObjects = nil;
        
        // array found
        if ([json isKindOfClass:[NSArray class]])
        {
            NSArray* jArray = json;
            NSMutableArray* array = [NSMutableArray arrayWithCapacity:jArray.count];
            
            for (NSDictionary* jDic in jArray)
            {
                id obj = [[iClass alloc] initWithJSONDictionary:jDic];
                
                [array addObject:obj];
                
                [obj release];
            }
            
            // don't a let a mutable go back to the completion block
            builtObjects = [NSArray arrayWithArray:array];
        }
        
        // dic found
        else if ([json isKindOfClass:[NSDictionary class]])
        {
            id obj = [[[iClass alloc] initWithJSONDictionary:json] autorelease];

            builtObjects = obj;
        }
        
        // back on main thread, object have been built
        dispatch_async(dispatch_get_main_queue(), ^{
            // object built, no error => back on main thread
            if (completion)
                completion(builtObjects, nil);
        });

    });
}
               

#pragma mark -
#pragma mark Flickr
#pragma mark -

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
                      
                      // build correct business object
                      [self handleJsonResult:j withClass:[FlickrPhotoList class] completion:completion];
                  }
                  failure:^(NSURLRequest *req, NSHTTPURLResponse *resp, NSError *err, id j) {
                      JALogE(@"[%@] - Error : %@", req.URL, err);
                      JALogE(@"Json : %@, %@", j, req.HTTPBody);
                  }];
    
    [operation start];
}

@end
