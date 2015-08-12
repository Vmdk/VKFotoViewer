//
//  EEPhoto.m
//  VKFotoViewer
//
//  Created by robert on 8/12/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EEPhoto.h"

@implementation EEPhoto {
    NSDictionary* _photoInfo;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setPhoto:(UIImage *)photo {
    _photoView.image = photo;
}

@end
