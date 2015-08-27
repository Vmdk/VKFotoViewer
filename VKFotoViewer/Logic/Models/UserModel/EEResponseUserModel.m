//
//  EEResponseUserModel.m
//  VKFotoViewer
//
//  Created by robert on 8/19/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EEResponseUserModel.h"

@implementation EEResponseUserModel

- (instancetype)initWithData:(NSDictionary *)lData {
    self = [super init];
    _userPhoto = [self getPhoto:lData[@"photo_200"]];
    _name = [NSString stringWithFormat:@"%@ %@", lData[@"first_name"], lData[@"last_name"]];
    _tableInfo = [self createTableData:lData];
    
    return self;
}

- (UIImage*)getPhoto:(NSString*)photoURL {
    NSData* data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:photoURL]];
    return [UIImage imageWithData:data];
}


- (NSDictionary*)createTableData:(NSDictionary*)lInfo {
    NSDictionary* res = [NSDictionary dictionaryWithObjectsAndKeys:
                                [self getContacts:lInfo], @"contacts",
                                [self getEducation:lInfo], @"education",
                                
                                nil];
    
    
    return res;
}
- (NSArray*)getContacts:(NSDictionary*)dict {
    NSMutableArray* res = [NSMutableArray array];
    if (dict[@"mobile_phone"] && ![dict[@"mobile_phone"] isEqual: @""]) {
        [res addObject:dict[@"mobile_phone"]];
    }
    if (dict[@"home_phone"] && ![dict[@"home_phone"] isEqual: @""]) {
        [res addObject:dict[@"home_phone"]];
    }
    //add more contacts
    
    
    if (res.count == 0) {
        [res addObject:@"no contacts"];
    }
    return res;
}
- (NSArray*)getEducation:(NSDictionary*)dict {
    NSMutableArray* res = [NSMutableArray array];
    NSArray* schools = dict[@"schools"];
    if (dict[@"schools"] && schools.count != 0) {
        for (int i=0; i<schools.count; i++) {
            if (schools[i][@"type_str"] && ![schools[i][@"type_str"] isEqual:@""]) {
                [res addObject:[NSString stringWithFormat:@"%@, %@",schools[i][@"name"], schools[i][@"type_str"] ] ];
            }
            else
                [res addObject:[NSString stringWithFormat:@"%@",schools[i][@"name"]] ];
        }
    }
    NSArray* universities = dict[@"universities"];
    if (dict[@"universities"] && universities.count != 0) {
        for (int i=0; i<universities.count; i++) {
            [res addObject:[NSString stringWithFormat:@"%@, %@, %@. %@",universities[i][@"name"], universities[i][@"faculty_name"], universities[i][@"chair_name"],  universities[i][@"education_status"] ] ];
        }
    }
    if (res.count == 0) {
        [res addObject:@"no education"];
    }
    return res;
}

//not used

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
    return (int)ageComponents.year;
}
@end
