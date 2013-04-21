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
	UICollectionViewLayout* layout = [FlickrViewerViewController layout];
	
	FlickrViewerViewController* next = [[FlickrViewerViewController alloc] initWithCollectionViewLayout:layout];
	next.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	next.photos			= photos;
	next.currentPhoto	= photo;
	
	[controller presentViewController:next animated:YES completion:nil];
	
	next.view.frame = CGRectMake(JAViewW(controller.view), 20, JAViewW(next.view), JAViewH(next.view));
	[UIView animateWithDuration:0.3f animations:^{
		next.view.frame = CGRectMake(0, 20, JAViewW(next.view), JAViewH(next.view));
	}];
	
	[next release];
}



@end
