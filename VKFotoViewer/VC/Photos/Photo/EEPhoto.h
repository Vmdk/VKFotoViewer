//
//  EEPhoto.h
//  VKFotoViewer
//
//  Created by robert on 8/12/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EEPhoto : UIViewController {
    IBOutlet UIImageView *_photoView;
}

- (void)setPhoto:(UIImage*)photo;
@end
