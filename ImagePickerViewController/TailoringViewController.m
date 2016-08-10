//
//  TailoringViewController.m
//  ImagePickerController
//
//  Created by 魏琦 on 16/8/8.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import "TailoringViewController.h"
#import "NavigationView.h"
#import "WQmacro.h"
#import "InterceptionView.h"
#import "UIDevice+PhoneModel.h"
#import "SurePickerPhotoView.h"
@interface TailoringViewController ()
@property (nonatomic, strong) UIImageView* headerImageView;
@property (nonatomic, strong) InterceptionView* interceView;
@property (nonatomic, strong) UIPanGestureRecognizer* panGestureRecognizer;
@property (nonatomic, strong) UIPinchGestureRecognizer* pinchGestureRecognizer;
@end
@implementation TailoringViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)setUpView {
    self.view.backgroundColor = [UIColor blackColor];
    // 根据图片来创建imageView的大小有的是竖向图片有的是横向图片  不一样的  是将图片压缩了
    CGFloat scale;
    if (self.sourceImage.size.width > self.sourceImage.size.height) {
        
        scale = self.sourceImage.size.width/self.sourceImage.size.height;
        self.headerImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ((SCREEEN_WIDTH-250)*2+130)*scale , ((SCREEEN_WIDTH-250)*2+130))];
    }else{
        scale = self.sourceImage.size.height/self.sourceImage.size.width;
        self.headerImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ((SCREEEN_WIDTH-250)*2+130), ((SCREEEN_WIDTH-250)*2+130)*scale)];
    }
    self.headerImageView.center = self.view.center;
    self.headerImageView.image = self.sourceImage;
    [self.view addSubview:self.headerImageView];
    
    _interceView = [[InterceptionView alloc] initWithFrame:CGRectMake(0,64 ,SCREEEN_WIDTH ,SCREEEN_HEIGHT-104)];
    _interceView.userInteractionEnabled = YES;
    _interceView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_interceView];
    
    NavigationView* navigationView = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width,64)];
    navigationView.backBlock = ^ {
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    [self.view addSubview:navigationView];
    SurePickerPhotoView* sureView = [[SurePickerPhotoView alloc] initWithFrame:CGRectMake(0, SCREEEN_HEIGHT-40,SCREEEN_WIDTH, 40)];
    sureView.surePickerPhontAction = ^ {
        [self sureButtonAction];
    };
    [self.view addSubview:sureView];
    [self controlHeaderImageView];
    
}

- (void)sureButtonAction {
    UIGraphicsBeginImageContextWithOptions(self.headerImageView.bounds.size, NO, 0);
    // 计算圆形图在self.imageView上面的Frame
    CGRect rect = CGRectMake(self.view.center.x - self.headerImageView.frame.origin.x-(SCREEEN_WIDTH-250), self.view.center.y - self.headerImageView.frame.origin.y-(SCREEEN_WIDTH-250), (SCREEEN_WIDTH-250)*2, (SCREEEN_WIDTH-250)*2-10);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [path addClip];
    
    // 获取上下文
    CGContextRef con = UIGraphicsGetCurrentContext();
    // 将self.imageView上面的画到上下文中，因为我们改变的self.imageView的大小来改变图片的大小所以用的self.imageView进行画的
    [self.headerImageView.layer renderInContext:con];
    // 得到截取的图片  但是我们得到图片的大小是整个画布和截取的图片  并不是我们想要的只有截取的图片的大小，所以我们要把小的图片截取下来
    UIImage *new_image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //  裁剪图片  注意裁剪的时候是根据像素的来裁剪的 上下文画图是根据尺寸获取的  所以这里*3是因为在6p上面一个点代表3个像素
    
    PhoneModel model = [UIDevice iPoneModel];
    CGRect oneRect;
    if (model == iPone6Plus) {
        oneRect = CGRectMake(rect.origin.x*3, rect.origin.y*3, rect.size.width*3, rect.size.height*3);
    }
    else {
        oneRect = CGRectMake(rect.origin.x*2, rect.origin.y*2, rect.size.width*2, rect.size.height*2);
    }
    // 裁剪图片
    CGImageRef newImageRef = CGImageCreateWithImageInRect([new_image CGImage], oneRect);
    UIImage *radiu_image = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        self.myBlockImage(radiu_image);
    }];
}

- (void)controlHeaderImageView {
    // 这个是捏合手势的调用的方法
    WQWeakSelf(self);
    [_interceView setMyBlockScale:^(CGFloat scale) {
        WQStrongSelf(self);
        CGSize size = CGSizeMake(self.headerImageView.bounds.size.width*scale, self.headerImageView.bounds.size.height*scale);
        if (size.height <= (SCREEEN_WIDTH-250)*2 || size.width <= (SCREEEN_WIDTH-250)*2) {// 缩小的时候最小一边等于截图的圆
            return ;
        }
        strongself.headerImageView.frame = CGRectMake(0, 0, size.width, size.height);
        strongself.headerImageView.center = strongself.view.center;
    }];
    // 这个是移动的手势
    [_interceView setMyBlockPan:^(CGFloat pointX, CGFloat pointY) {
        WQStrongSelf(self);
        CGRect   frame = strongself.headerImageView.frame;
        frame.origin.x = frame.origin.x + pointX;
        frame.origin.y = frame.origin.y + pointY;
        
        if (frame.origin.x >= strongself.view.center.x - (SCREEEN_WIDTH-250)|| frame.origin.y>=self.view.center.y-((SCREEEN_WIDTH-200)/2)-(SCREEEN_WIDTH-325) || frame.origin.x <= strongself.view.center.x+(SCREEEN_WIDTH-250)-frame.size.width ||frame.origin.y <=_interceView.center.y-((SCREEEN_WIDTH-200)/2) +(SCREEEN_WIDTH-185)-frame.size.height) {// 移动时候不让出去
            return ;
        }
        strongself.headerImageView.frame = frame;
        
    }];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
