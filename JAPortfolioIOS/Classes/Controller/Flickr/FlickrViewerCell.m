//
//  FlickrViewerCell.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/21/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "FlickrViewerCell.h"

// Business Objects
#import "FlickrPhoto.h"

// Categories
#import "UIImageView+AFNetworking.h"

@implementation FlickrViewerCell
@synthesize imageView = _imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		
		_imageView = [[UIImageView alloc] initWithFrame:self.bounds];
		_imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
		_imageView.contentMode		= UIViewContentModeScaleAspectFill;
		_imageView.clipsToBounds	= YES;
		
		[self addSubview:_imageView];
		
		// safe release as it's retained in the view hierarchy
		[_imageView release];
		
    }
    return self;
}

- (void)loadWithObject:(FlickrPhoto*)photo
{
	[_imageView setImageWithURL:photo.urlLarge placeholderImage:[UIImage imageNamed:@"flickr_logo"]];
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
