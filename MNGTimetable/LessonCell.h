//
//  LessonCell.h
//  MNGTimetable
//
//  Created by Michael Rogenmoser on 12/19/13.
//  Copyright (c) 2013 Michael Rogenmoser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LessonCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *LessonStart;
@property (nonatomic, strong) IBOutlet UILabel *LessonEnd;
@property (nonatomic, strong) IBOutlet UILabel *LessonName;
@property (nonatomic, strong) IBOutlet UILabel *LessonTeacher;
@property (nonatomic, strong) IBOutlet UILabel *LessonRoom;

@end
