//
//  WQAlert.h
//  ImagePickerViewController
//
//  Created by 魏琦 on 16/8/9.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WQAlert : NSObject
+ (void)showAlertViewControllerWithTitle:(NSString*)title message:(NSString*)message buttonTitles:(NSArray*)buttonTitles showViewController:(UIViewController*)vc completionBlock:(void(^)(int index))completionBlock cancleBlock:(void(^)(void))cancelBlock preferredStyle:(UIAlertControllerStyle)style;
@end
