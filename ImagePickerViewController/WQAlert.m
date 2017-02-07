//
//  WQAlert.m
//  ImagePickerViewController
//
//  Created by 魏琦 on 16/8/9.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import "WQAlert.h"
static void (^G_completionBlock)(int buttonindex);
@implementation WQAlert
+ (void)showAlertViewControllerWithTitle:(NSString*)title message:(NSString*)message buttonTitles:(NSArray*)buttonTitles showViewController:(UIViewController*)vc completionBlock:(void(^)(int index))completionBlock cancleBlock:(void(^)(void))cancelBlock preferredStyle:(UIAlertControllerStyle)style{
#ifdef NSFoundationVersionNumber_iOS_8_0
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    int i = 0;
    for (NSString* title in buttonTitles) {
        UIAlertAction* action;
        if ([title isEqualToString:@"取消"] || [title isEqualToString:@"cancel"]) {
             action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (cancelBlock) {
                    cancelBlock();
                }
            }];
        }
        else {
             action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (completionBlock) {
                    completionBlock(i);
                }
            }];
        }
        [alert addAction:action];
        i++;
    }
    [vc presentViewController:alert animated:YES completion:nil];
#else 
    G_completionBlock = [completionblock copy];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:strtitle message:strmessage delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    for (NSString *key in buttontitles) {
        [alert addButtonWithTitle:key];
    }
    [alert show];
    
#endif
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
+(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    

    if (G_completionBlock) {
        G_completionBlock((int)buttonIndex);
    }
}
#pragma clang diagnostic pop
@end
