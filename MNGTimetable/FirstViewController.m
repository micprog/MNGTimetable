//
//  FirstViewController.m
//  MNGTimetable
//
//  Created by Michael Rogenmoser on 12/5/13.
//  Copyright (c) 2013 Michael Rogenmoser. All rights reserved.
//

#import "FirstViewController.h"
#import "MNGCalendarView.h"
#import "Utilities.h"
#import "UIView+convenience.h"
#import "NSDate+convenience.h"
#import "LessonCell.h"


@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    MNGCalendarView *calendar = [[MNGCalendarView alloc] init];
    calendar.delegate = self;
    [self.view addSubview:calendar];
    
    int calendarHeight = 360; //calendarHight still has to be imported from MNGCalendarView
    
    int leftoverSpace = 100; //has to be calculated with calendarHight and screen height
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, calendarHeight, 320, leftoverSpace)];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    LessonStartPath = [Utilities getFilePath:@"LessonStart.plist"];
    
    LessonEndPath = [Utilities getFilePath:@"LessonEnd.plist"];
    
    LessonStartArray = [NSArray arrayWithContentsOfFile:LessonStartPath];
    LessonStartArray = [Utilities rewriteArray:LessonStartArray];
    
    LessonEndArray = [NSArray arrayWithContentsOfFile:LessonEndPath];
    LessonEndArray = [Utilities rewriteArray:LessonEndArray];
}


-(void)calendarView:(MNGCalendarView *)calendarView heightAboutToChange:(float)newHeight {
    [tableView setFrameY:newHeight+20];
    float bottom = [[self view] frameHeight] - newHeight - 69;
    [tableView setFrameHeight:bottom];
    
}
-(void)calendarView:(MNGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    if (month==[[NSDate date] month]) {
        //NSArray *timetable = [Utilities fetchBaseTimetable:@"3a"];
        //[calendarView setTimetable:timetable];
    }
}

-(void)calendarView:(MNGCalendarView *)calendarView dateSelected:(NSDate *)date {
    NSLog(@"Selected date = %@",date);
    //change LessonNameArray, LessonRoomArray, LessonTeacherArray
    [tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [LessonStartArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"TimetableCell";
    
    LessonCell *cell = nil;
    
    cell = (LessonCell *) [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    
    if (!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LessonCell" owner:nil options:nil];
        
            for (id currentObject in topLevelObjects) {
                
                if ([currentObject isKindOfClass:[LessonCell class]]) {
                    cell = (LessonCell *)currentObject;
                    break;
                }
            }
    }
    
    cell.LessonStart.text = [LessonStartArray objectAtIndex:indexPath.row];
    cell.LessonEnd.text = [LessonEndArray objectAtIndex:indexPath.row];
    //cell.LessonName.text = [LessonNameArray objectAtIndex:indexPath.row];
    //cell.LessonRoom.text = [LessonRoomArray objectAtIndex:indexPath.row];
    //cell.LessonTeacher.text = [LessonTeacherArray objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
