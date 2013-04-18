//
//  FlickrPhotoList.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "FlickrPhotoList.h"
#import "FlickrPhoto.h"

@implementation FlickrPhotoList
@synthesize photos  = _photos;
@synthesize page    = _page;
@synthesize pages   = _pages;

- (id)initWithJSONDictionary:(NSDictionary *)dic
{
    self = [super initWithJSONDictionary:dic];
    if (self)
    {
        self.pages = [[dic objectForKey:@"pages"] integerValue];
        self.page = [[dic objectForKey:@"page"] integerValue];
        
        // photos (json -> object)
        NSArray* jPhotos        = [dic objectForKey:@"photo"];
        NSMutableArray* photos  = [NSMutableArray arrayWithCapacity:jPhotos.count];
        for (NSDictionary* jPhoto in jPhotos)
        {
            FlickrPhoto* photo = [[FlickrPhoto alloc] initWithJSONDictionary:jPhoto];
            
            [photos addObject:jPhoto];
            
            [photo release];
        }
        
        // don't let the mutable go through
        self.photos = [NSArray arrayWithArray:photos];

    }
    return self;
}

- (void)dealloc
{
    self.photos = nil;
    
    [super dealloc];
}
@end
