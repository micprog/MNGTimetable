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
        
    int calendarHeight = 360;//calendarHight still has to be imported from MNGCalendarView
    
    int leftoverSpace = 100;//has to be calculated with calendarHight and screen height
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, calendarHeight, 320, leftoverSpace)];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    LessonStartPath = [[self docsDir]stringByAppendingPathComponent:@"LessonStart.plist"];
    if (![[NSFileManager defaultManager]fileExistsAtPath:LessonStartPath]) {
        [[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"LessonStart" ofType:@"plist"] toPath:LessonStartPath error:nil];
    }
    LessonEndPath = [[self docsDir]stringByAppendingString:@"LessonEndPath.plist"];
    if (![[NSFileManager defaultManager]fileExistsAtPath:LessonEndPath]) {
        [[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"LessonEnd" ofType:@"plist"] toPath:LessonEndPath error:nil];
    }
    
    LessonStartArray = [NSArray arrayWithContentsOfFile:LessonStartPath];
    LessonStartArrayUsable = [[NSMutableArray alloc]init];
    
    for (int i=0; i<[LessonStartArray count]; i++) {
        [LessonStartArrayUsable addObject:[LessonStartArray objectAtIndex:i]];
    }
    
    LessonEndArray = [NSArray arrayWithContentsOfFile:LessonEndPath];
    
    LessonEndArrayUsable = [[NSMutableArray alloc]init];
    
    for (int i=0; i<[LessonEndArray count]; i++) {
        [LessonEndArrayUsable addObject:[LessonEndArray objectAtIndex:i]];
    }
    
    
    
}

- (NSString *)docsDir {
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
}

-(void)calendarView:(MNGCalendarView *)calendarView heightAboutToChange:(float)newHeight {
    [tableView setFrameY:newHeight+20];
    float bottom = [[self view] frameHeight] - newHeight - 42;
    [tableView setFrameHeight:bottom];
    
}
-(void)calendarView:(MNGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    if (month==[[NSDate date] month]) {
        NSArray *timetable = [Utilities fetchBaseTimetable:@"3a"];
        [calendarView setTimetable:timetable];
    }
}

-(void)calendarView:(MNGCalendarView *)calendarView dateSelected:(NSDate *)date {
    NSLog(@"Selected date = %@",date);
    [tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (void)createTableViewData {
    
    NSArray *newArray = [[NSArray alloc]initWithObjects:@"hi", @"hi2", nil];
    tableViewArray = newArray;
    
}*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [LessonStartArrayUsable count];
    
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
    
    cell.LessonStart.text = [LessonStartArrayUsable objectAtIndex:indexPath.row];
    cell.LessonEnd.text = [LessonEndArrayUsable objectAtIndex:indexPath.row];
    //cell is created here, here we have to change the cell style for the timetable
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
