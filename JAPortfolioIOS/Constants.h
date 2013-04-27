//
//  JAAppDelegate.h
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JAViewX(v) (v).frame.origin.x
#define JAViewY(v) (v).frame.origin.y
#define JAViewW(v) (v).frame.size.width
#define JAViewH(v) (v).frame.size.height

#define JAScreenSize	 [[UIScreen mainScreen] bounds].size
#define JARealScreenSize CGSizeMake(JAScreenSize.width, JAScreenSize.height-20.f)

#define JAReleaseAndNil(o) { [(o) release]; o = nil; }

#define JARGB(r, g, b)		[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define JARGBA(r, g, b, a)	[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]