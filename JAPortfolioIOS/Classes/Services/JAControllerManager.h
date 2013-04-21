//
//  JAControllerManager.h
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/21/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import <Foundation/Foundation.h>

// Forward Declarations
@class FlickrPhoto;

@interface JAControllerManager : NSObject

+ (JAControllerManager *)sharedManager;

- (void)pushFlickrViewerFrom:(UIViewController*)controller photo:(FlickrPhoto *)photo fromList:(NSArray *)photos;
- (void)dismissController:(UIViewController*)controller;

@end
