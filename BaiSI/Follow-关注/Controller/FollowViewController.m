//
//  FollowViewController.m
//  BaiSI
//
//  Created by 兰瑞益 on 17/2/3.
//  Copyright © 2017年 www.lanruiyi.com. All rights reserved.
//

#import "FollowViewController.h"
#import "RecommendFollowViewController.h"
#import "LoginRegisterViewController.h"
#import "YSBLoginViewController.h"

@interface FollowViewController ()

@end

@implementation FollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LCommonBgColor;
    //标题
    self.navigationItem.title = @"我的关注";
    //左边按钮
//    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
//    [but setImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
//    [but setImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
//    [but addTarget:self action:@selector(followClick) forControlEvents:UIControlEventTouchUpInside];
//    [but sizeToFit];
    //self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(followClick)];
    
}

- (IBAction)loginRegister:(id)sender {
    
//    LoginRegisterViewController *loginRVC = [[LoginRegisterViewController alloc] init];
//    
//    //视图切换，没有NavigationController的情况下，一般会使用presentViewController来切换视图并携带切换时的动画
//    [self presentViewController:loginRVC animated:YES completion:nil];
    YSBLoginViewController *LCV = [[YSBLoginViewController alloc]init];
    [self presentViewController:LCV animated:YES completion:nil];
    
}

- (void)followClick
{
    RecommendFollowViewController *follow = [[RecommendFollowViewController alloc] init];
    
    [self.navigationController pushViewController:follow animated:YES];
}


@end
