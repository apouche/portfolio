//
//  FlickrPhotoPreview.h
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlickrPhoto;

@interface FlickrPhotoPreview : UIView

@property (nonatomic, retain) UIImageView* imageView;

- (void)loadWithFlickrPhoto:(FlickrPhoto*)photo;

@end
