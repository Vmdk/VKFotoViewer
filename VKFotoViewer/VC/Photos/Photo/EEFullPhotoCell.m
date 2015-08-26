//
//  EEFullPhotoCell.m
//  VKFotoViewer
//
//  Created by robert on 8/26/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EEFullPhotoCell.h"

@implementation EEFullPhotoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setPhoto:(NSString *)photo {
    _Image.image = [self createPhoto:photo];
}

- (UIImage *)createPhoto:(NSString*)photo {
    NSData *data =[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:photo]];
    return [UIImage imageWithData:data];
}

@end
