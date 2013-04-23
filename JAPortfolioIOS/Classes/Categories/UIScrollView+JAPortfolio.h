//
//  UIScrollView+JAPortfolio.h
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/23/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum e_scroll_direction
{
	UIScrollViewDirectionUnknown = 0,
	UIScrollViewDirectionLeft,
	UIScrollViewDirectionRight,
	UIScrollViewDirectionTop,
	UIScrollViewDirectionBottom,
}UIScrollViewDirection;

@interface UIScrollView (JAPortfolio)

@end
