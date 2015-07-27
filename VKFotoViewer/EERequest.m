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

+ (NSData *)getIdInfo:(NSString *)curId {
    NSString* stringReq = [NSString stringWithFormat:@"https://api.vk.com/method/users.get?user_id=%@&fields=sex,bdate,city,photo_200", curId];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringReq]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:60.0];
    return [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
}

+ (NSString*)getCity:(NSString*)cId {
    if (![[NSString stringWithFormat:@"%@", cId ]  isEqual: @"0"]) {
        NSString* strReq = [NSString stringWithFormat:@"https://api.vk.com/method/database.getCitiesById?city_ids=%@", cId];
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strReq]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
        NSData *response = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];
        NSDictionary* lData = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:nil];
        NSDictionary* ll = lData[@"response"][0];
        NSString *res = ll[@"name"];
        return res;
    }
    else {
        return @"";
    }
}

+ (NSString*)AFgetCity:(NSString*)cId {
    if (![[NSString stringWithFormat:@"%@", cId ]  isEqual: @"0"]) {
        NSString* const strReq = [NSString stringWithFormat:@"https://api.vk.com/method/database.getCitiesById?city_ids=%@", cId];
        NSURLRequest* req = [NSURLRequest requestWithURL:[NSURL URLWithString:strReq]];
        
        AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:req];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *result = (NSDictionary*)responseObject;
            //cheking...
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Some Error"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
            return nil;
        }];
        [operation start];
        return @"";
    }
    else {
        return @"";
    }
}

@end
