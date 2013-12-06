//
//  Utilities.m
//  MNGTimetable
//
//  Created by Áedán Christie on 05/12/13.
//  Copyright (c) 2013 Michael Rogenmoser. All rights reserved.
//

#import "Utilities.h"
#import "Lesson.h"

@implementation Utilities

+ (void) updateDataFiles {
    
}

+ (NSArray *) fetchBaseTimetable:(NSString*) name {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL
                                                          URLWithString:@"http://localhost:8000/3a.json"]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
    NSError *jsonParsingError = nil;
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:response
                                                              options:0 error:&jsonParsingError];
    NSArray *dataTable = data[@"table"];
    NSArray *timetable = [NSArray arrayWithObjects:[NSMutableArray array], [NSMutableArray array], [NSMutableArray array], [NSMutableArray array], [NSMutableArray array], nil];
    for (int weekDayCounter=0; weekDayCounter<5; weekDayCounter++) {
        for (int lessonCounter=0; lessonCounter<([dataTable[weekDayCounter] count]); lessonCounter++) {
            Lesson *lesson = [[Lesson alloc] init];
            NSDictionary *dataLesson = dataTable[weekDayCounter][lessonCounter];
            [lesson setTeacher: dataLesson[@"teacher"]];
            [lesson setRoom: dataLesson[@"room"]];
            [lesson setSubject: dataLesson[@"subject"]];
            
            [timetable[weekDayCounter] addObject:lesson];
        }
    }
    
    return timetable;
}

@end
