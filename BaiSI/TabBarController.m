//
//  TabBarController.m
//  BaiSI
//
//  Created by 兰瑞益 on 17/2/1.
//  Copyright © 2017年 www.lanruiyi.com. All rights reserved.
//

#import "TabBarController.h"
#import "EssenceViewController.h"
#import "NewViewController.h"
#import "FollowViewController.h"
#import "MeViewController.h"
#import "MYNavigationController.h"
@interface TabBarController ()
// 中间发布按钮
@property (nonatomic,strong) UIButton *publishButton;

@end

@implementation TabBarController

#pragma mark - 懒加载
//发布按钮
- (UIButton *)publishButton{
    if (!_publishButton) {
        _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //_publishButton.backgroundColor = BSRandomColor;
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        _publishButton.frame = CGRectMake(0, 0, self.tabBar.frame.size.width/5, self.tabBar.frame.size.height);
        _publishButton.center = CGPointMake(self.tabBar.frame.size.width * 0.5, self.tabBar.frame.size.height * 0.5);
        [_publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _publishButton;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    /** 文字属性 **/
    // 普通状态下的文字属性
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    //添加子控制器
    [self setupOneChildViewController:[[MYNavigationController alloc] initWithRootViewController:[[EssenceViewController alloc] init]]  title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupOneChildViewController:[[MYNavigationController alloc] initWithRootViewController:[[NewViewController alloc] init]] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    //中间占位的自控控制器
    [self setupOneChildViewController:[[MYNavigationController alloc] init] title:nil image:nil selectedImage:nil];
    
    [self setupOneChildViewController:[[MYNavigationController alloc] initWithRootViewController:[[FollowViewController alloc] init]] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupOneChildViewController:[[MYNavigationController alloc] initWithRootViewController:[[MeViewController alloc] init]] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    //根控制器
    //UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    
//    UITableViewController *tabVC1 = [[UITableViewController alloc] init];
//    tabVC1.view.backgroundColor = [UIColor redColor];
//    tabVC1.tabBarItem.title = @"精华";
//    tabVC1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
//    tabVC1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
//    [self addChildViewController:tabVC1];
//    
//    UITableViewController *tabVC2 = [[UITableViewController alloc] init];
//    tabVC2.view.backgroundColor = [UIColor cyanColor];
//    tabVC2.tabBarItem.title = @"最新";
//    tabVC2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
//    tabVC2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
//    [self addChildViewController:tabVC2];
//    
//    UITableViewController *tabVC3 = [[UITableViewController alloc] init];
//    tabVC3.view.backgroundColor = [UIColor greenColor];
//    tabVC3.tabBarItem.title = @"关注";
//    tabVC3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
//    tabVC3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
//    [self addChildViewController:tabVC3];
//    
//    UITableViewController *tabVC4 = [[UITableViewController alloc] init];
//    tabVC4.view.backgroundColor = [UIColor orangeColor];
//    tabVC4.tabBarItem.title = @"我";
//    tabVC4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
//    tabVC4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
//    [self addChildViewController:tabVC4];
}
- (void) viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    /**** 增加一个发布按钮 ****/
    [self.tabBar addSubview:self.publishButton];

}

/**
 *  初始化一个子控制器
 *
 *  @param tabVC         子控制器
 *  @param title         标题
 *  @param image         图标
 *  @param selectedImage 选中的图标
 */
- (void)setupOneChildViewController:(UIViewController *)tabVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{

    //tabVC.view.backgroundColor = BSRandomColor;
    tabVC.tabBarItem.title = title;
    if (image.length) {
        tabVC.tabBarItem.image = [UIImage imageNamed:image];
        tabVC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    [self addChildViewController:tabVC];


}

#pragma mark - 监听
//按钮的点击事件
- (void) publishClick{
    BSLogFunc
    
//    TestViewController *Tvc = [[TestViewController alloc] init];
//    
//    [self presentViewController:Tvc animated:YES completion:nil];

}




@end
