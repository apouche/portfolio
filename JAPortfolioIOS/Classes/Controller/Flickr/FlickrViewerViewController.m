//
//  FlickrViewerViewController.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/21/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "FlickrViewerViewController.h"
#import "FlickrViewerCell.h"

// Managers
#import "JAControllerManager.h"

// Categories
#import "UIScrollView+JAPortfolio.h"

#define kFlickrViewerCellIdentifer @"kFlickrViewerCellIdentifer"

@interface FlickrViewerViewController ()

@end

@implementation FlickrViewerViewController
@synthesize photos			= _photos;
@synthesize currentPhoto	= _currentPhoto;
@synthesize collectionView	= _collectionView;

#pragma mark -
#pragma mark UIViewController
#pragma mark -

+ (UICollectionViewLayout *)layout
{
	UICollectionViewFlowLayout* layout	= [[[UICollectionViewFlowLayout alloc] init] autorelease];
	layout.itemSize						= JARealScreenSize;
	layout.minimumLineSpacing			= 0;
	layout.minimumInteritemSpacing		= 0;
	layout.scrollDirection				= UICollectionViewScrollDirectionHorizontal;
	return layout;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self)
	{
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
	
	// ----------------------
	// Back Button
	// ----------------------
	_collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[FlickrViewerViewController layout]];
	[_collectionView registerClass:[FlickrViewerCell class] forCellWithReuseIdentifier:kFlickrViewerCellIdentifer];
	[_collectionView setPagingEnabled:YES];
	[_collectionView setDataSource:self];
	[_collectionView setDelegate:self];

	UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
	backButton.frame = CGRectMake(10, 10, 28, 28);
	[backButton setImage:[UIImage imageNamed:@"gly_circle_west"] forState:UIControlStateNormal];
	[backButton addTarget:self action:@selector(onTouchBackButton:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:_collectionView];
	[self.view addSubview:backButton];
	
}

- (void)viewWillAppear:(BOOL)animated
{
	_loading = YES;
	
	self.view.backgroundColor = [UIColor redColor];
	
	// reload data (based on _photos)
	[self.collectionView reloadData];
	
	// since the reloading process is not instant, we must call the scroll method after a small delay
	[self performSelector:@selector(scrollToCurrentPhoto:) withObject:@NO afterDelay:0.1f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark JAAbstractController
#pragma mark -

- (BOOL)isNavBarTransparent
{
	return YES;
}

#pragma mark -
#pragma mark FlickrViewerViewController
#pragma mark -

- (FlickrPhoto *)objectAtIndexPath:(NSIndexPath *)path
{
	if (path.row < _photos.count)
		return _photos[path.row];
	
	return nil;
}

- (void)scrollToCurrentPhoto:(BOOL)animated
{
	NSInteger idx = [_photos indexOfObject:_currentPhoto];
	if (idx != NSNotFound)
	{
		CGRect rect = CGRectMake(idx*JAViewW(self.collectionView), 0, JAViewW(self.collectionView), JAViewH(self.collectionView));
		[self.collectionView scrollRectToVisible:rect animated:NO];
	}
	_loading = NO;
}

#pragma mark -
#pragma mark Delegates
#pragma mark -

#pragma mark UICollectionViewDelegateFlowLayout

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	FlickrViewerCell* cell = nil;
	
	cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFlickrViewerCellIdentifer forIndexPath:indexPath];
	
	if (cell == nil)
	{
		cell = [[[FlickrViewerCell alloc] initWithFrame:self.view.bounds] autorelease];
	}
	
	[cell loadWithObject:[self objectAtIndexPath:indexPath] fromList:_photos];
	
	return cell;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return _photos.count;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// determine scroll direction
	UIScrollViewDirection direction = UIScrollViewDirectionUnknown;
	
	if (scrollView.contentOffset.x < _currentOffset.x)
		direction = UIScrollViewDirectionLeft;
	else if (scrollView.contentOffset.x > _currentOffset.x)
		direction = UIScrollViewDirectionRight;
	
	// retrieve visible cells
	NSArray* visibleCells = [self.collectionView visibleCells];
	
	if (_loading)
		return;
	
	// perform parallax effect on them
	for (FlickrViewerCell* cell in visibleCells)
		[cell handleParallaxWithScrollOffset:scrollView.contentOffset direction:direction];
}



#pragma mark -
#pragma mark Events
#pragma mark -

- (void)onTouchBackButton:(id)sender
{
	[[JAControllerManager sharedManager] dismissController:self];
}

@end
