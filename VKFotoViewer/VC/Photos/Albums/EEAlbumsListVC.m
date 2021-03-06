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
#import "EEAlbum.h"

@implementation EEAlbumsListVC {
    NSArray* _albums;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Albums";
    
    [_albumsList registerNib:[UINib nibWithNibName:NSStringFromClass([EEAlbumCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AlbumCell"];
}

- (void)prepareInfoFor:(NSString *)uId {
    [EEProcessor prepareAlbumsFor:uId successBlock:^(NSArray* albums){
        _albums = albums;
        [_albumsList reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _albums.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EEAlbum *vc = [[EEAlbum alloc] init];
    [vc createAlbum:_albums[indexPath.row][@"aid"] forUser:_albums[indexPath.row][@"owner_id"]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EEAlbumCell *lCell = [tableView dequeueReusableCellWithIdentifier:@"AlbumCell"];
    [lCell prepareInfo:_albums[indexPath.row]];
    return lCell;
}
@end
