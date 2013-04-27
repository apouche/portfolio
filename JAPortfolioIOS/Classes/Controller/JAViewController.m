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


@interface JAViewController ()

@end

@implementation JAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.    
}

- (void)viewDidAppear:(BOOL)animated
{
	MasterNavigationController* navController = [[MasterNavigationController alloc] initWithNibName:nil bundle:nil];
	
//    FlickrViewController* nextController = [[FlickrViewController alloc] initWithNibName:nil bundle:nil];
	
    navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    navController.modalPresentationStyle = UIModalPresentationFullScreen;
	
    [self presentViewController:navController animated:YES completion:nil];
    
	
	[navController release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
