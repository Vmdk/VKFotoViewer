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

@implementation EEFriendInfoVC {
    NSString *_id;
    NSDictionary* _tableData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [EEProcessor friendId:_id fillInfo:^(NSDictionary* info) {
        [self initPhoto:info[@"photo"]];
        _name.text = info[@"name"];
        _shortInfo.text = info[@"short_info"];
        _tableData = info[@"table_info"];
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
