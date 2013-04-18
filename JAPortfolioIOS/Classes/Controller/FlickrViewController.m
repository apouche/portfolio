//
//  FlickrViewController.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "FlickrViewController.h"

// Managers
#import "JARemoteManager.h"

@interface FlickrViewController ()

@end

@implementation FlickrViewController

#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    
    [self retrieveBusinessObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark FlickrViewController
#pragma mark -

- (void)retrieveBusinessObjects
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[JARemoteManager sharedManager] retrieveFlickrMostInteresting:1
                                                        completion:^(id object, NSError *error) {
                                                            
                                                        }];
    
}


#pragma mark -
#pragma mark TableView
#pragma mark -

@end
