//
//  JASample.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/27/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "JASample.h"
#import "JAControllerManager.h"

@implementation JASample
@synthesize title		= _title;
@synthesize selector	= _selector;

+ (id)sampleCollectionView
{
	JASample* sample	= [[JASample alloc] init];
	sample.title		= @"Collection Views";
	sample.selector		= @selector(pushFlickInterestingControllerFrom:);
	
	return sample;
}

- (void)dealloc
{
	self.title = nil;
	
	[super dealloc];
}

@end
