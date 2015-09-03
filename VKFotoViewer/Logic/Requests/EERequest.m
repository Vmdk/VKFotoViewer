//
//  EERequest.m
//  VKFotoViewer
//
//  Created by robert on 7/12/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EERequest.h"
#import "AFNetworking.h"

@implementation EERequest

+ (void)getFriendsArrayWithNamesAndCreateModels:(void (^)(NSArray *))createUserModels {
    NSString *us_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessUserId"];
    NSString* stringReq = [NSString stringWithFormat:@"https://api.vk.com/method/friends.get?user_id=%@&fields=city", us_id];
    NSURL *URL = [NSURL URLWithString:stringReq];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        createUserModels(responseObject[@"response"]);
    }];
    [dataTask resume];
}

+ (void)getAlbums:(NSString *)uId successBlock:(void (^)(NSArray *))createAlbums {
    NSString* stringReq = [NSString stringWithFormat:@"https://api.vk.com/method/photos.getAlbums?owner_id=%@&need_covers=1", uId];
    NSURL *URL = [NSURL URLWithString:stringReq];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        createAlbums(responseObject[@"response"]);
    }];
    [dataTask resume];
}

+ (void)getPhotos:(NSString *)albId forUser:(NSString*)uId successBlock:(void (^)(NSArray *))createPhotos {
    NSString* stringReq = [NSString stringWithFormat:@"https://api.vk.com/method/photos.get?owner_id=%@&album_id=%@&v=5.37",uId, albId];
    NSURL *URL = [NSURL URLWithString:stringReq];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        createPhotos(responseObject[@"response"][@"items"]);
    }];
    [dataTask resume];
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
