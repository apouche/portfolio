//
//  MasterNavigationBar.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/27/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "MasterNavigationBar.h"

#import "JAAbstractViewController.h"

@implementation MasterNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		CAGradientLayer* gradient = [CAGradientLayer layer];
		gradient.frame = self.bounds;
		gradient.colors = [NSArray arrayWithObjects:(id)JARGB(30, 30, 30).CGColor,
													(id)JARGB(10, 10, 10).CGColor,
													 nil];
		
		
		UIView* vTop	= [[UIView alloc] initWithFrame:CGRectMake(0, 0, JAViewW(self), 1)];
		vTop.backgroundColor	= JARGB(50,49,50);

		[self.layer addSublayer:gradient];
		[self addSubview:vTop];
		
		[vTop release];
		
    }
    return self;
}

- (void)pushNavigationItemsFromController:(JAAbstractViewController *)controller
{
	[UIView animateWithDuration:0.7 animations:^{
		self.alpha = controller.isNavBarTransparent ? 0.0f : 1.f;
	}];
}

- (void)popNavigationItemsFromController:(JAAbstractViewController *)fromController
							toController:(JAAbstractViewController *)toController
{
	[UIView animateWithDuration:0.1 animations:^{
		self.alpha = toController.isNavBarTransparent ? 0.25f : 1.f;
	}];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
