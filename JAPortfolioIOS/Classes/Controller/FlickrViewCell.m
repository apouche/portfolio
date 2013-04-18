//
//  FlickrViewCell.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "FlickrViewCell.h"
#import "FlickrPhotoPreview.h"

@implementation FlickrViewCell
@synthesize previews = _previews;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGSize sPreview = CGSizeMake(90, 90);
        NSMutableArray* previews = [NSMutableArray arrayWithCapacity:3];
        
        for (NSInteger i = 0; i < 3; ++i)
        {
            FlickrPhotoPreview* preview = [[FlickrPhotoPreview alloc] initWithFrame:CGRectZero];
            preview.frame = CGRectMake(i*(sPreview.width+12)+12,
                                       0,
                                       sPreview.width,
                                       sPreview.height);
            
            [self addSubview:preview];
            [previews addObject:preview];
            
            [preview release];
        }
        
        self.previews = [NSArray arrayWithArray:previews];
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

- (void)loadWithPhotos:(NSArray *)photos
{
   for (FlickrPhotoPreview* preview in _previews)
   {
       NSInteger idx = [_previews indexOfObject:preview];
       
       [preview loadWithFlickrPhoto:idx < photos.count ? photos[idx] : nil];
   }
}
@end
