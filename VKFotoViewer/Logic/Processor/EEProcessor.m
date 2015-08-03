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
    [EERequest getIdInfo:fId successBlock:^(NSDictionary* lInfo){
        //have user's info. Now just take what we need
        NSMutableDictionary* result = [NSMutableDictionary dictionary];
        [result setValue:[NSString stringWithFormat:@"%@ %@", lInfo[@"first_name"], lInfo[@"last_name"]] forKey:@"name"];
        [result setValue:lInfo[@"photo_200"] forKey:@"photo"];
        
        
        
        fillOrder(result);
    }];
}

@end
