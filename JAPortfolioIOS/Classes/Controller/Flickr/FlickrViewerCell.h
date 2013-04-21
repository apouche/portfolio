//
//  FlickrViewerCell.h
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/21/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrViewerCell : UICollectionViewCell

@property (nonatomic, readonly) UIImageView* imageView;

- (void)loadWithObject:(id)object;

@end
