//
//  MenuViewController.h
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/27/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
	NSDictionary*			_sections;
}

@property (nonatomic, readonly) UITableView* tableView;

- (id)objectAtIndexPath:(NSIndexPath*)path;

@end
