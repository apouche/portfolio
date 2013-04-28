//
//  FlickrViewerViewController.h
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/21/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JAAbstractViewController.h"
// Forward Declaration
@class FlickrPhoto;

@interface FlickrViewerViewController : JAAbstractViewController <
	UICollectionViewDataSource,
	UICollectionViewDelegateFlowLayout
>
{
	BOOL	_loading;
	CGPoint _currentOffset;
}


@property (nonatomic, retain)	NSArray*			photos;
@property (nonatomic, retain)	FlickrPhoto*		currentPhoto;
@property (nonatomic, retain)	UICollectionView*	collectionView;

+ (UICollectionViewLayout*)layout;

- (FlickrPhoto*)objectAtIndexPath:(NSIndexPath*)path;
- (void)scrollToCurrentPhoto:(BOOL)animated;

#pragma mark Events

- (void)onTouchBackButton:(id)sender;

@end
