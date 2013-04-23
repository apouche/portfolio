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
#import "UIScrollView+JAPortfolio.h"

#define kViewerParallaxOffsetMaxX	100.f
#define kViewerParallaxOffsetMaxY	50.f
#define kViewerParallaxOffsetSmooth 0.3f

@implementation FlickrViewerCell
@synthesize imageView = _imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		
		// make image slightly bigger for the parralax effect
		CGRect imgFrame = CGRectInset(self.bounds, -kViewerParallaxOffsetMaxX, 0);
		
		// make black background frame
		CGRect blkFrame = CGRectInset(self.bounds, 3, 0);
		
		// build imageview
		_imageView = [[UIImageView alloc] initWithFrame:imgFrame];
		_imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
		_imageView.contentMode		= UIViewContentModeScaleAspectFill;
		_imageView.clipsToBounds	= YES;
		_imageView.layer.borderWidth= 5.f;
		_imageView.layer.borderColor= [UIColor blackColor].CGColor;
		
		// image holder
		UIView* imgHolder = [[UIView alloc] initWithFrame:blkFrame];
		imgHolder.clipsToBounds		= YES;
		imgHolder.backgroundColor	= [UIColor blackColor];
		
		[imgHolder addSubview:_imageView];
		
		[self addSubview:imgHolder];
		[self setClipsToBounds:YES];
		
		// safe release as it's retained in the view hierarchy
		[_imageView release];
		
    }
    return self;
}

- (void)loadWithObject:(FlickrPhoto*)photo fromList:(NSArray *)photos
{
	self.tag = [photos indexOfObject:photo];
	
	[_imageView setImageWithURL:photo.urlLarge placeholderImage:[UIImage imageNamed:@"flickr_logo"]];
}

- (void)handleParallaxWithScrollOffset:(CGPoint)offset direction:(UIScrollViewDirection)direction
{
	CGFloat absoluteX = JAViewW(self)*self.tag;
	
	CGFloat shift = //(ABS(offset.x - absoluteX) > kViewerParallaxOffsetMaxX ?
					// kViewerParallaxOffsetMaxX :
					 ABS(offset.x - absoluteX);
	CGFloat sign  = direction == UIScrollViewDirectionRight < offset.x ? -1.f : 1.f;
	
	_imageView.frame = CGRectMake(shift*sign*kViewerParallaxOffsetSmooth, JAViewY(_imageView), JAViewW(_imageView), JAViewH(_imageView));
					 
	
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
