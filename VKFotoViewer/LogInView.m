//
//  LogInView.m
//  VKFotoViewer
//
//  Created by robert on 7/3/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "LogInView.h"
@implementation LogInView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *lURL = [NSURL URLWithString:@"https://oauth.vk.com/authorize?client_id=4982333&scope=6&redirect_uri=https://oauth.vk.com/blank.html&display=mobile&v=5.34&response_type=token"];
    [_myBrowser loadRequest:[NSURLRequest requestWithURL:lURL]];
}



@end

//https://oauth.vk.com/authorize?client_id=4982333&scope=6&redirect_uri=https://oauth.vk.com/blank.html&display=mobile&v=5.34&response_type=token