//
//  NavigationView.m
//  ImagePickerController
//
//  Created by 魏琦 on 16/8/8.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import "NavigationView.h"

@implementation NavigationView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpView];
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.9;
        
    }
    return self;
}

- (void)setUpView {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 25, 30, 30);
    
    [button setImage:[UIImage imageNamed:@"bcm_backWhite"] forState:UIControlStateNormal];
    [self addSubview:button];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,120, 30)];
    titleLabel.text = @"移动和缩放";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    CGPoint center = self.center;
    center.y = center.y+10;
    titleLabel.center = center;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18 weight:2];
    [self addSubview:titleLabel];
}

- (void)backAction:(id)sender {
    if (self.backBlock) {
        self.backBlock();
    }
}
@end
