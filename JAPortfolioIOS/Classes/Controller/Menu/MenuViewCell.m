//
//  MenuViewCell.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/27/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "MenuViewCell.h"

@implementation MenuViewCell
@synthesize titleLabel = _titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
        self.backgroundColor				= kMenuViewCellBGColor;
        self.backgroundView.backgroundColor = kMenuViewCellBGColor;
        self.contentView.backgroundColor	= kMenuViewCellBGColor;
		
		UIView* vTop	= [[UIView alloc] initWithFrame:CGRectMake(0, 0, JAViewW(self), 1)];
		UIView* vBottom = [[UIView alloc] initWithFrame:CGRectMake(0, JAViewH(self)-1, JAViewW(self), 1)];

		vTop.backgroundColor	= JARGB(50,49,50);
		vBottom.backgroundColor = JARGB(27,27,27);

		_titleLabel = [[UILabel alloc] initWithFrame:CGRectOffset(self.bounds, 30, 0)];
		_titleLabel.font			= [UIFont fontWithName:@"Verdana" size:15];
		_titleLabel.backgroundColor = [UIColor clearColor];
		_titleLabel.textColor		= JARGB(224,224,224);
		
		[self addSubview:vTop];
		[self addSubview:vBottom];

		[self addSubview:_titleLabel];

		[self addSubview:_titleLabel];
		
		[_titleLabel release];
		[vTop release];
		[vBottom release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
