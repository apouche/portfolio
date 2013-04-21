//
//  FlickrViewerViewController.h
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/21/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import <UIKit/UIKit.h>

// Forward Declaration
@class FlickrPhoto;

@interface FlickrViewerViewController : UICollectionViewController <
	UICollectionViewDataSource,
	UICollectionViewDelegateFlowLayout
>


@property (nonatomic, retain)	NSArray*		photos;
@property (nonatomic, retain)	FlickrPhoto*	currentPhoto;

+ (UICollectionViewLayout*)layout;

- (FlickrPhoto*)objectAtIndexPath:(NSIndexPath*)path;
- (void)scrollToCurrentPhoto:(BOOL)animated;

#pragma mark Events

- (void)onTouchBackButton:(id)sender;

@end
