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

// Views
#import "FlickrViewCell.h"

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
        self.photos = [NSMutableArray array];
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
    
    [self.view addSubview:_tableview];
    
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

- (void)retrieveBusinessObjects
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[JARemoteManager sharedManager] retrieveFlickrMostInteresting:1
                                                        completion:^(id object, NSError *error)
     {
         JALogD(@"Object Built : %@", object);
         FlickrPhotoList* list = object;
         
         [_photos addObjectsFromArray:list.photos];
         
         [_tableview reloadData];
     }];
    
}

- (NSArray *)photosAtIndexPath:(NSIndexPath *)path
{
    if (path.section != kFlickrSectionPhotos)
        return nil;
    
    // 3 photos per row
    NSInteger floor = (CGFloat)path.row/3.f;
    if (floor < _photos.count)
    {
        return [NSArray arrayWithObjects:
                _photos[floor*3],
                floor*3+1 < _photos.count ? _photos[floor*3+1] : nil,
                floor*3+2 < _photos.count ? _photos[floor*3+2] : nil,
                nil];
    }
    
    // error occured
    return nil;
    
    
}

#pragma mark -
#pragma mark TableView
#pragma mark -

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FlickrViewCell* cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:kFlickrCellIdentifer];
    
    if (cell == nil)
    {
        cell = [[[FlickrViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:kFlickrCellIdentifer] autorelease];
    }
    
    [cell loadWithPhotos:[self photosAtIndexPath:indexPath]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == kFlickrSectionPhotos ? 90 : 20;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section== kFlickrSectionPhotos)
        return _photos.count/3;
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return     kFlickrSectionCount;
}

@end
