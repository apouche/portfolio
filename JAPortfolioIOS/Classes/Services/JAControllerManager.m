//
//  JAControllerManager.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/21/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "JAControllerManager.h"

// Controllers
#import "MasterNavigationController.h"
#import "FlickrViewerViewController.h"
#import "FlickrViewController.h"

@implementation JAControllerManager
@synthesize masterController = _masterController;

+ (JAControllerManager *)sharedManager
{
    static id singleton = nil;
    if (singleton == nil)
        singleton = [[JAControllerManager alloc] init];
    
    return singleton;
}

- (void)pushFlickInterestingControllerFrom:(UIViewController *)controller
{
	FlickrViewController* c = [[FlickrViewController alloc] initWithNibName:nil bundle:nil];
	
	[_masterController pushController:c from:nil completion:nil];
	
	[c release];
}
- (void)pushFlickrViewerFrom:(UIViewController*)controller  photo:(FlickrPhoto *)photo fromList:(NSArray *)photos
{
	UICollectionViewLayout* layout = [FlickrViewerViewController layout];
	
	FlickrViewerViewController* next = [[FlickrViewerViewController alloc] initWithCollectionViewLayout:layout];
	next.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	next.photos			= photos;
	next.currentPhoto	= photo;
	
	[_masterController pushController:next completion:nil];
	
	// retained by the master controller hierarchy
	[next release];
}

- (void)dismissController:(UIViewController *)controller
{	
	[_masterController popCurrentControllerWithCompletion:nil];
}


@end
