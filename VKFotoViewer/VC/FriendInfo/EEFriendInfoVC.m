//
//  EEFriendInfoVC.m
//  VKFotoViewer
//
//  Created by robert on 7/18/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EEFriendInfoVC.h"
#import "EERequest.h"
#import "EEProcessor.h"
#import "EEResponseUserModel.h"

#define INFORMATION_TABLE_CELL_IDENTIFIER @"identifier"
#define SECTION_HEIGHT 50.0f

@implementation EEFriendInfoVC {
    NSDictionary* _tableInformation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillViewWithUserInfo];
}

- (void)fillViewWithUserInfo {
    self.title = @"Information";
    [_spinner startAnimating];
    [EEProcessor friendId:_friendId fillInfo:^(EEResponseUserModel* user) {
        _photo.image = user.userPhoto;
        _name.text = user.name;
        _shortInfo.text = @"";
        _tableInformation = user.tableInfo;
        [_tableWithUserInfo reloadData];
        [_spinner stopAnimating];
    }];
    _tableWithUserInfo.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - Table realization

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!_tableInformation) {
        return 0;
    }
    else {
        NSArray *keys = [_tableInformation allKeys];
        NSString *curentKey = [keys objectAtIndex:section];
        NSArray *curentInfo = [_tableInformation objectForKey:curentKey];
        return curentInfo.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SECTION_HEIGHT;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!_tableInformation) {
        return 0;
    }
    else
        return _tableInformation.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[_tableInformation allKeys] objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:INFORMATION_TABLE_CELL_IDENTIFIER];
    if (lCell == nil) {
        lCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:INFORMATION_TABLE_CELL_IDENTIFIER];
    }
    NSArray *curentInfo = [_tableInformation objectForKey:[[_tableInformation allKeys] objectAtIndex:indexPath.section]];
    lCell.textLabel.text = [curentInfo objectAtIndex:indexPath.row];
    return lCell;
}
@end
