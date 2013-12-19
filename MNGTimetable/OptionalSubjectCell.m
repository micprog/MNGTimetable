//
//  OptionalSubjectCell.m
//  MNGTimetable
//
//  Created by Michael Rogenmoser on 12/19/13.
//  Copyright (c) 2013 Michael Rogenmoser. All rights reserved.
//

#import "OptionalSubjectCell.h"

@implementation OptionalSubjectCell
@synthesize OptionalSubjectSwitch, SubjectLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [SubjectLabel release];
    [OptionalSubjectSwitch release];
    [super dealloc];
}
- (IBAction)OptionalSubjectSwitch:(id)sender {
}
@end
