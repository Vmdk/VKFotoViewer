//
//  EEFriendInfoVC.m
//  VKFotoViewer
//
//  Created by robert on 7/18/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "EEFriendInfoVC.h"
#import "EERequest.h"
#import "EELogic.h"
#import "EEProcessor.h"
#import "EEResponseUserModel.h"

@implementation EEFriendInfoVC {
    NSString *_id;
    NSDictionary* _tableData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Information";
    [EEProcessor friendId:_id fillInfo:^(EEResponseUserModel* user) {
        _photo.image = user.userPhoto;
        _name.text = user.name;
        _shortInfo.text = @"";
        _tableData = user.tableInfo;
        [_TableWithInfo reloadData];
    }];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setId:(NSString *)ind {
    _id = ind;
}

- (void)initPhoto:(NSString*)photoURL {
    NSData *data =[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:photoURL]];
    _photo.image = [UIImage imageWithData:data];
}

#pragma mark - Table realization

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!_tableData) {
        return 0;
    }
    else {
        NSArray *keys = [_tableData allKeys];
        NSString *curentKey = [keys objectAtIndex:section];
        NSArray *curentInfo = [_tableData objectForKey:curentKey];
        return curentInfo.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!_tableData) {
        return 0;
    }
    else
        return _tableData.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[_tableData allKeys] objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (lCell == nil) {
        lCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    }
    NSArray *curentInfo = [_tableData objectForKey:[[_tableData allKeys] objectAtIndex:indexPath.section]];
    lCell.textLabel.text = [curentInfo objectAtIndex:indexPath.row];
    return lCell;
}
@end
