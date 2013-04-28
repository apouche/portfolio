//
//  FlickrViewController.h
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JAAbstractViewController.h"

typedef enum e_flickr_section
{
    kFlickrSectionPhotos = 0,
    kFlickrSectionLoadMore,
    
    // keep at the end
    kFlickrSectionCount
}FlickrSection;
@interface FlickrViewController : JAAbstractViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSInteger _currentPage;
}

@property (nonatomic, retain) UITableView*      tableview;
@property (nonatomic, retain) NSMutableArray*   photos;

#pragma mark Business Objects

- (void)retrieveBusinessObjects;

- (NSArray*)photosAtIndexPath:(NSIndexPath*)path;
- (id)objectFromView:(UIView*)preview;

#pragma mark Events

- (void)onTapFlickrPreview:(id)sender;

@end
