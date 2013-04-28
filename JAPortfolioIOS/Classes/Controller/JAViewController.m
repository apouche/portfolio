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
	
	UIImageView* splash			= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default"]];
	splash.frame				= CGRectOffset(splash.frame, 0, -20);
	splash.autoresizingMask		= UIViewAutoresizingFlexibleHeight;
	
	[self.view addSubview:splash];
}

- (void)viewDidAppear:(BOOL)animated
{
//	[self loadMainController];
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
	
    [self presentViewController:navController animated:YES completion:nil];
	
	// inform the controller manager about the master creation
	[[JAControllerManager sharedManager] setMasterController:navController];
	
	// safe release as the master will be retained by the iOS view hierarchy
	[navController release];
}

@end
