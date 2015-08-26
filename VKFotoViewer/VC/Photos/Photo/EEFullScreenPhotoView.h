//
//  EEFullScreenPhotoView.h
//  VKFotoViewer
//
//  Created by robert on 8/26/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol BaseAlbum <NSObject>

- (NSArray*)givePhotos;

@end

@interface EEFullScreenPhotoView : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    IBOutlet UICollectionView *_Collection;
    IBOutlet UIActivityIndicatorView* _spinner;
}

@property(nonatomic, weak) id<BaseAlbum> baseAlbum;

- (instancetype)initWithPhotos:(NSArray*)arr;
@end
