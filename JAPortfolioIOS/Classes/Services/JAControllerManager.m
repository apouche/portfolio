//
//  JAControllerManager.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/21/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "JAControllerManager.h"

// Controllers
#import "FlickrViewerViewController.h"

@implementation JAControllerManager

+ (JAControllerManager *)sharedManager
{
    static id singleton = nil;
    if (singleton == nil)
        singleton = [[JAControllerManager alloc] init];
    
    return singleton;
}

- (void)pushFlickrViewerFrom:(UIViewController*)controller  photo:(FlickrPhoto *)photo fromList:(NSArray *)photos
{
	UIViewController* next = [[FlickrViewerViewController alloc] initWithNibName:nil bundle:nil];
	next.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	
	[controller presentViewController:next animated:NO completion:nil];
	
//	[UIView animateWithDuration:0.3f animations:^{
//		controller.view.frame = CGRectMake(0, 0, , <#CGFloat height#>)
//	}];
	
	[next release];
}



@end
