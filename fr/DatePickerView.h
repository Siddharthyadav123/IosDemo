//
//  DatePickerView.h
//  FleetRight
//
//  Created by test on 01/09/16.
//  Copyright © 2016 syslogic. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EquipmentRentRequByRenterViewController;

@interface DatePickerView : UIView
{
    NSString *strFromDate ;
    NSDate *selectedNSDate;
     NSString *strToDate ;
}
@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) EquipmentRentRequByRenterViewController* equipmentRentRequByRenterViewController;
@property (strong, nonatomic) IBOutlet UIButton *doneButton;
- (IBAction)doneButtonClicked:(id)sender;
-(void)initialize;
@end
