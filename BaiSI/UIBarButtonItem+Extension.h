//
//  UIBarButtonItem+Extension.h
//  BaiSI
//
//  Created by 兰瑞益 on 17/2/3.
//  Copyright © 2017年 www.lanruiyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
