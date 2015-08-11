//
//  EEAlbumCell.m
//  VKFotoViewer
//
//  Created by robert on 8/6/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EEAlbumCell.h"

@implementation EEAlbumCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)prepareInfo:(NSDictionary *)lInfo {
    NSData *data =[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:lInfo[@"thumb_src"]]];
    _albumPhoto.image = [UIImage imageWithData:data];
    _albumName.text =lInfo[@"title"];
    _NumOfPhotos.text = [NSString stringWithFormat:@"%@",lInfo[@"size"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
