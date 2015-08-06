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

@implementation EEAlbumsListVC {
    NSArray* _albums;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EEAlbumCell *lCell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (lCell == nil) {
        lCell = [[EEAlbumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
        [lCell prepareInfo:_albums[indexPath.row]];
    }
    return lCell;
}
@end
