//
//  VRGCalendarView.h
//  Vurig
//
//  Created by in 't Veen Tjeerd on 5/8/12.
//  Copyright (c) 2012 Vurig Media. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIColor+expanded.h"

#define kVRGCalendarViewTopBarHeight 60
#define kVRGCalendarViewWidth 320

#define kVRGCalendarViewDayWidth 46
#define kVRGCalendarViewDayHeight 46
@class VRGCalendarView;
@protocol VRGCalendarViewDelegate;
@interface VRGCalendarView : UIView {
    id <VRGCalendarViewDelegate> delegate;
    
    NSDate *currentMonth;
    
    UILabel *labelCurrentMonth;
    
    BOOL isAnimating;
    BOOL prepAnimationPreviousMonth;
    BOOL prepAnimationNextMonth;
    
    UIImageView *animationView_A;
    UIImageView *animationView_B;
    
    NSArray *markedDates;
    NSArray *markedColors;
    
}

@property (nonatomic, retain) id <VRGCalendarViewDelegate> delegate;
@property (nonatomic, retain) NSDate *currentMonth;
@property (nonatomic, retain) UILabel *labelCurrentMonth;
@property (nonatomic, retain) UIImageView *animationView_A;
@property (nonatomic, retain) UIImageView *animationView_B;
@property (nonatomic, getter = calendarHeight) float calendarHeight;
@property (nonatomic, retain, getter = selectedDate) NSDate *selectedDate;
@property (nonatomic, retain) NSArray *timetable;
@property (nonatomic, assign) int lessonCount;
@property (nonatomic) CGPoint location;
@property (nonatomic, strong) NSTimer *timer;

-(void)selectDate:(int)date;
-(void)reset;

-(void)showNextMonth;
-(void)showPreviousMonth;

-(int)numRows;
-(void)updateSize;
-(UIImage *)drawCurrentState;

-(void)handleGesture:(UIGestureRecognizer *)gesture;
-(void)handleTimer:(NSTimer *)timer;

@end

@protocol VRGCalendarViewDelegate <NSObject>
-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated;
-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date;
//-(void)calendarView:(VRGCalendarView *)calendarView heightChanged:(float)height;
-(void)calendarView:(VRGCalendarView *)calendarView heightAboutToChange:(float)height;
@end
