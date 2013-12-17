//
//  Utilities.m
//  MNGTimetable
//
//  Created by Áedán Christie on 05/12/13.
//  Copyright (c) 2013 Áedán Christie. All rights reserved.
//

#import "Utilities.h"
#import "Lesson.h"

@implementation Utilities

+ (void) updateDataFiles {
    
}
+ (NSArray *) listTeachers {
    
    return nil;
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
    if (jsonParsingError == nil) {
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
    }
    return timetable;
}
+ (void)saveImage: (UIImage*)image
{
    if (image != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          @"test.png" ];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
    }
}
@end
