//
//  CaidanV.m
//  BaiSI
//
//  Created by Mac on 17/5/2.
//  Copyright © 2017年 www.lanruiyi.com. All rights reserved.
//

#import "CaidanV.h"
#import "MeButton.h"

@interface CaidanV()

@end
@implementation CaidanV

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createSquare:nil];
        
    }
    return self;
}

- (void)createSquare:(NSArray *)square{

    NSUInteger count = 10;
    
    int maxColsCount = 5;
    CGFloat W = self.width/maxColsCount;
    CGFloat H = W;
    
    for (int i = 0; i < count; i ++) {
        
        MeButton *btn = [MeButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((i%maxColsCount)*W, (i/maxColsCount)*H, W, H);
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"mine-icon-preview"] forState:UIControlStateNormal];
        [self addSubview:btn];
    }
    
}
- (void)btnAction:(UIButton *)btn{
    
    NSLog(@"点击了按钮%@",btn.titleLabel.text);
    
}

@end
