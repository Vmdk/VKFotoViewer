//
//  EERequest.m
//  VKFotoViewer
//
//  Created by robert on 7/12/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EERequest.h"
#import "AFNetworking.h"
#import "EEInfo.h"

@implementation EERequest


+ (NSArray*)friendRequest {
    NSString *us_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessUserId"];
    //NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccesssToken"];
    //NSString *stringReq = [NSString stringWithFormat:@"https://api.vk.com/method/friends.get?user_id=%@&order=hints&access_token=%@", us_id, accessToken];
    NSString *stringReq = [NSString stringWithFormat:@"https://api.vk.com/method/friends.get?user_id=%@&order=hints", us_id];
    //get data from string(request)
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringReq]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:60.0];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *friendsId = [NSJSONSerialization JSONObjectWithData:responseData options:NSNotFound error:nil];
    NSArray *idArray = friendsId[@"response"];
    return idArray;
}

+ (NSString*)getNameForId:(NSString*)curId {
    NSString *stringReq = [NSString stringWithFormat:@"https://api.vk.com/method/users.get?user_id=%@", curId];
    //get data from string(request)
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringReq]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:60.0];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary* userInfo = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
    NSString *name = userInfo[@"response"][0][@"first_name"];
    NSString *lastName = userInfo[@"response"][0][@"last_name"];
    NSString *res = [NSString stringWithFormat:@"%@ %@",name,lastName];
    return res;
}

+ (void)getIdInfo:(NSString *)curId successBlock:(void (^)(NSDictionary *))createInfo {
    NSString* fields = [NSString stringWithFormat:@"sex,bdate,city,country,photo_200,contacts,music,movies,universities,schools,status,counters,connections"];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessToken"];
    NSString* stringReq = [NSString stringWithFormat:@"https://api.vk.com/method/users.get?user_id=%@&fields=%@&access_token=%@", curId, fields, accessToken];
    NSURL *URL = [NSURL URLWithString:stringReq];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        createInfo(responseObject[@"response"][0]);
    }];
    [dataTask resume];
}

+ (void)getCity:(NSString*)cId andFillInfo:(void (^)(NSString*))fillInfo {
    NSString __block *res = @"";
    if (cId && ![[NSString stringWithFormat:@"%@", cId ]  isEqual: @"0"]) {
        NSString* const strReq = [NSString stringWithFormat:@"https://api.vk.com/method/database.getCitiesById?city_ids=%@", cId];
        NSURL *URL = [NSURL URLWithString:strReq];
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
        [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
        // Send Request
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            res = responseObject[@"response"][0][@"name"];
            fillInfo(res);
        }];
        [dataTask resume];
    }
    else {
        fillInfo(@"");
    }
}

@end
