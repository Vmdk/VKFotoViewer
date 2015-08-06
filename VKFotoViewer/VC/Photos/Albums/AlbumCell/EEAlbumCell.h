//
//  EEAlbumCell.h
//  VKFotoViewer
//
//  Created by robert on 8/6/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EEAlbumCell : UITableViewCell {
    IBOutlet UIImageView* _albumPhoto;
    IBOutlet UILabel* _albumName;
    IBOutlet UILabel* _NumOfPhotos;
}

-(void)prepareInfo:(NSDictionary*)lInfo;

@end
