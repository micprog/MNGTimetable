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
    
    [self createTableViewData];
    
    int calendarHeight = 360; //calendarHight still has to be imported from MNGCalendarView
    
    int leftoverSpace = 100; //has to be calculated with calendarHight and screen height
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, calendarHeight, 320, leftoverSpace)];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
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

- (void)createTableViewData {
    
    NSArray *newArray = [[NSArray alloc]initWithObjects:@"hi", @"hi2", nil];
    tableViewArray = newArray;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [tableViewArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [tableViewArray objectAtIndex:indexPath.row];
    //cell is created here, here we have to change the cell style for the timetable
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
