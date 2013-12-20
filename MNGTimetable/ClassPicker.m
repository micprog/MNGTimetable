//
//  ClassPicker.m
//  MNGTimetable
//
//  Created by Michael Rogenmoser on 12/5/13.
//  Copyright (c) 2013 Michael Rogenmoser. All rights reserved.
//

#import "Utilities.h"
#import "ClassPicker.h"

@interface ClassPicker ()

@end

@implementation ClassPicker


- (NSString *)docsDir {
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    arrayClass = [[NSMutableArray alloc]init];
    
    FMDatabase *db = [Utilities setupDatabase];
    arrayClass = [Utilities listClasses:db];
    [_ClassPicker selectRow:1 inComponent:0 animated:NO];
    
    self.title = @"Class";
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
    
    if (component == CLASS) {
        return [arrayClass objectAtIndexedSubscript:row];
    }
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    //place where a the value from the picker view can be used.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    //self.arrayClass.delegate = nil;
    //self.ClassPicker.delegate = nil;
    [_ClassPicker release];
    
    //[arrayClass release];
    
    [super dealloc];
}
@end
