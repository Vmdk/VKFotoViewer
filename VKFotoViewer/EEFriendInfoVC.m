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

@implementation EEFriendInfoVC {
    NSString *_id;
}

- (void)viewDidLoad {
    NSData *lInfo = [EERequest getIdInfo:_id];
    [self fillInfo:lInfo];
}

- (void)fillInfo:(NSData*)info {
    NSDictionary* larr = [NSJSONSerialization JSONObjectWithData:info options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *lInfo = larr[@"response"][0];
    
    _name.text = [NSString stringWithFormat:@"%@ %@",lInfo[@"first_name"],lInfo[@"last_name"]];
    NSString* lAge = [EELogic getAge:lInfo[@"bdate"]];
    NSString* lCity = [EERequest getCity:lInfo[@"city"]];
    _shortInfo.text = [NSString stringWithFormat:@"%@%@",lAge, lCity];
}

- (void)setId:(NSString *)ind {
    _id = ind;
}

#pragma mark - Table realization

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (lCell == nil) {
        lCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
        lCell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    return lCell;
}
@end
