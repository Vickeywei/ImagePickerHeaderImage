//
//  UIDevice+PhoneModel.h
//  ImagePickerViewController
//
//  Created by 魏琦 on 16/8/9.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(char,PhoneModel) {
    iPone4,//320*480
    iPone5,//320*568
    iPone6,//376*667
    iPone6Plus,//414*736
    Unknown
};
@interface UIDevice (PhoneModel)
+(PhoneModel)iPoneModel;


@end
