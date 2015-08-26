//
//  EEFullPhotoCell.h
//  VKFotoViewer
//
//  Created by robert on 8/26/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface EEFullPhotoCell : UICollectionViewCell {
    IBOutlet UIImageView* _Image;
}

- (void) setPhoto:(NSString*)photo;
@end
