//
//  UIBarButtonItem+Extension.m
//  BaiSI
//
//  Created by 兰瑞益 on 17/2/3.
//  Copyright © 2017年 www.lanruiyi.com. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    [button sizeToFit];
    return [[self alloc] initWithCustomView:button];

}

@end
