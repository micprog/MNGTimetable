//
//  SecondViewController.h
//  MNGTimetable
//
//  Created by Michael Rogenmoser on 12/5/13.
//  Copyright (c) 2013 Michael Rogenmoser. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CLASS 0

@interface SecondViewController : UIViewController <NSStreamDelegate,UIPickerViewDataSource,UIPickerViewDelegate> {
    
    NSMutableArray *arrayClass;
    
    
}

@property (retain, nonatomic) IBOutlet UIPickerView *ClassPicker;
@end
