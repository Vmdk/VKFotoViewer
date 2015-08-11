//
//  EEAlbum.m
//  VKFotoViewer
//
//  Created by robert on 8/11/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EEAlbum.h"
#import "EEProcessor.h"
#import "EEPhotoCell.h"

@implementation EEAlbum {
    NSArray* _Photos;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _Photos = [NSArray array];
    
    [_Collection registerClass:[EEPhotoCell class] forCellWithReuseIdentifier:@"PhotoCell"];
    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    [flowLayout setItemSize:CGSizeMake(200, 200)];
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//    [self->_Collection setCollectionViewLayout:flowLayout];
}

- (void)createAlbum:(NSString *)albId forUser:(NSString*)uId {
    [EEProcessor createAlbum:albId forUser:(NSString*)uId withPhotos:^(NSArray* lPhotos){
        _Photos = lPhotos;
        [_Collection reloadData];
    }];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _Photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"PhotoCell";    
    EEPhotoCell *cell = (EEPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell setPhoto:_Photos[indexPath.row]];
    
    return cell;
    
}

@end
