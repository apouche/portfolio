//
//  FlickrViewerViewController.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/21/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "FlickrViewerViewController.h"
#import "FlickrViewerCell.h"

#define kFlickrViewerCellIdentifer @"kFlickrViewerCellIdentifer"

@interface FlickrViewerViewController ()

@end

@implementation FlickrViewerViewController
@synthesize photos			= _photos;
@synthesize currentPhoto	= _currentPhoto;

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

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
	self = [super initWithCollectionViewLayout:layout];
	if (self)
	{
		[self.collectionView registerClass:[FlickrViewerCell class] forCellWithReuseIdentifier:kFlickrViewerCellIdentifer];
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
	
	self.collectionView.pagingEnabled = YES;
	self.view.backgroundColor = [UIColor greenColor];
}

- (void)viewWillAppear:(BOOL)animated
{
	self.view.backgroundColor = [UIColor redColor];
	
	[self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
	
	[cell loadWithObject:[self objectAtIndexPath:indexPath]];
	
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



@end
