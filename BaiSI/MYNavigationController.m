//
//  MYNavigationController.m
//  BaiSI
//
//  Created by 兰瑞益 on 17/2/5.
//  Copyright © 2017年 www.lanruiyi.com. All rights reserved.
//

#import "MYNavigationController.h"

@interface MYNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation MYNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

/**
 *  重写push方法的目的 : 拦截所有push进来的子控制器
 *
 *  @param viewController 刚刚push进来的子控制器
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count>0) {
        //子控制器左上角返回按钮
        UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBut setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backBut setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backBut setTitle:@"返回" forState:UIControlStateNormal];
        [backBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBut setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backBut sizeToFit];
        //向左偏移
        backBut.contentEdgeInsets = UIEdgeInsetsMake(0, self.view.width/18.75, 0, 0);
        [backBut addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBut];
        // 隐藏底部的工具条
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    // 所有设置搞定后, 再push控制器
    [super pushViewController:viewController animated:animated];

}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma make UIGestureRecognizerDelegate
/**
 *  手势识别器对象会调用这个代理方法来决定手势是否有效
 *
 *  @return YES : 手势有效, NO : 手势无效
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    if (self.childViewControllers.count == 1) { // 导航控制器中只有1个子控制器
//                return NO;
//            }
//            return YES;
    
    return self.childViewControllers.count > 1;
}

@end