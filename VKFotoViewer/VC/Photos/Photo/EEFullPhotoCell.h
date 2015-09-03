//
//  EEFullPhotoCell.h
//  VKFotoViewer
//
//  Created by robert on 8/26/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface EEFullPhotoCell : UICollectionViewCell <UIScrollViewDelegate>{
    IBOutlet UIImageView* _image;
    IBOutlet UIScrollView* _scrollView;
    IBOutlet UIButton* _likeButton;
    IBOutlet UIButton* _shareButton;
    IBOutlet UIButton* _commentButton;
    IBOutlet UIView* _buttonView;
}

- (void) setPhoto:(NSString*)photoURL;
@end