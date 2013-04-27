//
//  MenuViewController.m
//  JAPortfolioIOS
//
//  Created by Johan Attali on 4/27/13.
//  Copyright (c) 2013 Johan Attali. All rights reserved.
//

#import "MenuViewController.h"

// Views
#import "MenuHeaderView.h"
#import "MenuViewCell.h"

// Business Objects
#import "JASample.h"

#define kMenuViewControllerCellIdentifier @"kMenuViewControllerCellIdentifier"

@implementation MenuViewController
@synthesize tableView = _tableView;

#pragma mark UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		_sections = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:[NSArray arrayWithObjects:
																					 [JASample sampleCollectionView], nil],
														   nil]
												  forKeys:[NSArray arrayWithObjects:@"UIKit", nil]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	_tableView.delegate			= self;
	_tableView.dataSource		= self;
	_tableView.backgroundColor	= kMenuViewCellBGColor;
	_tableView.separatorStyle	= UITableViewCellSeparatorStyleNone;
	[self.view addSubview:_tableView];
	
	[_tableView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
	JAReleaseAndNil(_sections);
	
	[super dealloc];
}

#pragma mark MenuViewController

- (id)objectAtIndexPath:(NSIndexPath *)path
{
	NSString* key		= path.section < _sections.allKeys.count ? [_sections allKeys][path.section] : nil;
	NSArray* objects	= _sections[key];
	
	return path.row < objects.count ? objects[path.row] : nil;
}

#pragma mark -
#pragma mark - UITableView
#pragma mark - 

#pragma mark DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return _sections.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	NSString* key		= [_sections allKeys][section];
	NSArray* objects	= _sections[key];
	
    return objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMenuViewControllerCellIdentifier];
    
    // Configure the cell...
	if (cell == nil)
		cell = [[[MenuViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMenuViewControllerCellIdentifier] autorelease];
	
	// retreive corresponding business object
	JASample* sample = [self objectAtIndexPath:indexPath];
	
	// build cell
	cell.titleLabel.text = sample.title;
    
    return cell;
}


#pragma mark Delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	MenuHeaderView* headerview = [[[MenuHeaderView alloc] initWithFrame:CGRectMake(0, 0, JAViewW(self.view), 31)] autorelease];
	
	headerview.titleLabel.text = [_sections allKeys][section];
	
	return headerview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 31;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

@end
