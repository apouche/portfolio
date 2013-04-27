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
	NSArray*			_sections;
}

@property (nonatomic, readonly) UITableView* tableView;

@end
