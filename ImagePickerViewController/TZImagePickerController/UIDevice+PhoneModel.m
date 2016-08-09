//
//  UIDevice+PhoneModel.m
//  ImagePickerViewController
//
//  Created by 魏琦 on 16/8/9.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import "UIDevice+PhoneModel.h"

@implementation UIDevice (PhoneModel)
+ (PhoneModel)iPoneModel {
    CGRect bounds  = [UIScreen mainScreen].bounds;
    CGFloat width = bounds.size.width;
    CGFloat height = bounds.size.height;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication]statusBarOrientation];
    if (UIInterfaceOrientationUnknown == orientation) {
        return  Unknown;
    }
    if (UIInterfaceOrientationPortrait == orientation) {
        if (width == 320) {
            if (height == 480)return iPone4;
            else return iPone5;
                
        }
        if (width == 376) {
            return iPone6;
        }
        if (width == 414) {
            return iPone6Plus;
        }
    }
    else if (UIInterfaceOrientationLandscapeLeft == orientation || UIInterfaceOrientationLandscapeRight == orientation) {//landscape
         if (height == 320.0)
         {
            if (width == 480.0f)
            {
                   return iPone4;
            }
            else
            {
                       return iPone5;
        }
           } else if (height == 375.0f)
           {
                   return iPone6;
            }
           else if (height == 414.0f)
           {
                        return iPone6Plus;
           }
    }

    return Unknown;
}
@end
