//
//  ViewController.m
//  VKFotoViewer
//
//  Created by robert on 7/3/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "ViewController.h"
#import "LogInView.h"
#import "FriendsListVC.h"
#import "EERequest.h"


@interface ViewController () <LogInViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logInClick:(id)sender {
    LogInView *logVC = [[LogInView alloc] init];
    logVC.baseDelegate = self;
    [self.navigationController pushViewController:logVC animated:YES];
}

#pragma mark - Login delegates

- (void)LogInViewDelegateLoginState:(BOOL)state {
    if (state) {
        FriendsListVC *friendVC = [[FriendsListVC alloc] init];
       
        [self.navigationController pushViewController:friendVC animated:YES];
    } else {
        
        UIAlertView *lAlertView = [[UIAlertView alloc] initWithTitle:@"something wrong!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [lAlertView show];
    }
}

@end
