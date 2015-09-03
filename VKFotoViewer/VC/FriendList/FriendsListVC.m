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
#import "ViewController.h"
#import "EEProcessor.h"
#import "EEUserForListModel.h"

#define CELL_FOR_FRIEND_IDENTIFIER @"identifier"
#define SEARCH_BAR_HEIGHT 40.0f

@interface FriendsListVC () <UISearchBarDelegate, UISearchControllerDelegate> {
}

@end

@implementation FriendsListVC {
    NSMutableArray *_friendsId;
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
    [EEProcessor createFriendsList:^(NSArray *arrayOfModels) {
         [self setFriends:arrayOfModels];
    }];
    _friendsList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(refreshPropertyList)];
    self.navigationItem.rightBarButtonItem = anotherButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Logout

-(void)refreshPropertyList {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"VKAccessUserId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"VKAccessToken"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"VKAccessTokenDate"];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    ViewController* vc = [[ViewController alloc] init];
    [self presentViewController:vc animated:YES completion:^{
       //todo
    }];
}

#pragma mark - Table Realization

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isSearch)
    {
        _rowsShown = _filteredUsersArray.count;
    } else {
        _rowsShown = _names.count;
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

#pragma mark - uploading friends

- (void)showMoreFriends {
    if(_rowsShown + 15 > _friendsId.count) {
        _rowsShown = (int)_friendsId.count;
        _areAllFriendsShown = true;
    }
    else {
        _areAllFriendsShown = false;
        _rowsShown += 15;
    }
    [_friendsList reloadData];
}

-(void)setFriends:(NSArray *)arrayOfModels {
    //default start boolean values
    _isSearch = NO;
    _searchBarIsHidden = NO;
    
    _friendsId = [NSMutableArray arrayWithCapacity:arrayOfModels.count];
    _names = [NSMutableArray arrayWithCapacity:arrayOfModels.count];
    
    int limit = (int)arrayOfModels.count;
    for (int i = 0; i < limit; ++i) {
        _names[i] = [(EEUserForListModel*)arrayOfModels[i] getName];
        _friendsId[i] = [(EEUserForListModel*)arrayOfModels[i] getId];
    }
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
