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
@synthesize imageView	= _imageView;
@synthesize tapGesture	= _tapGesture;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView					= [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _imageView.contentMode      = UIViewContentModeScaleAspectFit;
        _imageView.image            = [UIImage imageNamed:@"flickr_logo"];
		
		// no target at first
		_tapGesture	= [[UITapGestureRecognizer alloc] initWithTarget:nil action:nil];
		
        [self addSubview:_imageView];
		[self addGestureRecognizer:_tapGesture];
        
		// safe release as these object are retained by the ios hierarchy
		[_imageView release];
		[_tapGesture release];
		
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)loadWithFlickrPhoto:(FlickrPhoto *)photo index:(NSUInteger)idx
{
	self.tag = idx;
	
    [_imageView setImageWithURL:photo.urlSmallSquare placeholderImage:[UIImage imageNamed:@"flickr_logo"]];
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
