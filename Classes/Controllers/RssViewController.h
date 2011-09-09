//
//  RootViewController.h
//  iPortal
//
//  Created by Cleave Pokotea on 11/05/09.
//  Copyright Tumunu 2009 - 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchXML.h"
#import "RegexKitLite.h"


@interface RssViewController : UITableViewController {
    
    //UITableView * rssTable;
    UITableViewCell * oddCell;
    NSString * cellString;
}

//@property (nonatomic, retain) IBOutlet UITableView * rssTable;
@property (nonatomic, retain) IBOutlet UITableViewCell * oddCell;

@property (nonatomic, retain) NSString * cellString;


@end
