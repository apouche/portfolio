//
//  JAControllerManager.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/21/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "JAControllerManager.h"

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
	[controller presentViewController:nil animated:YES completion:nil];
}



@end
