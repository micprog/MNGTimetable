//
//  MNGCalendarView.h
//
//  Created by Michael Rogenmoser, Áedán Christie
//  Copyright (c) 2013 Michael Rogenmoser, Áedán Christie. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIColor+expanded.h"

#define kMNGCalendarViewTopBarHeight 60
#define kMNGCalendarViewWidth 320

#define kMNGCalendarViewDayWidth 46
#define kMNGCalendarViewDayHeight 46
@class MNGCalendarView;
@protocol MNGCalendarViewDelegate;
@interface MNGCalendarView : UIView {
    id <MNGCalendarViewDelegate> delegate;
    
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

@property (nonatomic, retain) id <MNGCalendarViewDelegate> delegate;
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

@protocol MNGCalendarViewDelegate <NSObject>
-(void)calendarView:(MNGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated;
-(void)calendarView:(MNGCalendarView *)calendarView dateSelected:(NSDate *)date;
//-(void)calendarView:(MNGCalendarView *)calendarView heightChanged:(float)height;
-(void)calendarView:(MNGCalendarView *)calendarView heightAboutToChange:(float)height;
@end
