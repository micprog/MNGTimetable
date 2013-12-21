//
//  OptionalSubject.h
//  MNGTimetable
//
//  Created by Michael Rogenmoser on 12/19/13.
//  Copyright (c) 2013 Michael Rogenmoser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionalSubject : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    
    NSString *navigationBarTitle;
    UITableView *tableView;
    NSMutableArray *OptionalSubjectArray;
    
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSString *navigationBarTitle;

@end
