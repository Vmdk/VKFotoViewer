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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [EEProcessor friendId:_id fillInfo:^(NSDictionary* info) {
        [self initPhoto:info[@"photo"]];
        _name.text = info[@"name"];
        _shortInfo.text = info[@"short_info"];
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
