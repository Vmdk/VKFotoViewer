//
//  EEUserForListModel.m
//  VKFotoViewer
//
//  Created by robert on 9/3/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EEUserForListModel.h"

@implementation EEUserForListModel

- (instancetype)initWithValue:(NSDictionary *)info {
    self = [super init];
    _firstName = info[@"first_name"];
    _secondName = info[@"last_name"];
    _userId = info[@"uid"];
    return self;
}

- (NSString *)getName {
    return [NSString stringWithFormat:@"%@ %@", _firstName,_secondName];
}
- (NSString *)getId {
    return _userId;
}
@end
