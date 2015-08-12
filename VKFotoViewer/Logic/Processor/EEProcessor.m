//
//  EEProcessor.m
//  VKFotoViewer
//
//  Created by robert on 8/1/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EEProcessor.h"
#import "EERequest.h"
#import "EEResponsePhotoModel.h"

@implementation EEProcessor

+ (void)friendId:(NSString *)fId fillInfo:(void (^)(NSDictionary*))fillOrder {
    [EERequest getIdInfo:fId successBlock:^(NSDictionary* lInfo){
        //have user's info. Now just take what we need
        NSMutableDictionary* result = [NSMutableDictionary dictionary];
        [result setValue:[NSString stringWithFormat:@"%@ %@", lInfo[@"first_name"], lInfo[@"last_name"]] forKey:@"name"];
        [result setValue:lInfo[@"photo_200"] forKey:@"photo"];
        NSDictionary* tableInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [self getContacts:lInfo], @"contacts",
                                   [self getEducation:lInfo], @"education"
                                   
                                   ,nil];
        
        [result setValue:tableInfo forKey:@"table_info"];
        fillOrder(result);
    }];
}

+ (NSArray*)getContacts:(NSDictionary*)dict {
    NSMutableArray* res = [NSMutableArray array];
    if (dict[@"mobile_phone"] && ![dict[@"mobile_phone"] isEqual: @""]) {
        [res addObject:dict[@"mobile_phone"]];
    }
    if (dict[@"home_phone"] && ![dict[@"home_phone"] isEqual: @""]) {
        [res addObject:dict[@"home_phone"]];
    }
    //add more contacts
    
    
    if (res.count == 0) {
        [res addObject:@"no contacts"];
    }
    return res;
}
+ (NSArray*)getEducation:(NSDictionary*)dict {
    NSMutableArray* res = [NSMutableArray array];
    NSArray* schools = dict[@"schools"];
    if (dict[@"schools"] && schools.count != 0) {
        for (int i=0; i<schools.count; i++) {
            if (schools[i][@"type_str"] && ![schools[i][@"type_str"] isEqual:@""]) {
                [res addObject:[NSString stringWithFormat:@"%@, %@",schools[i][@"name"], schools[i][@"type_str"] ] ];
            }
            else
                [res addObject:[NSString stringWithFormat:@"%@",schools[i][@"name"]] ];
        }
    }
    NSArray* universities = dict[@"universities"];
    if (dict[@"universities"] && universities.count != 0) {
        for (int i=0; i<universities.count; i++) {
            [res addObject:[NSString stringWithFormat:@"%@, %@, %@. %@",universities[i][@"name"], universities[i][@"faculty_name"], universities[i][@"chair_name"],  universities[i][@"education_status"] ] ];
        }
    }    
    if (res.count == 0) {
        [res addObject:@"no education"];
    }
    return res;
}

+ (void)prepareAlbumsFor:(NSString *)uId successBlock:(void (^)(NSArray *))createAlbums {
    [EERequest getAlbums:uId successBlock:^(NSArray* albums){
        createAlbums(albums);        
    }];
}

+ (void)createAlbum:(NSString *)albId forUser:(NSString*)uId withPhotos:(void (^)(NSArray *))createPhotos {
    [EERequest getPhotos:albId forUser:uId successBlock:^(NSArray* photos){
        NSArray* modelArray = [EEResponsePhotoModel createModelArray:photos];
        createPhotos(modelArray);
    }];
    
}
@end
