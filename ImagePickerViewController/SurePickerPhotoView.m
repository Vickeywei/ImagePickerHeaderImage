//
//  surePickerPhotoView.m
//  ImagePickerViewController
//
//  Created by 魏琦 on 16/8/9.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import "SurePickerPhotoView.h"
#import "WQmacro.h"
@interface SurePickerPhotoView ()

@end
@implementation SurePickerPhotoView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
         UIButton* sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
         sureButton.frame = CGRectMake(SCREEEN_WIDTH-74,5,50,30);
         [sureButton setTitle:@"确定" forState:UIControlStateNormal];
         sureButton.backgroundColor = [UIColor cyanColor];
         sureButton.layer.cornerRadius = 5;
         
         [sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
         [self addSubview:sureButton];
        
    }
    return self;
}

- (void)sureAction:(id)sender {
    if (self.surePickerPhontAction) {
        self.surePickerPhontAction();
    }
}
@end
