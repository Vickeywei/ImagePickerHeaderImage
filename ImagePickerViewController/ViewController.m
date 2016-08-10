//
//  ViewController.m
//  ImagePickerController
//
//  Created by 魏琦 on 16/8/8.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "TZImagePickerController.h"
#import "TailoringViewController.h"
#import "WQmacro.h"
#import "WQAlert.h"
#define isIOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>
@property (nonatomic, strong) UIImageView* headerImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headerImageView];

}

- (IBAction)headerImageAction:(id)sender {
    [WQAlert showAlertViewControllerWithTitle:nil message:nil buttonTitles:@[@"拍照",@"从相册选择",@"取消"] showViewController:self completionBlock:^(int index) {
        switch (index) {
            case 0: {
                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    if ([self checkCameraAuthorization]) {
                        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
                        picker.delegate = self;
                        picker.sourceType = sourceType;
                        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
                            self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
                        }
                        [self presentViewController:picker animated:YES completion:^{
                        }];
                    }
                }
            }
                break;
            case 1: {
                TZImagePickerController* imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
                [self presentViewController:imagePicker animated:YES completion:^{
        
                }];
            }
                break;
                
            default:
                break;
        }
        
    } cancleBlock:^{
        
    }preferredStyle:UIAlertControllerStyleActionSheet ];

}


- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    TailoringViewController* tailoringVC = [[TailoringViewController alloc] init];
    tailoringVC.sourceImage  = photos.firstObject;
    tailoringVC.picker = picker;
    tailoringVC.myBlockImage = ^ (UIImage* image){
        self.headerImageView.image = image;
    };
    [picker pushViewController:tailoringVC animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    TailoringViewController* tailoringVC = [[TailoringViewController alloc] init];
    tailoringVC.sourceImage  = info[UIImagePickerControllerOriginalImage];
    tailoringVC.picker = picker;
    tailoringVC.myBlockImage = ^ (UIImage* image){
        self.headerImageView.image = image;
    };
    [picker pushViewController:tailoringVC animated:YES];
}

- (BOOL)checkCameraAuthorization
{
    BOOL isAvalible = YES;
    //ios 7.0以上的系统新增加摄像头权限检测
    if (isIOS7) {
        //获取对摄像头的访问权限。
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (authStatus) {
            case AVAuthorizationStatusRestricted:
                break;
            case AVAuthorizationStatusDenied:
                isAvalible = NO;
                break;
            case AVAuthorizationStatusAuthorized:
                break;
            case AVAuthorizationStatusNotDetermined:
                isAvalible =[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
                break;
            default:
                break;
        }
    }
    if (!isAvalible) {
        NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
        NSString *appName =[infoDict objectForKey:@"CFBundleDisplayName"];
        [WQAlert showAlertViewControllerWithTitle:@"" message:[NSString stringWithFormat:@"您关闭了%@的相机权限，无法进行拍照。可以在手机 > 设置 > 隐私 > 相机中开启权限。", appName] buttonTitles:@[@"确定"] showViewController:self completionBlock:^(int index) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            
        } cancleBlock:^{
            
        } preferredStyle:UIAlertControllerStyleAlert];
        
    }
    return isAvalible;
}

- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 80,120, 120)];
        _headerImageView.layer.masksToBounds = YES;
        _headerImageView.layer.cornerRadius = 60;
        _headerImageView.backgroundColor = [UIColor redColor];
       
    }
    return _headerImageView;
}


@end
