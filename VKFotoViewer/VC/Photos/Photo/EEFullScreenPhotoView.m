//
//  EEFullScreenPhotoView.m
//  VKFotoViewer
//
//  Created by robert on 8/26/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EEFullScreenPhotoView.h"
#import "EEFullPhotoCell.h"

@implementation EEFullScreenPhotoView {
    NSArray* _photos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_Collection registerNib:[UINib nibWithNibName:NSStringFromClass([EEFullPhotoCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"FullPhotoCell"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    [_Collection setPagingEnabled:YES];
    [_Collection setCollectionViewLayout:flowLayout];
}



#pragma mark - Table realization
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"FullPhotoCell";
    EEFullPhotoCell *cell = (EEFullPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell setPhoto:_photos[indexPath.row]];
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _Collection.frame.size;
}

#pragma mark - inits
- (instancetype)initWithPhotos:(NSArray*)arr {
    self = [self init];
    _photos = arr;
    return self;
}
@end
