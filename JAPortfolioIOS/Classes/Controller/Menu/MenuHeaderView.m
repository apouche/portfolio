//
//  MenuHeaderView.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/27/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "MenuHeaderView.h"

@implementation MenuHeaderView
@synthesize titleLabel = _titleLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		self.backgroundColor = JARGB(29,29,29);
		
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, JAViewW(self), JAViewH(self))];
		_titleLabel.font				= [UIFont fontWithName:@"Verdana-Bold" size:14];
		_titleLabel.textColor			= JARGB(204,206,208);
		_titleLabel.backgroundColor	= [UIColor clearColor];
		
		[self addSubview:_titleLabel];
		
		[_titleLabel release];

    }
    return self;
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
