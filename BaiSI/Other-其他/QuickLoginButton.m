//
//  QuickLoginButton.m
//  BaiSI
//
//  Created by 兰瑞益 on 2017/3/9.
//  Copyright © 2017年 www.lanruiyi.com. All rights reserved.
//

#import "QuickLoginButton.h"

@implementation QuickLoginButton

- (void)awakeFromNib
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.L_y = 0;
    self.imageView.centerX= self.width*0.5;
    
    self.titleLabel.L_x = 0;
    self.titleLabel.L_y = self.imageView.bottom;
    self.titleLabel.height = self.height - self.imageView.height;
    self.titleLabel.width = self.width;

}

@end
