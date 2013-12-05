//
//  SecondViewController.m
//  MNGTimetable
//
//  Created by Michael Rogenmoser on 12/5/13.
//  Copyright (c) 2013 Michael Rogenmoser. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    /*
    arrayClass = [[NSMutableArray alloc]init];
    
    [arrayClass addObject:@"3a"];
    [arrayClass addObject:@"3b"];
    [arrayClass addObject:@"3c"];
    [arrayClass addObject:@"3d"];
    [arrayClass addObject:@"3e"];
    */
    //arrayClass = [[NSArray arrayWithContentsOfFile:
                                //[[NSBundle mainBundle] pathForResource:@"Classes" ofType:@"plist"]] retain];
    
    //NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"MNGTimetable/Data/Classes" ofType:@"plist"];
    arrayClass = [NSMutableArray arrayWithContentsOfFile:@"/Users/mikee/Dropbox/MNGTimetable/MNGTimetable/MNGTimetable/Classes.plist"];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == CLASS)
        return [arrayClass count];
    
    return 0;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == CLASS)
        return [arrayClass objectAtIndex:row];
    return 0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_ClassPicker release];
    [super dealloc];
}
@end
