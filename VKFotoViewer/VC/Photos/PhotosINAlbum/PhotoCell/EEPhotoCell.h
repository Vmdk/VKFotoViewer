//
//  EEPhotoCell.h
//  VKFotoViewer
//
//  Created by robert on 8/11/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EEPhotoCell : UICollectionViewCell {
    IBOutlet UIImageView* _Image;
}

- (void) setPhoto:(UIImage*)photo;
@end
