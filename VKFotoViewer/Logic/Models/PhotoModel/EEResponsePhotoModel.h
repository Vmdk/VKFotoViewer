//
//  EERequestPhotoModel.h
//  VKFotoViewer
//
//  Created by robert on 8/12/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EEResponsePhotoModel : NSObject

- (instancetype)initWithData:(NSDictionary*)data;
+ (NSArray*)createModelArray:(NSArray*)photos;
- (UIImage*)getSmallPhoto;
- (UIImage*)getLargestPhoto;

@end
