//
//  JAViewController.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

// Controllers
#import "JAViewController.h"
#import "MasterNavigationController.h"

// Managers
#import "JAControllerManager.h"

// Categories
#import "UIImage+JAPortfolio.h"

@interface JAViewController ()

@end

@implementation JAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	_splashView = [[UIView alloc] initWithFrame:self.view.bounds];
	
	UIImageView* splashImage		= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default"]];
	splashImage.frame				= CGRectOffset(splashImage.frame, 0, -20);
	splashImage.autoresizingMask	= UIViewAutoresizingFlexibleHeight;
	
	[_splashView addSubview:splashImage];
	[self.view addSubview:_splashView];
	
	[splashImage release];
	[_splashView release];
}

- (void)viewDidAppear:(BOOL)animated
{	
	// show information after a short delay to stay on the splash screen a few more seconds
	[self performSelector:@selector(loadInformation) withObject:nil afterDelay:1.f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMainController
{
	// Create the master controller
	MasterNavigationController* navController = [[MasterNavigationController alloc] initWithNibName:nil bundle:nil];
	
    navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    navController.modalPresentationStyle = UIModalPresentationFullScreen;
	
    [self presentViewController:navController animated:YES completion:^{
		// don't keep useless views into memory
		[_splashView removeFromSuperview];
	}];
	
	// inform the controller manager about the master creation
	[[JAControllerManager sharedManager] setMasterController:navController];
	
	// safe release as the master will be retained by the iOS view hierarchy
	[navController release];
}

- (void)loadInformation
{
	UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, JAViewH(self.view)-50, JAViewW(self.view)-30, 20)];
	label.font				= [UIFont fontWithName:@"Open Sans" size:15];
	label.text				= @"test iOS Portolio";
	label.backgroundColor	= [UIColor clearColor];
	label.textAlignment		= UITextAlignmentRight;
	label.textColor			= JARGB(175, 175, 175);
	label.alpha				= 0.f;
	
	[_splashView addSubview:label];
	
	[UIView animateWithDuration:3.f animations:^{ label.alpha = 1.f; }];
	
	[self performSelector:@selector(loadMainController) withObject:nil afterDelay:4.f];
	
	[label release];

}
@end
