//
//  FlickrPreviewViewCell.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/19/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "FlickrPreviewViewCell.h"
#import "FlickrPhotoPreview.h"

@implementation FlickrPreviewViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        CGSize sPreview = CGSizeMake(90, 90);
        NSMutableArray* previews = [NSMutableArray arrayWithCapacity:3];
        
        for (NSInteger i = 0; i < 3; ++i)
        {
            FlickrPhotoPreview* preview = [[FlickrPhotoPreview alloc] initWithFrame:CGRectZero];
            preview.frame = CGRectMake(i*(sPreview.width+12)+12,
                                       5,
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

- (void)loadWithObject:(NSArray*)photos
{
    for (FlickrPhotoPreview* preview in self.previews)
    {
        NSInteger idx = [self.previews indexOfObject:preview];
        
        [preview loadWithFlickrPhoto:idx < photos.count ? photos[idx] : nil];
    }
}

@end
