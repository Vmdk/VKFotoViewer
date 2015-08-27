//
//  EERequestPhotoModel.m
//  VKFotoViewer
//
//  Created by robert on 8/12/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EEResponsePhotoModel.h"

@implementation EEResponsePhotoModel 

- (instancetype)initWithData:(NSDictionary *)data {
    self = [self init];
    _75 = data[@"photo_75"];
    _130 = data[@"photo_130"];
    _604 = data[@"photo_604"];
    _807 = data[@"photo_807"];
    _1280 = data[@"photo_1280"];
    _2560 = data[@"photo_2560"];
    _description = data[@"text"];
    return self;
}

+ (NSArray *)createModelArray:(NSArray *)photos {
    NSMutableArray *res = [NSMutableArray array];
    for (NSDictionary* obj in photos) {
        [res addObject:[[EEResponsePhotoModel alloc] initWithData:obj]];
    }
    
    return res;
}

- (UIImage *)getSmallPhoto {
    return [self createPhoto:_130];
}
-(NSString *)getLargestURL {
    NSString* temp = _75;
    if (_130) {
        temp = _130;
    }
    if (_604) {
        temp = _604;
    }if (_807) {
        temp = _807;
    }
    if (_1280) {
        temp = _1280;
    }
    if (_2560) {
        temp = _2560;
    }
    return temp;
}

- (UIImage *)getLargestPhoto {
    NSString* temp = _75;
    if (_130) {
        temp = _130;
    }
    if (_604) {
        temp = _604;
    }if (_807) {
        temp = _807;
    }
    if (_1280) {
        temp = _1280;
    }
    if (_2560) {
        temp = _2560;
    }
    return [self createPhoto:temp];
}

- (UIImage *)createPhoto:(NSString*)photoURL {
    NSData *data =[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:photoURL]];
    return [UIImage imageWithData:data];
}
@end
