//
//  MeViewController.m
//  BaiSI
//
//  Created by 兰瑞益 on 17/2/3.
//  Copyright © 2017年 www.lanruiyi.com. All rights reserved.
//

#import "MeViewController.h"
#import "SettingViewController.h"
#import "CollectionVC.h"
@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LCommonBgColor;
    
    self.navigationItem.title = @"我的";
    //右边-设置
//    UIButton *settingBut = [UIButton buttonWithType:UIButtonTypeCustom];
//    [settingBut setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
//    [settingBut setImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
//    [settingBut addTarget:self action:@selector(settingButClick) forControlEvents:UIControlEventTouchUpInside];
//    [settingBut sizeToFit];
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingButClick)];
    //右边－月亮
//    UIButton *moonBut = [UIButton buttonWithType:UIButtonTypeCustom];
//    [moonBut setImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
//    [moonBut setImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
//    [moonBut addTarget:self action:@selector(moonButClick) forControlEvents:UIControlEventTouchUpInside];
//    [moonBut sizeToFit];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonButClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
    
    
}

- (void)settingButClick{

    SettingViewController *setting = [[SettingViewController alloc]init];
    
    [self.navigationController pushViewController:setting animated:YES];

}
- (void)moonButClick{

    CollectionVC *VC = [[CollectionVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];

}
@end
