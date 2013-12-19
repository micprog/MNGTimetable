//
//  LessonCell.m
//  MNGTimetable
//
//  Created by Michael Rogenmoser on 12/19/13.
//  Copyright (c) 2013 Michael Rogenmoser. All rights reserved.
//

#import "LessonCell.h"

@implementation LessonCell
@synthesize LessonStart, LessonEnd, LessonName, LessonTeacher, LessonRoom;


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

@end
