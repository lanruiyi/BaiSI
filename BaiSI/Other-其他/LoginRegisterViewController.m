//
//  LoginRegisterViewController.m
//  BaiSI
//
//  Created by 兰瑞益 on 2017/3/8.
//  Copyright © 2017年 www.lanruiyi.com. All rights reserved.
//

#import "LoginRegisterViewController.h"

@interface LoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;

@end

@implementation LoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
//状态栏 文字变白色

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    //点击后页面消失
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//关闭当前界面
- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//登录注册切换
- (IBAction)showLoginOrRegister:(UIButton *)button {
    //退出键盘
    [self.view endEditing:YES];
    // 左边设置约束 和 按钮状态
    if (self.leftMargin.constant) {
        
        self.leftMargin.constant = 0;
        button.selected = NO;
        
    }else{
    
        self.leftMargin.constant = - self.view.width;
        button.selected = YES;
    
    }
    //动画
    [UIView animateWithDuration:0.3 animations:^{
        // 强制刷新 : 让最新设置的约束值马上应用到UI控件上
        // 会刷新到self.view内部的所有子控件
        [self.view layoutIfNeeded];
        
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //  退出键盘
    [self.view endEditing:YES];

}

@end
