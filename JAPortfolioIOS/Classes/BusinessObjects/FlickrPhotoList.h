//
//  FlickrPhotoList.h
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "FlickrAbstractObject.h"

@interface FlickrPhotoList : FlickrAbstractObject

@property (nonatomic, retain) NSArray*      photos;
@property (nonatomic, assign) NSInteger     page;
@property (nonatomic, assign) NSInteger     pages;

@end
