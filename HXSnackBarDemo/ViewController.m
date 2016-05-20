//
//  ViewController.m
//  HXSnackBarDemo
//
//  Created by hongxi on 16/5/19.
//  Copyright © 2016年 hongxi. All rights reserved.
//

#import "ViewController.h"
#import "HXSnackBar.h"

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

- (IBAction)test1:(id)sender {
    HXSnackBar *snackBar = [HXSnackBar snackBarWithBuilder:^(HXSnackBarBuilder *builder) {
        builder.containerViewController = self;
        builder.isSlideBelowNavigationBar = YES;
        builder.noticeText = @"集合,准备团战";
    }];
    [snackBar show];
}

- (IBAction)test2:(id)sender {
    HXSnackBar *snackBar = [HXSnackBar snackBarWithBuilder:^(HXSnackBarBuilder *builder) {
        builder.containerViewController = self;
        builder.backgroundColor = [UIColor colorWithRed:0.0f green:153.0f/255.0f blue:204.0f/255.0f alpha:1.0f];
        builder.noticeText = @"进攻暗影主宰";
    }];
    [snackBar show];
}

- (IBAction)test3:(id)sender {
    HXSnackBar *snackBar = [HXSnackBar snackBarWithBuilder:^(HXSnackBarBuilder *builder) {
        builder.containerViewController = self;
        builder.duration = -1;
        builder.noticeText = @"网络好像有点不稳定";
        builder.actionText = @"重新尝试";
        builder.actionBlock = ^{
            NSLog(@"666666");
        };
    }];
    [snackBar show];
}

@end
