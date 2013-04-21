//
//  FlickrViewController.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/18/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "FlickrViewController.h"

// Managers
#import "JARemoteManager.h"
#import "JAControllerManager.h"

// Views
#import "FlickrViewCell.h"
#import "FlickrPreviewViewCell.h"
#import "FlickrPhotoPreview.h"

// Business Objects
#import "FlickrPhotoList.h"

#define kFlickrCellIdentifer @"kFlickrCellIdentifer"
@interface FlickrViewController ()

@end

@implementation FlickrViewController
@synthesize tableview   = _tableview;
@synthesize photos      = _photos;

#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // since the object is mutable, initalize it in the designated initializer
        self.photos     = [NSMutableArray array];
        _currentPage    = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableview.backgroundColor  = [UIColor clearColor];
    _tableview.delegate         = self;
    _tableview.dataSource       = self;
    _tableview.allowsSelection  = NO;
    _tableview.separatorStyle   = UITableViewCellSeparatorStyleNone;
    _tableview.indicatorStyle   = UIScrollViewIndicatorStyleWhite;
    
    [self.view addSubview:_tableview];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    // safe release at it's retained the view
    [_tableview release];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self retrieveBusinessObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.tableview  = nil;
    self.photos     = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark FlickrViewController
#pragma mark -

#pragma mark Retreiving Business Objects

- (void)retrieveBusinessObjects
{
    // don't do anything if we have completed all requests needed
    if (_currentPage <= 0)
        return;
    
    [[JARemoteManager sharedManager] retrieveFlickrMostInteresting:_currentPage
                                                        completion:^(id object, NSError *error)
     {
         JALogD(@"Object Built : %@", object);
         FlickrPhotoList* list = object;
         
         if (list.photos.count == 0)
             _currentPage = -1;
         
             [_photos addObjectsFromArray:list.photos];
         
         [_tableview reloadData];
     }];
    
}

#pragma mark Accessing Business Objects

- (NSArray *)photosAtIndexPath:(NSIndexPath *)path
{
    if (path.section != kFlickrSectionPhotos)
        return nil;
    
    // 3 photos per row
    NSInteger row = path.row;
    if (row*3 < _photos.count)
    {
        return [NSArray arrayWithObjects:
                row*3+0 < _photos.count ? _photos[row*3+0] : nil,
                row*3+1 < _photos.count ? _photos[row*3+1] : nil,
                row*3+2 < _photos.count ? _photos[row*3+2] : nil,
                nil];
    }
    
    // error occured
    return nil;
    
    
}

- (FlickrPhoto*)objectFromView:(UIView *)preview
{
	return preview.tag < _photos.count ? [_photos objectAtIndex:preview.tag] : nil;
}

#pragma mark -
#pragma mark TableView
#pragma mark -

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FlickrViewCell* cell = nil;
    
    if (indexPath.section == kFlickrSectionPhotos)
        cell = [tableView dequeueReusableCellWithIdentifier:kFlickrCellIdentifer];
    
    if (cell == nil)
    {
        // cell for photos
        if (indexPath.section == kFlickrSectionPhotos)
		{
			FlickrPreviewViewCell* previewCell = nil;
			
			// build cell
            previewCell = [[[FlickrPreviewViewCell alloc] initWithStyle:UITableViewCellStyleDefault
														reuseIdentifier:kFlickrCellIdentifer] autorelease];
			
			// update tap gesture
			for (FlickrPhotoPreview* preview in previewCell.previews)
				[preview.tapGesture addTarget:self action:@selector(onTapFlickrPreview:)];
			
			cell = previewCell;
		}
        
        // cell for last section (load more)
        else
        {
            cell = [[[FlickrViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:nil] autorelease];
			
			// add a basic loader
            UIActivityIndicatorView* loader = [[UIActivityIndicatorView alloc]
											   initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            
            loader.center = CGPointMake(cell.bounds.size.width*0.5f, 10);
            [loader startAnimating];
            [cell addSubview:loader];
            
        }
    }
    
    if (indexPath.section == kFlickrSectionPhotos)
        [cell loadWithObject:[self photosAtIndexPath:indexPath] fromList:_photos];
    
    else
    {
        ++_currentPage;
        [self retrieveBusinessObjects];

    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == kFlickrSectionPhotos ? 100 : _currentPage > 0 ? 30 : 0.f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section== kFlickrSectionPhotos)
        return _photos.count/3;
    
    else if (section == kFlickrSectionLoadMore)
        return _currentPage > 0 ? 1 : 0;
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return     kFlickrSectionCount;
}

#pragma mark -
#pragma mark Events
#pragma mark -

- (void)onTapFlickrPreview:(UITapGestureRecognizer*)tapGesture
{
	UIView* preview = tapGesture.view;
	
	FlickrPhoto* photo = [self objectFromView:preview];
	
	[[JAControllerManager sharedManager] pushFlickrViewerFrom:self photo:photo fromList:_photos];
			
	JALogD(@"Photo Tapped : %@", photo);
}

@end
