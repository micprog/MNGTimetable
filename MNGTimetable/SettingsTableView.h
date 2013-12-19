//
//  SettingsTableView.h
//  MNGTimetable
//
//  Created by Michael Rogenmoser on 12/19/13.
//  Copyright (c) 2013 Michael Rogenmoser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsTableView : UITableViewController {
    
    UITableView *tableView;
    NSMutableArray *SettingsArray;
    
}

@property (nonatomic, retain) UITableView *tableView;

@end
