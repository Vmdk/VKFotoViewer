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

@property(nonatomic, retain) NSString* name;
@property(nonatomic, retain) NSDictionary* tableInfo;
@property(nonatomic, retain) UIImage* userPhoto;

- (instancetype)initWithData:(NSDictionary*)lData;
@end
