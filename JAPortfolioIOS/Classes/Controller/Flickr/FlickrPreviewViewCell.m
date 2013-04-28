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
        CGSize sPreview = CGSizeMake(95, 95);
        NSMutableArray* previews = [NSMutableArray arrayWithCapacity:3];
        
        for (NSInteger i = 0; i < 3; ++i)
        {
            FlickrPhotoPreview* preview = [[FlickrPhotoPreview alloc] initWithFrame:CGRectZero];
            preview.frame = CGRectMake(i*(sPreview.width+8)+8,
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

- (void)loadWithObject:(NSArray*)photos fromList:(NSArray *)listPhotos
{
    for (FlickrPhotoPreview* preview in self.previews)
    {
		 
        NSInteger idx		= [self.previews indexOfObject:preview];
		FlickrPhoto* photo	= idx < photos.count ? photos[idx] : nil;
		NSInteger idxGlobal = [listPhotos indexOfObject:photo];
        
        [preview loadWithFlickrPhoto:photo index:idxGlobal != NSNotFound ? idxGlobal : 0];
    }
}

@end
