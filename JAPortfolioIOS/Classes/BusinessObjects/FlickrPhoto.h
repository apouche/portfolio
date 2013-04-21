//
//  FlickrPhoto.h
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "FlickrAbstractObject.h"

@interface FlickrPhoto : FlickrAbstractObject

@property (nonatomic, assign) NSInteger farm;
@property (nonatomic, assign) NSInteger server;

@property (nonatomic, retain) NSString* owner;
@property (nonatomic, retain) NSString* secret;
@property (nonatomic, retain) NSString* title;


- (NSURL*)urlSmallSquare;

@end
