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


@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    calendar.delegate = self;
    [self.view addSubview:calendar];
    
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    if (month==[[NSDate date] month]) {
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:6],[NSNumber numberWithInt:23], nil];
        NSArray *timetable = [Utilities fetchBaseTimetable:@"3a"];
        [calendarView markDates:dates];
        [calendarView setTimetable:timetable];
    }
    
    
    //load data for month
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    NSLog(@"Selected date = %@",date);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
