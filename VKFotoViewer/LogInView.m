//
//  LogInView.m
//  VKFotoViewer
//
//  Created by robert on 7/3/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "LogInView.h"
#import "ViewController.h"
#import "EERequest.h"

// TODO == 3
@implementation LogInView

- (void)viewDidLoad
{
    [super viewDidLoad];
    //cleaning catche. Should be removed smwhr TODO
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURL *lURL = [NSURL URLWithString:@"https://oauth.vk.com/authorize?client_id=4982333&scope=6&redirect_uri=https://oauth.vk.com/blank.html&display=mobile&v=5.34&response_type=token"];
    [_myBrowser loadRequest:[NSURLRequest requestWithURL:lURL]];
}


-(void)webViewDidFinishLoad:(UIWebView *)webView {
    // get token
    if ([_myBrowser.request.URL.absoluteString rangeOfString:@"access_token"].location != NSNotFound) {
        NSString *accessToken = [self stringBetweenString:@"access_token="
                                                andString:@"&"
                                              innerString:[[[webView request] URL] absoluteString]];
        
        // get user's id
        NSArray *userAr = [[[[webView request] URL] absoluteString] componentsSeparatedByString:@"&user_id="];
        NSString *user_id = [userAr lastObject];
        //save user's id
        if(user_id){
            [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:@"VKAccessUserId"];
        }
        //save token
        if(accessToken){
            [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"VKAccessToken"];
            //save token's time
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"VKAccessTokenDate"];
            //later add syncro, cheking token's time etc..   TODO
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        [(ViewController*)_baseDelegate afterAuth];
    } else if ([_myBrowser.request.URL.absoluteString rangeOfString:@"error"].location != NSNotFound) {
        //add smthng if wrong auth  TODO
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//returns us string between "start" and "end"
- (NSString*)stringBetweenString:(NSString*)start
                       andString:(NSString*)end
                     innerString:(NSString*)str
{
    NSScanner* scanner = [NSScanner scannerWithString:str];
    [scanner setCharactersToBeSkipped:nil];
    [scanner scanUpToString:start intoString:NULL];
    if ([scanner scanString:start intoString:NULL]) {
        NSString* result = nil;
        if ([scanner scanUpToString:end intoString:&result]) {
            return result;
        }
    }
    return nil;
}


@end

//https://oauth.vk.com/authorize?client_id=4982333&scope=6&redirect_uri=https://oauth.vk.com/blank.html&display=mobile&v=5.34&response_type=token