//
//  FlickrPhoto.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "FlickrPhoto.h"

@implementation FlickrPhoto
@synthesize owner   = _owner;
@synthesize title   = _title;
@synthesize farm    = _farm;
@synthesize server  = _server;
@synthesize secret  = _secret; 

- (id)initWithJSONDictionary:(NSDictionary *)dic
{
    self = [super initWithJSONDictionary:dic];
    if (self)
    {
        self.title  = [dic objectForKey:@"title"];
        self.secret = [dic objectForKey:@"secret"];
        self.owner  = [dic objectForKey:@"owner"];
        self.farm   = [[dic objectForKey:@"farm"] integerValue];
        self.server = [[dic objectForKey:@"server"] integerValue];
    }
    return self;
}

- (void)dealloc
{
    self.title      = nil;
    self.secret     = nil;
    self.owner      = nil;
    
    [super dealloc];
}
@end
