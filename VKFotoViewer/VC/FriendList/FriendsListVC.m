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
#define SEARCH_BAR_HEIGHT 40.0f

@interface FriendsListVC () <UISearchBarDelegate, UISearchControllerDelegate> {
}

@end

@implementation FriendsListVC {
    NSArray *_friendsId;
    NSMutableArray *_names;
    NSMutableArray *_filteredUsersArray;
    NSInteger _rowsShown;
    BOOL _areAllFriendsShown;
    BOOL _isSearch;
    CGFloat _lastContentOffset;
    BOOL _searchBarIsHidden;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Friends";
    [self setFriends:[EERequest friendRequest]];
    _friendsList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _isSearch = NO;
    _searchBarIsHidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isSearch)
    {
        _rowsShown = _filteredUsersArray.count;
    } else {
        if(!_rowsShown) {
            _rowsShown = 15;
        } else {
            _rowsShown = _names.count;
        }
    }
    return _rowsShown;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:CELL_FOR_FRIEND_IDENTIFIER];
    if (lCell == nil) {
        lCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_FOR_FRIEND_IDENTIFIER];
        lCell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    if (_isSearch)
    {
        lCell.textLabel.text = [_filteredUsersArray objectAtIndex:indexPath.row];
    } else {
        lCell.textLabel.text = [_names objectAtIndex:indexPath.row];
    }
    return lCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
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
    int temp = indexPath.row;
    if (indexPath.row == _rowsShown - 1 && !_areAllFriendsShown && !_isSearch ) {
        [self uploadFriends];
    }
}

#pragma mark - uploading friends

- (void)uploadFriends {
    if (_names.count == _rowsShown) {
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
    _filteredUsersArray = _names.copy;
    [_friendsList reloadData];
}

#pragma mark Content Search

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _filteredUsersArray = [NSMutableArray array];
    if ([searchText isEqualToString:@""]) {
        _isSearch = false;
        [_friendsList reloadData];
    }
    else {
        _isSearch = true;
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
        _filteredUsersArray = (NSMutableArray*)[_names filteredArrayUsingPredicate:resultPredicate];
        [_friendsList reloadData];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _lastContentOffset = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_lastContentOffset > scrollView.contentOffset.y && _searchBarIsHidden) {
        [UIView animateWithDuration:0.3f animations: ^{
            _searchController.frame = CGRectMake(_searchController.frame.origin.x, _searchController.frame.origin.y, _searchController.frame.size.width, SEARCH_BAR_HEIGHT);
            _searchBarIsHidden = NO;
            _friendsList.frame = CGRectMake(_friendsList.frame.origin.x, _friendsList.frame.origin.y + SEARCH_BAR_HEIGHT, _friendsList.frame.size.width, _friendsList.frame.size.height - SEARCH_BAR_HEIGHT);
            }];
    }
    else if (_lastContentOffset < scrollView.contentOffset.y && !_searchBarIsHidden) {
        [UIView animateWithDuration:0.3f animations: ^{
            _searchController.frame = CGRectMake(_searchController.frame.origin.x, _searchController.frame.origin.y, _searchController.frame.size.width, 0.0f);
            _searchBarIsHidden = YES;
            _friendsList.frame = CGRectMake(_friendsList.frame.origin.x, _friendsList.frame.origin.y - SEARCH_BAR_HEIGHT, _friendsList.frame.size.width, _friendsList.frame.size.height + SEARCH_BAR_HEIGHT);
            }];
    }
    _lastContentOffset = scrollView.contentOffset.y;
}

@end
