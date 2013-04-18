//
//  JAViewController.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

// Controllers
#import "JAViewController.h"
#import "FlickrViewController.h"

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
    FlickrViewController* nextController = [[FlickrViewController alloc] initWithNibName:nil bundle:nil];
    nextController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    nextController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nextController animated:YES completion:nil];
    [nextController release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
