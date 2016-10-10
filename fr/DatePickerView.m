//
//  DatePickerView.m
//  FleetRight
//
//  Created by test on 01/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import "DatePickerView.h"
#import "EquipmentRentRequByRenterViewController.h"

@implementation DatePickerView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (id)init
{
    self = [super init];
    if (self) {
        //[self initialize];
    }
    return self;
}


-(void)initialize{
    //    _datePicker.backgroundColor = [UIColor whiteColor];
    
    //Default set today's date
    [_datePicker setMinimumDate: [NSDate date]];
    [_datePicker setValue:[UIColor blueColor] forKey:@"textColor"];
    [self setSelectedDate:_datePicker];
    [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
}

//******************DATE PICKER CODE ******************//
- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    [self setSelectedDate:datePicker];
}


-(void)setSelectedDate:(UIDatePicker *)datePicker{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    strFromDate = [dateFormatter stringFromDate:datePicker.date];
    selectedNSDate = [dateFormatter dateFromString:strFromDate];
    strToDate = [self calculateToDate];
}


- (IBAction)doneButtonClicked:(id)sender {
    if (strFromDate!=nil && strToDate!=nil) {
        [self.equipmentRentRequByRenterViewController datePickerChanged:strFromDate toDate:strToDate];
    }
    else{
        [self.equipmentRentRequByRenterViewController datePickerChanged:@"" toDate:@""];
    }
    
}

/*
 * Method to calculate toDate depend on set rent days.
 */
-(NSString*)calculateToDate{
    
    NSDateComponents *dateComponents = [NSDateComponents new];
    if([self.equipmentRentRequByRenterViewController.rentDaysLabel.text isEqualToString:@"Weekly"]){
        //Add 7 days in fromDate
        dateComponents.day = 6;
        //dateComponents.week = 1;
        
    }
    else if([self.equipmentRentRequByRenterViewController.rentDaysLabel.text isEqualToString:@"Monthly"]){
        //Add 1 month in fromDate
        //dateComponents.month = 1;
        
        NSCalendar *c = [NSCalendar currentCalendar];
        NSRange daysOfMonth = [c rangeOfUnit:NSDayCalendarUnit
                               inUnit:NSMonthCalendarUnit
                              forDate:selectedNSDate];
        int numberOfDaysInMonth = (int)daysOfMonth.length;
        
        //Subtract 1 day from month to balance difference between month.
        [dateComponents setDay:numberOfDaysInMonth-1];
        c = nil;
        
    }
    else{
        //Add 1 day in fromDate
        dateComponents.day = 0 ;
    }
    
    NSDate *toDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:selectedNSDate options:0];
    NSLog(@"Date = %@", toDate);
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString* formatedToDate  = [dateFormatter stringFromDate:toDate];
    
    toDate = nil;
    dateFormatter=nil;
    
    //Return string format of NSDate
    return formatedToDate;
    
    
}
@end
