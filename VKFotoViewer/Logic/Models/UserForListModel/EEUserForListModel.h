//
//  EEUserForListModel.h
//  VKFotoViewer
//
//  Created by robert on 9/3/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EEUserForListModel : NSObject

@property(nonatomic, weak) NSString* firstName;
@property(nonatomic, weak) NSString* secondName;
@property(nonatomic, weak) NSString* userId;


- (NSString*)getName;
- (NSString*)getId;
- (instancetype)initWithValue:(NSDictionary *)info;

@end
