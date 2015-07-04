//
//  LogInView.m
//  VKFotoViewer
//
//  Created by robert on 7/3/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "LogInView.h"
#import <VKSdk/VKSdk.h>
@implementation LogInView






- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [VKSdk processOpenURL:url fromApplication:sourceApplication];
    return YES;
}

@end

//https://oauth.vk.com/authorize?client_id=APP_ID&scope=PERMISSIONS&redirect_uri=REDIRECT_URI&display=DISPLAY&v=API_VERSION&response_type=token
//NSUser..?..Default