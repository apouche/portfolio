//
//  FlickrViewController.h
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum e_flickr_section
{
    kFlickrSectionPhotos = 0,
    kFlickrSectionLoadMore,
    
    // keep at the end
    kFlickrSectionCount
}FlickrSection;
@interface FlickrViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
}

@property (nonatomic, retain) UITableView*      tableview;
@property (nonatomic, retain) NSMutableArray*   photos;

- (void)retrieveBusinessObjects;
- (NSArray*)photosAtIndexPath:(NSIndexPath*)path;

@end
