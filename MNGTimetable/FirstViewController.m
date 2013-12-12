//
//  FirstViewController.m
//  MNGTimetable
//
//  Created by Michael Rogenmoser on 12/5/13.
//  Copyright (c) 2013 Michael Rogenmoser. All rights reserved.
//

#import "FirstViewController.h"
#import "VRGCalendarView.h"
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
    
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    calendar.delegate = self;
    [self.view addSubview:calendar];
    
    [self createTableViewData];
    
    int calendarHight = 360;//calendarHight still has to be imported from VRGCalendarView
    
    int leftoverSpace = 100;//has to be calculated with calendarHight and screen hight
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, calendarHight, 320, leftoverSpace)];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    if (month==[[NSDate date] month]) {
        NSArray *timetable = [Utilities fetchBaseTimetable:@"3a"];
        [calendarView setTimetable:timetable];
    }
    
    
    //load data for month
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
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
