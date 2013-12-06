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


- (NSString *)docsDir {
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    arrayClass = [[[NSMutableArray alloc]init]retain];
    arrayClassUsable = [[NSMutableArray alloc]init];
    /*
    [arrayClass addObject:@"3a"];
    [arrayClass addObject:@"3b"];
    [arrayClass addObject:@"3c"];
    [arrayClass addObject:@"3d"];
    [arrayClass addObject:@"3e"];
    */
    //arrayClass = [[NSArray arrayWithContentsOfFile:
                                //[[NSBundle mainBundle] pathForResource:@"Classes" ofType:@"plist"]] retain];
    
    //NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"MNGTimetable/Data/Classes" ofType:@"plist"];
    
    ClassesPath = [[self docsDir]stringByAppendingPathComponent:@"Classes.plist"];
    
    if (![[NSFileManager defaultManager]fileExistsAtPath:ClassesPath]) {
        [[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"Classes" ofType:@"plist"] toPath:ClassesPath error:nil];
    }
    
    arrayClass = [NSArray arrayWithContentsOfFile:ClassesPath];
    
    NSLog(@"Count: %i", [arrayClass count]);
    
    for (int i=0; i<[arrayClass count]; i++) {
        [arrayClassUsable addObject:[arrayClass objectAtIndex:i]];
    }
    
    [_ClassPicker selectRow:1 inComponent:0 animated:NO];
    
    
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == CLASS)
        return [arrayClassUsable count];
    
    return 0;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == CLASS) {
        return [arrayClassUsable objectAtIndexedSubscript:row];
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
