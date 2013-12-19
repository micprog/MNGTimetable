//
//  OptionalSubjectCell.h
//  MNGTimetable
//
//  Created by Michael Rogenmoser on 12/19/13.
//  Copyright (c) 2013 Michael Rogenmoser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionalSubjectCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UISwitch *OptionalSubjectSwitch;
@property (retain, nonatomic) IBOutlet UILabel *SubjectLabel;

- (IBAction)OptionalSubjectSwitch:(id)sender;

@end
