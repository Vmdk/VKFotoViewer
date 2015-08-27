//
//  EEResponseUserModel.h
//  VKFotoViewer
//
//  Created by robert on 8/19/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EEResponseUserModel : NSObject

@property(nonatomic, copy) NSString* name;
@property(nonatomic, copy) NSDictionary* tableInfo;
@property(nonatomic, strong) UIImage* userPhoto;

- (instancetype)initWithData:(NSDictionary*)lData;
@end
