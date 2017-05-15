//
//  MeButton.m
//  BaiSI
//
//  Created by 兰瑞益 on 2017/3/11.
//  Copyright © 2017年 www.lanruiyi.com. All rights reserved.
//

#import "MeButton.h"

@implementation MeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //按钮文字属性
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置按钮背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //图片位置
    self.imageView.L_y = self.height*.1;
    self.imageView.width = self.width*.5;
    self.imageView.height = self.height*.5;
    self.imageView.centerX = self.width*.5;
    
    //文字位置
    self.titleLabel.L_x = 0;
    self.titleLabel.L_y = self.imageView.bottom;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.L_y;
    
}
@end
