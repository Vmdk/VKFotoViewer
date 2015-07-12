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
@end
