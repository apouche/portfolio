//
//  MasterNavigationController.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/27/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "MasterNavigationController.h"

// Managers
#import "JAControllerManager.h"

@interface MasterNavigationController ()

@end

@implementation MasterNavigationController

#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		_stackControllers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
	JAReleaseAndNil(_stackControllers);
	
	[super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
	[[JAControllerManager sharedManager] pushFlickInterestingControllerFrom:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark StackControllers
#pragma mark -

- (void)pushController:(UIViewController *)controller from:(UIViewController*)fromController completion:(NavigationBlock)completion
{
	// position controller for animation and animate transition
	controller.view.frame = CGRectOffset(controller.view.frame, JAViewW(self.view), 0);
	[UIView animateWithDuration:0.3f
						  delay:0
						options:0
					 animations:^{
						 controller.view.frame = CGRectMake(0, 0, JAViewW(self.view), JAViewH(self.view));
					 }
					 completion:^(BOOL f) { if (f && completion) completion(); }];
	
	// add controller to stack
	[_stackControllers addObject:controller];
	
	// add controller view
	[self.view addSubview:controller.view];
}

- (void)popCurrentControllerWithCompletion:(NavigationBlock)completion
{
	
}

@end
