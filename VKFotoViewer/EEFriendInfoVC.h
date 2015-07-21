//
//  EEFriendInfoVC.h
//  VKFotoViewer
//
//  Created by robert on 7/18/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EEFriendInfoVC : UIViewController {
    IBOutlet UIImageView *_photo;
    IBOutlet UILabel *_name;
    IBOutlet UILabel *_shortInfo;
}

- (void) setId:(NSString*)ind;

@end
