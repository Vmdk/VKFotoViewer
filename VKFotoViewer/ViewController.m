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


@interface ViewController ()

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
    LogInView *logVC = [[LogInView alloc] initWithNibName:@"LogInView" bundle:nil];
    logVC.baseDelegate = self;
    [self presentViewController:logVC animated:YES completion:nil];
}

- (void)afterAuth {
    FriendsListVC *friendVC = [[FriendsListVC alloc] initWithNibName:@"FriendsListVC" bundle:nil];
    [friendVC setFriends:[self friendRequest]];
    [self presentViewController:friendVC animated:YES completion:nil];
}

- (NSArray*)friendRequest {
    NSString *us_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessUserId"];
    //NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccesssToken"];
    //NSString *stringReq = [NSString stringWithFormat:@"https://api.vk.com/method/friends.get?user_id=%@&order=hints&access_token=%@", us_id, accessToken];
    NSString *stringReq = [NSString stringWithFormat:@"https://api.vk.com/method/friends.get?user_id=%@&order=hints", us_id];
    //get data from string(request)
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringReq]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:60.0];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    //NSLog([[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessUserId"]);
    //NSLog([[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessToken"]);
    NSDictionary *friendsId = [NSJSONSerialization JSONObjectWithData:responseData options:NSNotFound error:nil];
    NSArray *idArray = friendsId[@"response"];
    return idArray;
}

@end
