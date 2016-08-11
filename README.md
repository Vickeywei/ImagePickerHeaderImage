# ImagePickerHeaderImage
模仿qq选择头像的控件封装
使用方法:1.遵守三个协议<UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>
2.在点击头像的方法内部直接复制粘贴改方法:
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
    3.实现协议方法也是直接复制粘贴
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
4.在第二个步骤中我会检测摄像头的权限,所以必须引入#import <AVFoundation/AVFoundation.h>头文件,而且要声明一个isIOS7的宏定义#define isIOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)如果你已经声明过了可以直接将报错位置替换
检测代码如下:
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
实现这些内容后就可以更换头像了,但是你的imageview必须进行替换,直接搜索headerImageView,然后替换成你的imageview名称就一切ok了.
