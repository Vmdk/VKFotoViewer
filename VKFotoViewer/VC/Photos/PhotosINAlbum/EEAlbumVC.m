//
//  EEAlbum.m
//  VKFotoViewer
//
//  Created by robert on 8/11/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EEAlbumVC.h"
#import "EEProcessor.h"
#import "EEPhotoCell.h"
#import "EEResponsePhotoModel.h"
#import "EEFullScreenPhotoCollectionVC.h"

#define PHOTO_CELL_IDENTIFIER @"PhotoCell"

@interface EEAlbumVC () <EEFullScreenPhotoCollectionVCDelegate>{
    NSArray* _photoModelsArray;
    NSInteger _selectedPhotoIndex;
}
@end

@implementation EEAlbumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _photoModelsArray = [NSArray array];
    [_collection registerNib:[UINib nibWithNibName:NSStringFromClass([EEPhotoCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:PHOTO_CELL_IDENTIFIER];
    
    [_spinner startAnimating];
}

- (void)createAlbum:(NSDictionary *)album {
    [EEProcessor createAlbum:album[@"aid"] forUser:album[@"owner_id"] withPhotos:^(NSArray* lPhotos){
        _photoModelsArray = lPhotos;
        [_collection reloadData];
        [_spinner stopAnimating];
        _spinner.hidesWhenStopped = YES;
    }];
}

#pragma mark - Collection realization

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EEFullScreenPhotoCollectionVC* vc = [[EEFullScreenPhotoCollectionVC alloc] init];
    vc.delegate = self;
    _selectedPhotoIndex = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photoModelsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EEPhotoCell *cell = (EEPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:PHOTO_CELL_IDENTIFIER forIndexPath:indexPath];
    [cell setPhoto:[(EEResponsePhotoModel*)_photoModelsArray[indexPath.row] getSmallPhoto]];
    return cell;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(40, 5, 40, 5); /*top, left, bottom, right*/
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger cellWidth = _collection.bounds.size.width / 3 - 10;
    CGSize retval = CGSizeMake(cellWidth, cellWidth);
    return retval;
}

#pragma mark - EEFullScreenPhotoView delegates

- (NSInteger)EEFullScreenPhotoViewDelegateGivePhotoIndex {
    return _selectedPhotoIndex;
}

- (NSArray *)EEFullScreenPhotoViewDelegateGivePhotos {
    return [self createAlbumWithFullPhotos];
}

- (NSArray*)createAlbumWithFullPhotos {
    NSMutableArray* res = [NSMutableArray array];
    for (int i = 0 ; i<_photoModelsArray.count; i++) {
        [res addObject:[(EEResponsePhotoModel*)_photoModelsArray[i] getLargestURL]];
    }
    return res;
}
@end
