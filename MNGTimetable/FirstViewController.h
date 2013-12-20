//
//  FirstViewController.h
//  MNGTimetable
//
//  Created by Michael Rogenmoser on 12/5/13.
//  Copyright (c) 2013 Michael Rogenmoser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNGCalendarView.h"
#import "FMDatabase/FMDatabase.h"


@interface FirstViewController : UIViewController <MNGCalendarViewDelegate, UITableViewDelegate, UITableViewDataSource> {
    
    UITableView *tableView;
    NSArray *tableViewArray;
    
    NSMutableArray *LessonNameArray;
    NSMutableArray *LessonTeacherArray;
    NSMutableArray *LessonRoomArray;
    NSMutableArray *LessonStartArray;
    NSMutableArray *LessonEndArray;
        
    NSString *LessonStartPath;
    NSString *LessonEndPath;

    
}

@property (nonatomic, retain) UITableView *tableView;

@end
