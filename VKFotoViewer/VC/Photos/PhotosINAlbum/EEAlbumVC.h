//
//  EEAlbum.h
//  VKFotoViewer
//
//  Created by robert on 8/11/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface EEAlbumVC : UIViewController  <UICollectionViewDataSource, UICollectionViewDelegate> {
    IBOutlet UICollectionView *_collection;
    IBOutlet UIActivityIndicatorView* _spinner;
}

- (void)createAlbum:(NSDictionary*)album;

@end
