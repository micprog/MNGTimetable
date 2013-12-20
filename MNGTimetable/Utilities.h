//
//  Utilities.h
//  MNGTimetable
//
//  Created by Áedán Christie on 05/12/13.
//  Copyright (c) 2013 Áedán Christie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface Utilities : NSObject {
    FMDatabase *database;
}


+ (void) updateDataFiles;
+ (NSArray *) fetchBaseTimetable:(NSString*) name;
+ (void)saveImage: (UIImage*)image;
+ (FMDatabase *) setupDatabase;
+ (NSMutableArray *) listClasses: (FMDatabase*) database;
+ (NSMutableArray *) listOptionalSubjects: (FMDatabase*) database;
+ (NSString *)getFilePath: (NSString *) fileName;
+ (NSMutableArray *) rewriteArray: (NSMutableArray*) badArray;
@end
