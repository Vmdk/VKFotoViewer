//
//  FriendsListVC.h
//  VKFotoViewer
//
//  Created by robert on 7/7/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsListVC : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *_friendsList;
}

- (void)setFriends:(NSArray*)arr;
- (void)setTempArr;
@end
