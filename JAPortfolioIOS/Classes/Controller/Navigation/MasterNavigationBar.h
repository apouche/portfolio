//
//  MasterNavigationBar.h
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/27/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JAAbstractViewController;

@interface MasterNavigationBar : UINavigationBar

- (void)pushNavigationItemsFromController:(JAAbstractViewController*)controller;
- (void)popNavigationItemsFromController:(JAAbstractViewController*)fromController
							toController:(JAAbstractViewController*)toController;

@end
