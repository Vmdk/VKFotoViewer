//
//  EELogic.m
//  VKFotoViewer
//
//  Created by robert on 7/21/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EELogic.h"

@implementation EELogic


+ (NSString *)getAge:(NSString *)bDate {
    NSDateFormatter *formerWithYear = [[NSDateFormatter alloc] init];
    [formerWithYear setDateFormat:@"dd.MM.YYYY"];
    
    NSDate *date = [formerWithYear dateFromString:bDate];
    if (date) {
        int age = [self countAge:date];
        NSString *res = [NSString stringWithFormat:@"%i years old, ", age ];
        return res;
    }
    else {
        return @"";
    }
}

+ (int)countAge:(NSDate*)bdate {
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:bdate
                                       toDate:[NSDate date]
                                       options:0];
    return ageComponents.year;
}

@end
