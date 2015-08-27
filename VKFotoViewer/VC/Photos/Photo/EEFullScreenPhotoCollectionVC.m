//
//  EEFullScreenPhotoView.m
//  VKFotoViewer
//
//  Created by robert on 8/26/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EEFullScreenPhotoCollectionVC.h"
#import "EEFullPhotoCell.h"

#define FULL_SCREEN_CELL_IDENTIFIER @"FullPhotoCell"

@implementation EEFullScreenPhotoCollectionVC {
    NSArray* _photosURLArray;
    BOOL* _isZoomed;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_spinner startAnimating];
    [_collection registerNib:[UINib nibWithNibName:NSStringFromClass([EEFullPhotoCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:FULL_SCREEN_CELL_IDENTIFIER];
    _isZoomed = FALSE;
    
    _photosURLArray = [_delegate EEFullScreenPhotoViewDelegateGivePhotos];
    [_collection reloadData];
    [_spinner stopAnimating];
    
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSInteger lIndex = [_delegate EEFullScreenPhotoViewDelegateGivePhotoIndex];
    NSIndexPath* lPath = [NSIndexPath indexPathForItem:lIndex inSection:0];
    [_collection scrollToItemAtIndexPath:lPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

#pragma mark - Table realization
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photosURLArray.count;
}

- (EEFullPhotoCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EEFullPhotoCell *cell = (EEFullPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:FULL_SCREEN_CELL_IDENTIFIER forIndexPath:indexPath];
    [cell setPhoto:_photosURLArray[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog([NSString stringWithFormat:@"%f %f",_Collection.frame.size.width, _Collection.frame.size.height ]);
    return _collection.frame.size;
}

#pragma mark - inits
- (instancetype)initWithPhotos:(NSArray*)arr {
    self = [self init];
    _photosURLArray = arr;
    return self;
}
@end
