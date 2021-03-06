//
//  MNGCalendarView.m
//
//  Created by Michael Rogenmoser, Áedán Christie
//  Copyright (c) 2013 Michael Rogenmoser, Áedán Christie. All rights reserved.
//

#import "MNGCalendarView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSDate+convenience.h"
#import "NSMutableArray+convenience.h"
#import "UIView+convenience.h"
#import "FirstViewController.h"
#import "Utilities.h"
#import "Lesson.h"

@implementation MNGCalendarView
@synthesize currentMonth, delegate, labelCurrentMonth, animationView_A, animationView_B;
@synthesize calendarHeight, selectedDate, timetable, lessonCount;

#pragma mark - Select Date
- (void)selectDate:(int)date {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:self.currentMonth];
    [comps setDay:date];
    self.selectedDate = [gregorian dateFromComponents:comps];
    
    int selectedDateYear = [selectedDate year];
    int selectedDateMonth = [selectedDate month];
    int currentMonthYear = [currentMonth year];
    int currentMonthMonth = [currentMonth month];
    
    if (selectedDateYear < currentMonthYear) {
        [self showPreviousMonth];
    } else if (selectedDateYear > currentMonthYear) {
        [self showNextMonth];
    } else if (selectedDateMonth < currentMonthMonth) {
        [self showPreviousMonth];
    } else if (selectedDateMonth > currentMonthMonth) {
        [self showNextMonth];
    } else {
        [self setNeedsDisplay];
    }
    
    if ([delegate respondsToSelector:@selector(calendarView:dateSelected:)]) [delegate calendarView:self dateSelected:self.selectedDate];
}

#pragma mark - Set date to now
- (void)reset {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                           NSDayCalendarUnit) fromDate: [NSDate date]];
    self.currentMonth = [gregorian dateFromComponents:components]; //clean month
    
    [self updateSize];
    [self setNeedsDisplay];
    [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:NO];
}

#pragma mark - Next & Previous
- (void)showNextMonth {
    if (isAnimating) return;
    isAnimating=YES;
    prepAnimationNextMonth=YES;
    
    [self setNeedsDisplay];
    
    int lastBlock = [currentMonth firstWeekDayInMonth]+[currentMonth numDaysInMonth]-1;
    int numBlocks = [self numRows]*7;
    BOOL hasNextMonthDays = lastBlock<numBlocks;
    
    //Old month
    float oldSize = self.calendarHeight;
    UIImage *imageCurrentMonth = [self drawCurrentState];
    //New month
    self.currentMonth = [currentMonth offsetMonth:1];
    if ([delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight: animated:)]) [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:YES];
    prepAnimationNextMonth=NO;
    [self setNeedsDisplay];
    
    UIImage *imageNextMonth = [self drawCurrentState];
    float targetSize = fmaxf(oldSize, self.calendarHeight);
    UIView *animationHolder = [[UIView alloc] initWithFrame:CGRectMake(0, kMNGCalendarViewTopBarHeight, kMNGCalendarViewWidth, targetSize-kMNGCalendarViewTopBarHeight)];
    [animationHolder setClipsToBounds:YES];
    [self addSubview:animationHolder];
    [animationHolder release];
    
    //Animate
    self.animationView_A = [[UIImageView alloc] initWithImage:imageCurrentMonth];
    self.animationView_B = [[UIImageView alloc] initWithImage:imageNextMonth];
    [animationHolder addSubview:animationView_A];
    [animationHolder addSubview:animationView_B];
    if (hasNextMonthDays) {
        animationView_B.frameY = animationView_A.frameY + animationView_A.frameHeight - (kMNGCalendarViewDayHeight+3);
    } else {
        animationView_B.frameY = animationView_A.frameY + animationView_A.frameHeight -3;
    }
    
    //Animation
    __block MNGCalendarView *blockSafeSelf = self;
    [UIView animateWithDuration:.2
                     animations:^{
                         [self updateSize];
                         //blockSafeSelf.frameHeight = 100;
                         
                         if (hasNextMonthDays) {
                             animationView_A.frameY = -animationView_A.frameHeight + kMNGCalendarViewDayHeight+3;
                         } else {
                             animationView_A.frameY = -animationView_A.frameHeight + 3;
                         }
                         animationView_B.frameY = 0;
                     }
                     completion:^(BOOL finished) {
                         [animationView_A removeFromSuperview];
                         [animationView_B removeFromSuperview];
                         blockSafeSelf.animationView_A=nil;
                         blockSafeSelf.animationView_B=nil;
                         isAnimating=NO;
                         [animationHolder removeFromSuperview];
                     }
     ];
    
    
}
- (void)showPreviousMonth {
    if (isAnimating) return;
    isAnimating=YES;
    //Prepare current screen
    prepAnimationPreviousMonth = YES;
    [self setNeedsDisplay];
    BOOL hasPreviousDays = [currentMonth firstWeekDayInMonth]>1;
    float oldSize = self.calendarHeight;
    UIImage *imageCurrentMonth = [self drawCurrentState];
    
    //Prepare next screen
    self.currentMonth = [currentMonth offsetMonth:-1];
    if ([delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight:animated:)]) [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:YES];
    prepAnimationPreviousMonth=NO;
    [self setNeedsDisplay];
    UIImage *imagePreviousMonth = [self drawCurrentState];
    
    float targetSize = fmaxf(oldSize, self.calendarHeight);
    UIView *animationHolder = [[UIView alloc] initWithFrame:CGRectMake(0, kMNGCalendarViewTopBarHeight, kMNGCalendarViewWidth, targetSize-kMNGCalendarViewTopBarHeight)];
    
    [animationHolder setClipsToBounds:YES];
    [self addSubview:animationHolder];
    [animationHolder release];
    
    self.animationView_A = [[UIImageView alloc] initWithImage:imageCurrentMonth];
    self.animationView_B = [[UIImageView alloc] initWithImage:imagePreviousMonth];
    [animationHolder addSubview:animationView_A];
    [animationHolder addSubview:animationView_B];
    
    if (hasPreviousDays) {
        animationView_B.frameY = animationView_A.frameY - (animationView_B.frameHeight-kMNGCalendarViewDayHeight) + 3;
    } else {
        animationView_B.frameY = animationView_A.frameY - animationView_B.frameHeight + 3;
    }
    
    __block MNGCalendarView *blockSafeSelf = self;
    [UIView animateWithDuration:.2
                     animations:^{
                         [self updateSize];
                         
                         if (hasPreviousDays) {
                             animationView_A.frameY = animationView_B.frameHeight-(kMNGCalendarViewDayHeight+3); 
                             
                         } else {
                             animationView_A.frameY = animationView_B.frameHeight-3;
                         }
                         
                         animationView_B.frameY = 0;
                     }
                     completion:^(BOOL finished) {
                         [animationView_A removeFromSuperview];
                         [animationView_B removeFromSuperview];
                         blockSafeSelf.animationView_A=nil;
                         blockSafeSelf.animationView_B=nil;
                         isAnimating=NO;
                         [animationHolder removeFromSuperview];
                     }
     ];
}

#pragma mark - update size & row count
- (void)updateSize {
    [delegate calendarView:self heightAboutToChange:self.calendarHeight];
    self.frameHeight = self.calendarHeight;
    //[delegate calendarView:self heightChanged:self.calendarHeight];
    [self setNeedsDisplay];
}
- (float)calendarHeight {
    return kMNGCalendarViewTopBarHeight + [self numRows]*(kMNGCalendarViewDayHeight);
}
- (int)numRows {
    float lastBlock = [self.currentMonth numDaysInMonth]+([self.currentMonth firstWeekDayInMonth]-1);
    return ceilf(lastBlock/7);
}

#pragma mark - Touches
- (void)touchDay:(CGPoint)touchPoint {
    float xLocation = touchPoint.x;
    float yLocation = touchPoint.y-kMNGCalendarViewTopBarHeight;
    
    int column = floorf(xLocation/(kMNGCalendarViewDayWidth));
    int row = floorf(yLocation/(kMNGCalendarViewDayHeight));
    
    int blockNr = (column+1)+row*7;
    int firstWeekDay = [self.currentMonth firstWeekDayInMonth]-1; //-1 because weekdays begin at 1, not 0
    int date = blockNr-firstWeekDay;
    [self selectDate:date];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    self.selectedDate=nil;
    
    //Touch a specific day
    if (touchPoint.y > kMNGCalendarViewTopBarHeight) {
        [self touchDay:touchPoint];
        return;
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    CGRect rectArrowLeft = CGRectMake(0, 0, 50, 40);
    CGRect rectArrowRight = CGRectMake(self.frame.size.width-50, 0, 50, 40);
    
    //Touch a specific day
    if (touchPoint.y > kMNGCalendarViewTopBarHeight) {
        [self touchDay:touchPoint];
        return;
    }
    
    //Touch either arrows or month in middle
    if (CGRectContainsPoint(rectArrowLeft, touchPoint)) {
        [self showPreviousMonth];
    } else if (CGRectContainsPoint(rectArrowRight, touchPoint)) {
        [self showNextMonth];
    } else if (CGRectContainsPoint(self.labelCurrentMonth.frame, touchPoint)) {
        //Detect touch in current month
        int currentMonthIndex = [self.currentMonth month];
        int todayMonth = [[NSDate date] month];
        [self reset];
        if ((todayMonth!=currentMonthIndex) && [delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight:animated:)]) [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:NO];
    }
}
- (void)handleTimer:(NSTimer *)timer {
    [self tapAndHold:self.location];
}
- (void)handleGesture:(UIGestureRecognizer *)gesture {
    self.location = [gesture locationInView:self];
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
    }
    else if (gesture.state == UIGestureRecognizerStateCancelled ||
             gesture.state == UIGestureRecognizerStateFailed ||
             gesture.state == UIGestureRecognizerStateEnded)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    [self tapAndHold:self.location];
}
- (void)tapAndHold:(CGPoint)location {
    if (location.y > kMNGCalendarViewTopBarHeight) {
        
    }
    NSLog(@"tap and hold");
}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect {
    
    int firstWeekDay = [self.currentMonth firstWeekDayInMonth]-1; //-1 because weekdays begin at 1, not 0
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM yyyy"];
    labelCurrentMonth.text = [formatter stringFromDate:self.currentMonth];
    [labelCurrentMonth sizeToFit];
    labelCurrentMonth.frameX = roundf(self.frame.size.width/2 - labelCurrentMonth.frameWidth/2);
    labelCurrentMonth.frameY = 10;
    [formatter release];
    [currentMonth firstWeekDayInMonth];
    
    CGContextClearRect(UIGraphicsGetCurrentContext(),rect);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rectangle = CGRectMake(0,0,self.frame.size.width,kMNGCalendarViewTopBarHeight);
    CGContextAddRect(context, rectangle);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillPath(context);
    
    //Arrows
    int arrowSize = 12;
    int xmargin = 20;
    int ymargin = 18;
    
    //Arrow Left
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, xmargin+arrowSize/1.5, ymargin);
    CGContextAddLineToPoint(context,xmargin+arrowSize/1.5,ymargin+arrowSize);
    CGContextAddLineToPoint(context,xmargin,ymargin+arrowSize/2);
    CGContextAddLineToPoint(context,xmargin+arrowSize/1.5, ymargin);
    
    CGContextSetFillColorWithColor(context, 
                                   [UIColor blackColor].CGColor);
    CGContextFillPath(context);
    
    //Arrow right
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.frame.size.width-(xmargin+arrowSize/1.5), ymargin);
    CGContextAddLineToPoint(context,self.frame.size.width-xmargin,ymargin+arrowSize/2);
    CGContextAddLineToPoint(context,self.frame.size.width-(xmargin+arrowSize/1.5),ymargin+arrowSize);
    CGContextAddLineToPoint(context,self.frame.size.width-(xmargin+arrowSize/1.5), ymargin);
    
    CGContextSetFillColorWithColor(context, 
                                   [UIColor blackColor].CGColor);
    CGContextFillPath(context);
    
    //Weekdays
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=@"EEE";
    //always assume gregorian with monday first
    NSMutableArray *weekdays = [[NSMutableArray alloc] initWithArray:[dateFormatter shortWeekdaySymbols]];
    [weekdays moveObjectFromIndex:0 toIndex:6];
    
    CGContextSetFillColorWithColor(context, 
                                   [UIColor colorWithHexString:@"0x383838"].CGColor);
    for (int i =0; i<[weekdays count]; i++) {
        NSString *weekdayValue = (NSString *)[weekdays objectAtIndex:i];
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [weekdayValue drawInRect:CGRectMake(i*(kMNGCalendarViewDayWidth), 40, kMNGCalendarViewDayWidth, 20) withFont:font lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
    }
    
    int numRows = [self numRows];
    
    CGContextSetAllowsAntialiasing(context, NO);
    
    //Grid background
    float gridHeight = numRows*(kMNGCalendarViewDayHeight);
    CGRect rectangleGrid = CGRectMake(0,kMNGCalendarViewTopBarHeight,self.frame.size.width,gridHeight);
    CGContextAddRect(context, rectangleGrid);
    // Yeaaaah look here this is the color we wanna edit!!!!!!!!!!!
    CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0xFFFFFF"].CGColor);
    //CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0xff0000"].CGColor);
    CGContextFillPath(context);

    CGContextSetAllowsAntialiasing(context, YES);
    
    //Draw days
    CGContextSetFillColorWithColor(context, 
                                   [UIColor colorWithHexString:@"0x383838"].CGColor);
    
    
    //NSLog(@"currentMonth month = %i, first weekday in month = %i",[self.currentMonth month],[self.currentMonth firstWeekDayInMonth]);
    
    int numBlocks = numRows*7;
    NSDate *previousMonth = [self.currentMonth offsetMonth:-1];
    int currentMonthNumDays = [currentMonth numDaysInMonth];
    int prevMonthNumDays = [previousMonth numDaysInMonth];
    
    int selectedDateBlock = ([selectedDate day]-1)+firstWeekDay;
    
    //prepAnimationPreviousMonth nog wat mee doen
    
    //prev next month
    BOOL isSelectedDatePreviousMonth = prepAnimationPreviousMonth;
    BOOL isSelectedDateNextMonth = prepAnimationNextMonth;
    
    if (self.selectedDate!=nil) {
        isSelectedDatePreviousMonth = ([selectedDate year]==[currentMonth year] && [selectedDate month]<[currentMonth month]) || [selectedDate year] < [currentMonth year];
        
        if (!isSelectedDatePreviousMonth) {
            isSelectedDateNextMonth = ([selectedDate year]==[currentMonth year] && [selectedDate month]>[currentMonth month]) || [selectedDate year] > [currentMonth year];
        }
    }
    
    if (isSelectedDatePreviousMonth) {
        int lastPositionPreviousMonth = firstWeekDay-1;
        selectedDateBlock=lastPositionPreviousMonth-([selectedDate numDaysInMonth]-[selectedDate day]);
    } else if (isSelectedDateNextMonth) {
        selectedDateBlock = [currentMonth numDaysInMonth] + (firstWeekDay-1) + [selectedDate day];
    }
    
    
    NSDate *todayDate = [NSDate date];
    int todayBlock = -1;
    
//    NSLog(@"currentMonth month = %i day = %i, todaydate day = %i",[currentMonth month],[currentMonth day],[todayDate month]);
    
    if ([todayDate month] == [currentMonth month] && [todayDate year] == [currentMonth year]) {
        todayBlock = [todayDate day] + firstWeekDay - 1;
    }
    
    for (int i=0; i<numBlocks; i++) {
        int targetDate = i;
        int targetColumn = i%7;
        int targetRow = i/7;
        int targetBlock = firstWeekDay + (targetDate-1);
        int targetX = targetColumn * (kMNGCalendarViewDayWidth);
        int targetY = kMNGCalendarViewTopBarHeight + targetRow * (kMNGCalendarViewDayHeight);
        if (targetDate == 11) {
            
        }
        // BOOL isCurrentMonth = NO;
        if (i<firstWeekDay) { //previous month
            targetDate = (prevMonthNumDays-firstWeekDay)+(i+1);
            NSString *hex = (isSelectedDatePreviousMonth) ? @"0x383838" : @"aaaaaa";
            
            CGContextSetFillColorWithColor(context, 
                                           [UIColor colorWithHexString:hex].CGColor);
        } else if (i>=(firstWeekDay+currentMonthNumDays)) { //next month
            targetDate = (i+1) - (firstWeekDay+currentMonthNumDays);
            NSString *hex = (isSelectedDateNextMonth) ? @"0x383838" : @"aaaaaa";
            CGContextSetFillColorWithColor(context, 
                                           [UIColor colorWithHexString:hex].CGColor);
        } else { //current month
            // isCurrentMonth = YES;
            targetDate = (i-firstWeekDay)+1;
            NSString *hex = (isSelectedDatePreviousMonth || isSelectedDateNextMonth) ? @"0xaaaaaa" : @"0x383838";
            CGContextSetFillColorWithColor(context, 
                                           [UIColor colorWithHexString:hex].CGColor);
        }
        
        NSString *date = [NSString stringWithFormat:@"%i",targetDate];
        CGSize maximumSize = CGSizeMake(300, 9999);
        UIFont *myFont = [UIFont fontWithName:@"Helvetica" size:17];
        CGSize myStringSize = [date sizeWithFont:myFont
                                   constrainedToSize:maximumSize
                                   lineBreakMode:NSLineBreakByClipping];
        
        int stringLeft = targetX + (kMNGCalendarViewDayWidth)/2 - (myStringSize.width)/2;
        int stringTop = targetY + (kMNGCalendarViewDayHeight)/2 - (myStringSize.height)/2 - 5;
        
        //draw selected date
        if (selectedDate && i==selectedDateBlock) {
            
            CGRect rectangleGrid = CGRectMake(targetX,targetY,kMNGCalendarViewDayWidth,kMNGCalendarViewDayHeight);
           
            CGContextAddRect(context, rectangleGrid);
            CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0x006dbc"].CGColor);
            CGContextFillPath(context);
            
            CGContextSetFillColorWithColor(context, 
                                           [UIColor whiteColor].CGColor);
        } else if (todayBlock==i) {
            CGRect rectangleGrid = CGRectMake(targetX,targetY,kMNGCalendarViewDayWidth,kMNGCalendarViewDayHeight);
            CGContextAddRect(context, rectangleGrid);
            CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0x383838"].CGColor);
            CGContextFillPath(context);
            
            CGContextSetFillColorWithColor(context, 
                                           [UIColor whiteColor].CGColor);
        }
        
        [date drawInRect:CGRectMake(stringLeft, stringTop, myStringSize.width, myStringSize.height) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
    
        
        if (isSelectedDatePreviousMonth || isSelectedDateNextMonth) return;
        
        if (targetColumn < 5 && self.timetable) {
            lessonCount = [timetable[targetColumn] count];
            int firstRowCount = lessonCount;
            int secondRowCount = 0;
            if (lessonCount > 6) {
                firstRowCount = 6;
                secondRowCount = lessonCount - 6;
            }
            
            int blockWidth = 40;
            int dotWidth = 3;
            int dotPadding = 3;
            UIColor *dotColor = [UIColor colorWithHexString:@"0x383838"];
            
            int transFirstRow = (blockWidth-(dotWidth+dotPadding)*firstRowCount)/2;
            int transSecondRow = (blockWidth-(dotWidth+dotPadding)*secondRowCount)/2;
            
            for (int a = 0; a<firstRowCount; a++) {
                CGRect rect = CGRectMake(transFirstRow+targetX+23-blockWidth/2+a*(dotWidth+dotPadding)+dotPadding/2, targetY-1+32, dotWidth, dotWidth);
                CGContextAddRect(context, rect);
                
                if ((selectedDate && i==selectedDateBlock) || todayBlock==i) {
                    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
                    
                } else if (i<firstWeekDay || i>=(firstWeekDay+currentMonthNumDays)) {
                    NSString *hex = (isSelectedDatePreviousMonth) ? @"0x383838" : @"aaaaaa";
                    
                    CGContextSetFillColorWithColor(context,
                                                   [UIColor colorWithHexString:hex].CGColor);
                }  else if (targetDate == 5 && a == 2) {
                    NSString *hex = (isSelectedDatePreviousMonth) ? @"0x383838" : @"0xFF0000";
                    
                    CGContextSetFillColorWithColor(context,
                                                   [UIColor colorWithHexString:hex].CGColor);
                } else {
                    CGContextSetFillColorWithColor(context, dotColor.CGColor);
                }
                CGContextFillPath(context);
                
            }
            
            for (int n = 0; n<secondRowCount; n++) {
                CGRect rect = CGRectMake(transSecondRow+targetX+23-blockWidth/2+n*(dotWidth+dotPadding)+dotPadding/2, targetY+(dotWidth+dotPadding)-1+32, dotWidth, dotWidth);
                CGContextAddRect(context, rect);
                
                if ((selectedDate && i==selectedDateBlock) || todayBlock==i) {
                    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
                    
                } else if (i<firstWeekDay || i>=(firstWeekDay+currentMonthNumDays)) {
                    NSString *hex = (isSelectedDatePreviousMonth) ? @"0x383838" : @"aaaaaa";
                    
                    CGContextSetFillColorWithColor(context,
                                                   [UIColor colorWithHexString:hex].CGColor);
                } else {
                    CGContextSetFillColorWithColor(context, dotColor.CGColor);
                    
                }
                
                CGContextFillPath(context);
            }
        }
        
    
    }

}

#pragma mark - Draw image for animation
- (UIImage *)drawCurrentState {
    float targetHeight = kMNGCalendarViewTopBarHeight + [self numRows]*(kMNGCalendarViewDayHeight)+1;
    
    UIGraphicsBeginImageContext(CGSizeMake(kMNGCalendarViewWidth, targetHeight-kMNGCalendarViewTopBarHeight));
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(c, 0, -kMNGCalendarViewTopBarHeight);    // <-- shift everything up by 40px when drawing.
    [self.layer renderInContext:c];
    UIImage* viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

#pragma mark - Init
- (id)init {
    self = [super initWithFrame:CGRectMake(0, 0, kMNGCalendarViewWidth, 0)];
    if (self) {
        self.contentMode = UIViewContentModeTop;
        self.clipsToBounds=YES;
        
        isAnimating=NO;
        self.labelCurrentMonth = [[UILabel alloc] initWithFrame:CGRectMake(34, 0, kMNGCalendarViewWidth-68, 40)];
        [self addSubview:labelCurrentMonth];
        labelCurrentMonth.backgroundColor=[UIColor whiteColor];
        labelCurrentMonth.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
        labelCurrentMonth.textColor = [UIColor colorWithHexString:@"0x383838"];
        labelCurrentMonth.textAlignment = UITextAlignmentCenter;
        
        UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        gesture.minimumPressDuration = 1.25;
        gesture.allowableMovement = 600;
        [self addGestureRecognizer:gesture];
        
        [self performSelector:@selector(reset) withObject:nil afterDelay:0.1]; //so delegate can be set after init and still get called on init
        //        [self reset];
        
        [self setFrameY:20];
        
    }
    return self;
}
- (void)dealloc {
    
    self.delegate=nil;
    self.currentMonth=nil;
    self.labelCurrentMonth=nil;
    
    [super dealloc];
}
@end
