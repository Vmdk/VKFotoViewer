//
//  EEFriendInfoVC.h
//  VKFotoViewer
//
//  Created by robert on 7/18/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EEFriendInfoVC : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UIImageView *_photo;
    IBOutlet UILabel *_name;
    IBOutlet UILabel *_shortInfo;
    IBOutlet UITableView *_tableWithUserInfo;
    IBOutlet UIActivityIndicatorView* _spinner;
}
@property(nonatomic, weak) NSString* friendId;

@end
