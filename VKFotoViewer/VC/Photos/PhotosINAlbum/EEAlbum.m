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
#import "EEPhoto.h"
#import "EEResponsePhotoModel.h"
#import "EEFullScreenPhotoView.h"

@implementation EEAlbum {
    NSArray* _Photos;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _Photos = [NSArray array];
    [_Collection registerNib:[UINib nibWithNibName:NSStringFromClass([EEPhotoCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"PhotoCell"];
    
    [_spinner startAnimating];
}

- (void)createAlbum:(NSString *)albId forUser:(NSString*)uId {
    [EEProcessor createAlbum:albId forUser:(NSString*)uId withPhotos:^(NSArray* lPhotos){
        _Photos = lPhotos;
        [_Collection reloadData];
        [_spinner stopAnimating];
        _spinner.hidesWhenStopped = TRUE;
    }];
}

- (NSArray*)createAlbumWithFullPhotos {
    NSMutableArray* res = [NSMutableArray array];
    for (int i = 0 ; i<_Photos.count; i++) {
        [res addObject:[(EEResponsePhotoModel*)_Photos[i] getLargestURL]];
    }
    return res;
}

#pragma mark - Collection realization

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //EEPhoto *vc = [[EEPhoto alloc] init];
    //[vc setPhoto:[(EEResponsePhotoModel*)_Photos[indexPath.row] getLargestPhoto]];
    
    EEFullScreenPhotoView* vc = [[EEFullScreenPhotoView alloc] initWithPhotos:[self createAlbumWithFullPhotos]];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _Photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"PhotoCell";    
    EEPhotoCell *cell = (EEPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell setPhoto:[(EEResponsePhotoModel*)_Photos[indexPath.row] getSmallPhoto]];
    
    return cell;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(40, 5, 40, 5); /*top, left, bottom, right*/
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    int cellWidth = _Collection.bounds.size.width/3 - 10;
    CGSize retval = CGSizeMake(cellWidth, cellWidth);
    return retval;
}

@end
