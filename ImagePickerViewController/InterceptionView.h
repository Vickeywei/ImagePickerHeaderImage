//
//  InterceptionView.h
//  ImagePickerViewController
//
//  Created by 魏琦 on 16/8/8.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InterceptionView : UIView
- (instancetype)initWithFrame:(CGRect)frame;
@property(nonatomic,strong)void(^myBlockScale)(CGFloat index);
@property(nonatomic,strong)void(^myBlockPan)(CGFloat pointX,CGFloat pointY);
@end
