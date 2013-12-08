//
//  Utilities.h
//  MNGTimetable
//
//  Created by Áedán Christie on 05/12/13.
//  Copyright (c) 2013 Áedán Christie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+ (void) updateDataFiles;
+ (NSArray *) fetchBaseTimetable:(NSString*) name ;
+ (void)saveImage: (UIImage*)image;
@end
