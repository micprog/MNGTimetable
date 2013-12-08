//
//  Lesson.h
//  MNGTimetable
//
//  Created by Áedán Christie on 05/12/13.
//  Copyright (c) 2013 Áedán Christie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSObject.h>

@interface Lesson : NSObject

@property (copy) NSString *name;
@property (copy) NSString *type;
@property (copy) NSString *startTime; //Just a string
@property (copy) NSString *endTime;   //Not a date
@property (copy) NSString *teacher;
@property (copy) NSString *room;
@property (copy) NSString *subject;


- (id)init;
@end
