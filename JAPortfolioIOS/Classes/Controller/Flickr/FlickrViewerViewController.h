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

@interface FlickrViewerViewController : UICollectionViewController <UIScrollViewDelegate>

@property (nonatomic, readonly) UIScrollView*	scrollView;
@property (nonatomic, retain)	NSArray*		photos;
@property (nonatomic, retain)	FlickrPhoto*	currentPhoto;

- (void)buildScrollViewWithPhotos:(NSArray*)photos selectedPhoto:(FlickrPhoto*)photo;
- (void)retrieveVisibleImages;

@end
