//
//  TailoringViewController.h
//  ImagePickerController
//
//  Created by 魏琦 on 16/8/8.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TailoringViewController : UIViewController
@property(nonatomic, strong) UIImage* sourceImage;
@property(nonatomic, strong) UINavigationController* picker;
@property(nonatomic, copy) void (^myBlockImage)(UIImage* image);

@end
