//
//  EEAlbumsListVC.h
//  VKFotoViewer
//
//  Created by robert on 8/6/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EEAlbumsListVC : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *_albumsList;
    IBOutlet UIActivityIndicatorView* _spinner;
}

- (void)prepareInfoFor:(NSString*)uId;

@end
