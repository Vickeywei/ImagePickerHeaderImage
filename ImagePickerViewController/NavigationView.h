//
//  NavigationView.h
//  ImagePickerController
//
//  Created by 魏琦 on 16/8/8.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationView : UIView
- (instancetype)initWithFrame:(CGRect)frame;
@property(nonatomic,copy) void(^backBlock)(void);


@end
