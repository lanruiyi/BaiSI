//
//  ForgetViewController.m
//  BaiSI
//
//  Created by Mac on 17/3/29.
//  Copyright © 2017年 www.lanruiyi.com. All rights reserved.
//

#import "ForgetViewController.h"

@interface ForgetViewController ()

@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.shouldResignOnTouchOutside = YES;
    keyboardManager.keyboardDistanceFromTextField = 120;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)codeBut:(id)sender {
    //获取验证码
    
}
- (IBAction)confirm:(id)sender {
    //确定
    
}
- (IBAction)close:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
