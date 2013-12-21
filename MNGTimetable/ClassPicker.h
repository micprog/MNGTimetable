//
//  ClassPicker.h
//  MNGTimetable
//
//  Created by Michael Rogenmoser on 12/5/13.
//  Copyright (c) 2013 Michael Rogenmoser. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CLASS 0

@interface ClassPicker : UIViewController <NSStreamDelegate,UIPickerViewDataSource,UIPickerViewDelegate> {
    
    NSString *navigationBarTitle;
    NSMutableArray *arrayClass;
    NSString *ClassesPath;
    
}

@property (strong, nonatomic) IBOutlet UIPickerView *ClassPicker;
@property (nonatomic, retain) NSString *navigationBarTitle;

    
    


@end
