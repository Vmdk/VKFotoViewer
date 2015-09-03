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
#import "EEUserForListModel.h"

@implementation EEProcessor

+ (void)friendId:(NSString *)fId fillInfo:(void (^)(EEResponseUserModel*))fillOrder {
    [EERequest getIdInfo:fId successBlock:^(NSDictionary* lInfo){
        EEResponseUserModel* user = [[EEResponseUserModel alloc] initWithData:lInfo];
        fillOrder(user);
        }];
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

+ (void)createFriendsList:(void (^)(NSArray *))fillList {
    [EERequest getFriendsArrayWithNamesAndCreateModels:^(NSArray *arrayOfFriends) {
        NSMutableArray *arrayOfModels = [NSMutableArray arrayWithCapacity:arrayOfFriends.count];
        for (int i = 0; i < arrayOfFriends.count; i++) {
            arrayOfModels[i] = [[EEUserForListModel alloc] initWithValue:arrayOfFriends[i]];
        }
        fillList(arrayOfModels);
    }];
}
@end
