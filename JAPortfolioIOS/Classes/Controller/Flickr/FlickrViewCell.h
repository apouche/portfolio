//
//  FlickrViewCell.h
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrViewCell : UITableViewCell
{

}

@property (nonatomic, retain) NSArray* previews;

- (void)loadWithObject:(NSArray *)photos fromList:(NSArray*)listPhotos;

@end
