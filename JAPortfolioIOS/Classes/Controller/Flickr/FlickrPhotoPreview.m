//
//  FlickrPhotoPreview.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "FlickrPhotoPreview.h"

// Categories
#import "UIImageView+AFNetworking.h"

// Business Objects
#import "FlickrPhoto.h"

@implementation FlickrPhotoPreview
@synthesize imageView = _imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _imageView.contentMode      = UIViewContentModeScaleAspectFit;
        _imageView.image            = [UIImage imageNamed:@"flickr_logo"];
        [self addSubview:_imageView];
        
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)dealloc
{
    self.imageView = nil;
    
    [super dealloc];
}

- (void)loadWithFlickrPhoto:(FlickrPhoto *)photo
{
    [_imageView setImageWithURL:photo.urlImage placeholderImage:[UIImage imageNamed:@"flickr_logo"]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
