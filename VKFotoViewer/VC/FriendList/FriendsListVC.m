//
//  FriendsListVC.m
//  VKFotoViewer
//
//  Created by robert on 7/7/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "FriendsListVC.h"
#import "EERequest.h"
#import "EEFriendInfoVC.h"
#import "EEAlbumsListVC.h"

#define CELL_FOR_FRIEND_IDENTIFIER @"identifier"

@interface FriendsListVC ()

@end

@implementation FriendsListVC {
    NSArray *_friendsId;
    NSMutableArray *_names;
    NSInteger _rowsShown;
    BOOL _areAllFriendsShown;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Friends";
    [self setFriends:[EERequest friendRequest]];
    _friendsList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_names.count < 15) {
        _rowsShown = _names.count;
    }
    if(!_rowsShown) {
        _rowsShown = 15;
    }
    return _rowsShown;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:CELL_FOR_FRIEND_IDENTIFIER];
    if (lCell == nil) {
        lCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_FOR_FRIEND_IDENTIFIER];
        lCell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    lCell.textLabel.text = [_names objectAtIndex:indexPath.row];
    return lCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EEAlbumsListVC* vc = [[EEAlbumsListVC alloc] init];
    [vc prepareInfoFor:_friendsId[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    EEFriendInfoVC *vc = [[EEFriendInfoVC alloc] init];
    vc.friendId = _friendsId[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _rowsShown - 1 && !_areAllFriendsShown) {
        [self uploadFriends];
    }
}

- (void)uploadFriends {
    if(_rowsShown + 15 > _friendsId.count) {
        for (NSInteger i = _rowsShown; i < _friendsId.count; ++i) {
            _names[i] = [EERequest getNameForId:_friendsId[i]];
        }
        _rowsShown = (int)_friendsId.count;
        _areAllFriendsShown = true;
    }
    else {
        for (NSInteger i = _rowsShown; i < _rowsShown+15; ++i) {
            _names[i] = [EERequest getNameForId:_friendsId[i]];
        }
        _areAllFriendsShown = false;
        _rowsShown += 15;
    }
    [_friendsList reloadData];
}

-(void)setFriends:(NSArray *)arr {
    _friendsId = arr;
    _names = [NSMutableArray array];
    int limit = 15;
    if (arr.count < 15) {
        limit = (int)arr.count;
        _areAllFriendsShown = true;
    }
    for (int i = 0; i < limit; ++i) {
        _names[i] = [EERequest getNameForId:arr[i]];
    }
    _areAllFriendsShown = false;
    [_friendsList reloadData];
}

@end
