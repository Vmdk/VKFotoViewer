//
//  EEProcessor.m
//  VKFotoViewer
//
//  Created by robert on 8/1/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EEProcessor.h"
#import "EERequest.h"

@implementation EEProcessor

+ (void)friendId:(NSString *)fId fillInfo:(void (^)(NSDictionary*))fillOrder {
    NSData *response = [EERequest getIdInfo:fId];
    NSDictionary* lInfo = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:nil][@"response"][0];
    NSLog(@"avc");
}

@end
