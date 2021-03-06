//
//  EEProcessor.h
//  VKFotoViewer
//
//  Created by robert on 8/1/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EEResponseUserModel.h"

@interface EEProcessor : NSObject

+ (void)friendId:(NSString*)fId fillInfo:(void (^)(EEResponseUserModel*))fillOrder;
+ (void)prepareAlbumsFor:(NSString*)uId successBlock:(void (^)(NSArray*))createAlbums;
+ (void)createAlbum:(NSString*)albId forUser:(NSString*)uId withPhotos:(void (^)(NSArray*))createPhotos;
@end
