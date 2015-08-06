//
//  EERequest.h
//  VKFotoViewer
//
//  Created by robert on 7/12/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EERequest : NSObject

+ (NSArray*)friendRequest;
+ (NSString*)getNameForId:(NSString*)curId;
+ (void)getIdInfo:(NSString*)curId
            successBlock:(void (^)(NSDictionary*))createInfo;
+ (void)getCity:(NSString*)cId
            andFillInfo:(void (^)(NSString*))fillInfo;
+ (void)getAlbums:(NSString*)uId
     successBlock:(void (^)(NSArray*))createAlbums;
@end
