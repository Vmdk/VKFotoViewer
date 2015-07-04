//
//  ViewController.m
//  VKFotoViewer
//
//  Created by robert on 7/3/15.
//  Copyright (c) 2015 Vdmk. All rights reserved.
//

#import "ViewController.h"
#import "LogInView.h"

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
    [self  presentViewController:logVC animated:YES completion:nil];
}

@end
