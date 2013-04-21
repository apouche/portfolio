//
//  FlickrViewerViewController.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/21/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "FlickrViewerViewController.h"

@interface FlickrViewerViewController ()

@end

@implementation FlickrViewerViewController
@synthesize scrollView		= _scrollView;
@synthesize photos			= _photos;
@synthesize currentPhoto	= _currentPhoto;

#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
	self.photos			= nil;
	self.currentPhoto	= nil;
	
	[super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	_scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	_scrollView.contentSize		= CGSizeMake(JAViewW(_scrollView)*_photos.count, JAViewH(_scrollView));
	_scrollView.delegate		= self;
	_scrollView.pagingEnabled	= YES;
	
	[self.view addSubview:_scrollView];
	
	// release objects that are retained by iOS view hierarchy
	[_scrollView release];
}

- (void)viewWillAppear:(BOOL)animated
{
	self.view.backgroundColor = [UIColor redColor];
	
	[self buildScrollViewWithPhotos:_photos selectedPhoto:_currentPhoto];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark FlickrViewerViewController
#pragma mark -

- (void)buildScrollViewWithPhotos:(NSArray*)photos selectedPhoto:(FlickrPhoto*)currentPhoto
{
	for (NSInteger i = 0; i < photos.count; ++i)
	{
//		FlickrPhoto* photo  = [photos objectAtIndex:i];
		
		UIImageView* imageview		= [[UIImageView alloc] initWithFrame:CGRectZero];
		imageview.autoresizingMask	= UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
		imageview.frame				= CGRectMake(i*JAViewW(_scrollView), 0, JAViewW(_scrollView), JAViewH(_scrollView));
	}
}

- (void)retrieveVisibleImages
{
	NSMutableArray* visibleImages = [NSMutableArray arrayWithCapacity:_scrollView.subviews.count];
	
	for (UIImageView* imageview in _scrollView.subviews)
	{
		if (JAViewX(imageview) >= _scrollView.contentOffset.x &&
			JAViewX(imageview) < _scrollView.contentOffset.x + JAViewW(_scrollView))
			[visibleImages addObject:imageview];
	}
	
	
}

#pragma mark -
#pragma mark Delegates
#pragma mark -

#pragma mark UIScrollViewDelegate



@end
