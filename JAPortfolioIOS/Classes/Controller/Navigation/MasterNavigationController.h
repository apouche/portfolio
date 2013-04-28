//
//  MasterNavigationController.h
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/27/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NavigationBlock)(void);

@class MenuViewController;
@class MasterNavigationBar;

@interface MasterNavigationController : UIViewController
{
	NSMutableArray*		_stackControllers;
	MenuViewController* _menuController;
	
	MasterNavigationBar* _navBar;
	
	UIView* _panningView;
}

#pragma mark StackControllers

- (void)pushController:(UIViewController *)controller completion:(NavigationBlock)completion;
- (void)pushController:(UIViewController *)controller from:(UIViewController*)fromController completion:(NavigationBlock)completion;
- (void)popCurrentControllerWithCompletion:(NavigationBlock)completion;
- (void)popFromController:(UIViewController*)controller;

- (UIViewController*)currentController;

@end
