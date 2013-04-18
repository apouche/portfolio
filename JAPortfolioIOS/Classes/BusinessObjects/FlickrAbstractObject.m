//
//  FlickrAbstractObject.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "FlickrAbstractObject.h"

@implementation FlickrAbstractObject
@synthesize mainId = mainId_;

- (id)initWithJSONDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        // basic init stuff goes here
    }
    
    return self;
}

- (void)dealloc
{
    self.mainId = nil;
    
    [super dealloc];
}

@end
