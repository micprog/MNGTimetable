//
//  Lesson.m
//  MNGTimetable
//
//  Created by Áedán Christie on 05/12/13.
//  Copyright (c) 2013 Áedán Christie. All rights reserved.
//

#import "Lesson.h"

@implementation Lesson

@synthesize name, endTime, room, startTime, teacher, type, subject, lesson;

- (id)init {
    if ( self = [super init] ) {
        subject = @"";
        teacher = @"";
        type = @"";
        name = @"";
        startTime = @"";
        endTime = @"";
        lesson = NULL;
        room = @"";
        
        return self;
    } else {
        return nil;
    }
}

@end
