//
//  FlickrViewCell.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "FlickrViewCell.h"


@implementation FlickrViewCell
@synthesize previews = _previews;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        self.contentView.backgroundColor= [UIColor blackColor];;
    }
    return self;
}

- (void)dealloc
{
    self.previews = nil;
    
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadWithObject:(NSArray *)photos fromList:(NSArray*)listPhotos
{
    JALogW(@"This method will do nothing and should be overwritten in %@", self.class);
}
@end
