//
//  Lesson.h
//  MNGTimetable
//
//  Created by Áedán Christie on 05/12/13.
//  Copyright (c) 2013 Michael Rogenmoser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSObject.h>

@interface Lesson : NSObject

@property (copy) NSString *Name;
@property (copy) NSString *Type;
@property (copy) NSString *StartTime; //Just a string
@property (copy) NSString *EndTime;   //Not a date
@property (copy) NSString *Teacher;
@property (copy) NSString *Room;

@end
