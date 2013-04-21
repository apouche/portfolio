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
