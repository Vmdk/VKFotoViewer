//
//  EEFullScreenPhotoView.h
//  VKFotoViewer
//
//  Created by robert on 8/26/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol EEFullScreenPhotoCollectionVCDelegate <NSObject>
- (NSArray*)EEFullScreenPhotoViewDelegateGivePhotos;
- (NSInteger)EEFullScreenPhotoViewDelegateGivePhotoIndex;
@end

@interface EEFullScreenPhotoCollectionVC : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    IBOutlet UICollectionView *_collection;
    IBOutlet UIActivityIndicatorView* _spinner;
}

@property(nonatomic, weak) id<EEFullScreenPhotoCollectionVCDelegate> delegate;

- (instancetype)initWithPhotos:(NSArray*)arr;
@end
