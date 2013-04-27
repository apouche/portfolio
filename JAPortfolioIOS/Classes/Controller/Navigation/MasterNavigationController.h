//
//  MasterNavigationController.h
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/27/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NavigationBlock)(void);

@interface MasterNavigationController : UIViewController
{
	NSMutableArray* _stackControllers;
}

#pragma mark StackControllers

- (void)pushController:(UIViewController *)controller from:(UIViewController*)fromController completion:(NavigationBlock)completion;
- (void)popCurrentControllerWithCompletion:(NavigationBlock)completion;

- (UIViewController*)currentController;

@end
