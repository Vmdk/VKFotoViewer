//
//  EEPhotoScrollView.h
//  VKFotoViewer
//
//  Created by robert on 8/26/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EEPhotoScrollView : UIViewController <UIScrollViewDelegate> {
    IBOutlet UIScrollView* _photoScroller;
}

@property (nonatomic, retain) UIImage* photo;
- (instancetype)initPhoto:(UIImage*)img;
@end
