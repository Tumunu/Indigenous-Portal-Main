//
//  RootViewController.m
//  iPortal
//
//  Created by Cleave Pokotea on 11/05/09.
//  Copyright Tumunu 2009 - 2011. All rights reserved.
//

#import "RssViewController.h"
#import "iPortalAppDelegate.h"
#import "StringHelper.h"


#define kTextViewFontSize		12.0

@implementation RssViewController

//@synthesize rssTable;
@synthesize oddCell;
@synthesize cellString;


- (void)viewDidLoad {
    LOG_CML;
    
    [super viewDidLoad];   
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	NSInteger i = [[iPortalAppDelegate get].englishNews count];
	LOG(@"Number of rows: %d",i);
    
	return i;
}

// Manages the height of the cell.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {  

    NSDictionary * s = [[iPortalAppDelegate get].englishNews objectAtIndex:indexPath.row];
    cellString = [[s objectForKey:@"description"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // Default label size
    CGSize labelSize = CGSizeMake(273.0, 10.0);

    if ([cellString length] > 0) {
        LOG(@"String length is greater than zero");
        
        // Scaled label size
        labelSize = [cellString sizeWithFont: [UIFont systemFontOfSize: 12.0] constrainedToSize: CGSizeMake(273.0, 1000.0) lineBreakMode: UILineBreakModeTailTruncation];
    }
    LOG(@"label height: %2f | %2f", labelSize.height, indexPath.row);
    
    return 52.0 + labelSize.height;
} 

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	LOG(@"cellForRowAtIndexPath %@", indexPath);

	UITableViewCell *customCell = (UITableViewCell*) [self.tableView dequeueReusableCellWithIdentifier:@"RssTableCell"];
    
	if (customCell == nil) {
        
		[[NSBundle mainBundle] loadNibNamed:@"RssTableCell" owner:self options:NULL];
		customCell = oddCell;
		LOG(@"customizing %@", customCell);
	} else {
        
		LOG(@"reusing %@", customCell.reuseIdentifier);
	}
   
    LOG(@"Set cell content");
	UILabel* titleLabel = (UILabel*) [customCell viewWithTag:1];
	UILabel* authorLabel = (UILabel*) [customCell viewWithTag:2];
	UILabel* dateLabel = (UILabel*) [customCell viewWithTag:3];
    UILabel* contentLabel = (UILabel*) [customCell viewWithTag:4];
    
    int i = indexPath.row;
    NSDictionary * s = [[iPortalAppDelegate get].englishNews objectAtIndex:i];
    //LOG(@"NS Dict: %@", s);
    
	titleLabel.text = [s objectForKey:@"title"];
    authorLabel.text = [s objectForKey:@"author"];
    dateLabel.text = [s objectForKey:@"pubDate"];
    contentLabel.text = [s objectForKey:@"description"];
	
    return customCell;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // Navigation logic may go here -- for example, create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController animated:YES];
	// [anotherViewController release];
    NSDictionary * s = [[iPortalAppDelegate get].englishNews objectAtIndex:indexPath.row];
    LOG(@"Cell %@ selected open link %@", indexPath, [s objectForKey:@"link"]);
}


- (void)dealloc {
    
    if(cellString) {
        
        [cellString release];
    }
    
    [super dealloc];
}


@end

