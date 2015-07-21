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

@interface FriendsListVC ()

@end

//TODO 1
@implementation FriendsListVC {
    NSArray *_friendsId;
    NSMutableArray *_names;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self setFriends:[EERequest friendRequest]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_names.count<15) {
        return _names.count;
    }
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (lCell == nil) {
        lCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
        lCell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    
    lCell.textLabel.text = [_names objectAtIndex:indexPath.row];
    return lCell;
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    EEFriendInfoVC *vc = [[EEFriendInfoVC alloc] init];
    [vc setId:_friendsId[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setFriends:(NSArray *)arr {
    _friendsId = arr;
    _names = [NSMutableArray array];
    int limit = 15;
    if (arr.count<15) {
        limit = arr.count;
    }
    for (int i = 0; i<limit; ++i) {
        _names[i] = [EERequest getNameForId:arr[i]];
    }
    [_friendsList reloadData];
}

@end
