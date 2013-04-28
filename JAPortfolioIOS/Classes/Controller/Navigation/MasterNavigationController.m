//
//  MasterNavigationController.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/27/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

// Controllers
#import "MasterNavigationController.h"
#import "MenuViewController.h"
#import "JAAbstractViewController.h"
// Views
#import "MasterNavigationBar.h"

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
	JAReleaseAndNil(_menuController);
	JAReleaseAndNil(_navBar);
	JAReleaseAndNil(_panningView);
	
	[super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Do any additional setup after loading the view.
	_menuController = [[MenuViewController alloc] initWithNibName:nil bundle:nil];
	_menuController.view.frame = CGRectMake(0, 0, JAViewW(self.view), JAViewH(self.view));
	
	_panningView = [[UIView alloc] initWithFrame:CGRectMake(JAViewW(self.view), 0, JAViewW(self.view), JAViewH(self.view))];
	_panningView.backgroundColor = [UIColor clearColor];
	
	_navBar = [[MasterNavigationBar alloc] initWithFrame:CGRectMake(0, 0, JAViewW(self.view), 40)];
	_navBar.alpha = 1.f;
	[_navBar.menuButton addTarget:self action:@selector(onTouchMenuButton:) forControlEvents:UIControlEventTouchUpInside];
	
	[_panningView addSubview:_navBar];
	
	[self.view addSubview:_menuController.view];
	[self.view addSubview:_panningView];
}

- (void)viewDidAppear:(BOOL)animated
{
//	[[JAControllerManager sharedManager] pushFlickInterestingControllerFrom:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Pan Related
#pragma mark -

- (void)shiftPanViewToOffset:(CGFloat)offset
{
	[_panningView.layer removeAllAnimations];
	[UIView animateWithDuration:0.35f
						  delay:0.f
						options:UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 _panningView.frame = CGRectMake(offset,
														 JAViewY(_panningView),
														 JAViewW(_panningView),
														 JAViewH(_panningView));
					 }
					 completion:nil];
}

#pragma mark -
#pragma mark StackControllers
#pragma mark -

- (void)pushController:(UIViewController *)controller completion:(NavigationBlock)completion
{
	// by default push from current controller
	[self pushController:controller from:self.currentController completion:completion];
}

- (void)pushController:(JAAbstractViewController*)controller from:(UIViewController*)fromController completion:(NavigationBlock)completion
{
	// step 1:
	//   pop all controllers from the fromController
	[self popFromController:fromController];
	
	// step 2: TODO
	//   push navbar items
	[_navBar pushNavigationItemsFromController:controller];
	
	// step 3:
	//   position controller for animation and animate transition
	CGFloat x = JAViewX(_panningView) > 0.f ? 0 : JAViewW(self.view);
	CGFloat y = controller.isNavBarTransparent ? 0 : JAViewH(_navBar);
	
	controller.view.frame = CGRectMake(x, y, JAViewW(self.view), JAViewH(self.view)-y);
	
	[UIView animateWithDuration:0.3f
						  delay:0
						options:0
					 animations:^{
						 if (JAViewX(_panningView) > 0.f)
							 _panningView.frame = CGRectOffset(_panningView.frame, -JAViewX(_panningView), 0);
						 else
							 controller.view.frame = CGRectMake(0, JAViewY(controller.view), JAViewW(controller.view), JAViewH(controller.view));
					 }
					 completion:^(BOOL f) { if (f && completion) completion(); }];
	
	//   add controller to stack
	[_stackControllers addObject:controller];
	
	//   add controller view
	[_panningView insertSubview:controller.view belowSubview:_navBar];
}

- (void)popCurrentControllerWithCompletion:(NavigationBlock)completion
{
	// index of current controller
	NSInteger idx = [_stackControllers indexOfObject:self.currentController];
	
	// push from previous controller if exists
	[self popFromController:idx > 0 ? _stackControllers[idx-1] : nil];
}

- (void)popFromController:(JAAbstractViewController *)controller
{
	NSInteger idx = [_stackControllers indexOfObject:controller];
	
	JAAbstractViewController* lastController = idx == 0 || idx == NSNotFound ? nil : _stackControllers[idx-1];
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
		[UIView animateWithDuration:0.3f
						 animations:^{
							 c.view.frame = CGRectOffset(c.view.frame, JAViewW(self.view), 0);
						 }
						 completion:^(BOOL finished) {
							 if (finished)
								 [c.view removeFromSuperview];
						 }];
		
		[_stackControllers removeObject:c];
	}
	
	// step 3
	//   pop navbar items
	[_navBar popNavigationItemsFromController:controller toController:lastController];
}

- (UIViewController *)currentController
{
	return [_stackControllers lastObject];
}


#pragma mark -
#pragma mark Events
#pragma mark -

- (void)onTouchMenuButton:(id)sender
{
	[self shiftPanViewToOffset:JAViewX(_panningView) > 0 ? 0 : 250.f];
}

@end
