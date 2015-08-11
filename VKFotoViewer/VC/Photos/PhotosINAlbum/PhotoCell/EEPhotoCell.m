//
//  EEPhotoCell.m
//  VKFotoViewer
//
//  Created by robert on 8/11/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EEPhotoCell.h"

@implementation EEPhotoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setPhoto:(NSDictionary *)photo {
    NSData *data =[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:photo[@"src_small"]]];
    _Image.image = [UIImage imageWithData:data];
}

@end
