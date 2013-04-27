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

- (void)pushController:(UIViewController *)controller completion:(NavigationBlock)completion
{
	// by default push from current controller
	[self pushController:controller from:self.currentController completion:completion];
}

- (void)pushController:(UIViewController *)controller from:(UIViewController*)fromController completion:(NavigationBlock)completion
{
	// step 1:
	//   pop all controllers from the fromController
	[self popFromController:fromController];
		 
	// step 3:
	//   position controller for animation and animate transition
	controller.view.frame = CGRectOffset(controller.view.frame, JAViewW(self.view), 0);
	[UIView animateWithDuration:0.3f
						  delay:0
						options:0
					 animations:^{
						 controller.view.frame = CGRectMake(0, JAViewY(controller.view), JAViewW(self.view), JAViewH(self.view));
					 }
					 completion:^(BOOL f) { if (f && completion) completion(); }];
	
	//   add controller to stack
	[_stackControllers addObject:controller];
	
	//   add controller view
	[self.view addSubview:controller.view];
}

- (void)popCurrentControllerWithCompletion:(NavigationBlock)completion
{
	// index of current controller
	NSInteger idx = [_stackControllers indexOfObject:self.currentController];
	
	// push from previous controller if exists
	[self popFromController:idx > 0 ? _stackControllers[idx-1] : nil];
}

- (void)popFromController:(UIViewController *)controller
{
	// step 1:
	//   determine the controllers to remove
	//   that is the controllers beyond the push hierarchy (or every one of the if nil)
	BOOL shouldRemove = NO;
	NSMutableArray* controllersToRemove = [NSMutableArray arrayWithCapacity:_stackControllers.count];
	for (UIViewController* c in _stackControllers)
	{
		if (shouldRemove || controller == nil)
			[controllersToRemove addObject:c];
		
		if (c == controller)
			shouldRemove = YES;
		
	}
	
	// step 2:
	//   remove controllers added in step 1
	for (UIViewController* c in controllersToRemove)
	{
		[UIView animateWithDuration:0.3f animations:^{
			c.view.frame = CGRectOffset(c.view.frame, JAViewW(self.view), 0);
		}];
		
		[_stackControllers removeObject:c];
	}
}

- (UIViewController *)currentController
{
	return [_stackControllers lastObject];
}
@end
