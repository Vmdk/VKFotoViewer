//
//  EEAlbumsListVC.m
//  VKFotoViewer
//
//  Created by robert on 8/6/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EEAlbumsListVC.h"
#import "EEProcessor.h"
#import "EEAlbumCell.h"
#import "EEAlbumVC.h"

#define ALBUM_CELL_IDENTIFIER @"AlbumCell"
#define ROW_HEIGHT 150

@implementation EEAlbumsListVC {
    NSArray* _albumsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Albums";
    [_albumsList registerNib:[UINib nibWithNibName:NSStringFromClass([EEAlbumCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ALBUM_CELL_IDENTIFIER];
    _albumsList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_spinner startAnimating];
}

- (void)prepareInfoFor:(NSString *)uId {
    [EEProcessor prepareAlbumsFor:uId successBlock:^(NSArray* albums){
        _albumsArray = albums;
        [_albumsList reloadData];
        [_spinner stopAnimating];
    }];
}
#pragma mark - Table realization

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _albumsArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EEAlbumVC *vc = [[EEAlbumVC alloc] init];
    vc.title = _albumsArray[indexPath.row][@"title"];
    [vc createAlbum:_albumsArray[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ROW_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EEAlbumCell *lCell = [tableView dequeueReusableCellWithIdentifier:ALBUM_CELL_IDENTIFIER];
    [lCell prepareInfo:_albumsArray[indexPath.row]];
    return lCell;
}
@end
