//
//  WQmacro.h
//  Macro
//
//  Created by 魏琦 on 16/7/13.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

//获取屏幕宽度与高度
#define SCREEEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//获取导航栏高度/电池条/tabbar高度
#define NavBarHeight                        self.navigationController.navigationBar.bounds.size.height
#define StatusBarHeight                     20
#define TabBarHeight                        self.tabBarController.tabBar.bounds.size.height

//获取通知中心
#define WQNotificationCenter [NSNotificationCenter defaultCenter]

//设置随机颜色
#define WQRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]
//设置RGB颜色/设置RGBA颜色值
#define WQRGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define WQRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

//设置clearColor
#define WQClearColor [UIColor clearColor]

//按照十六进制设置颜色值
#define WQHEXColor(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]

//自定义NSLog
#ifdef DEBUG 
#define WQLog(...) NSLog(@"%s第%d行\n%@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define WQLog(...)
#endif

//强引用/弱引用
#define WQWeakSelf(type) __weak typeof(type) weak##type = type
#define WQStrongSelf(type) __strong typeof(type) strong##type = weak##type

//设置View圆角/和圆角线条
#define WQViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:Color.CGColor]

//角度转弧度
#define WQDegressToRadian(x) (M_PI * (x)/180.0)
#define WQDianToDegress(radian) (radian*180.0)/(M_PI)

//获取图片资源
//获取图片资源
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

//获取当前语言
#define WQCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//使用 ARC 和 MRC
#if __has_feature(objc_arc)
// ARC
#else
// MRC
#endif


//判断当前的iPhone设备/系统版本
//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

// 判断是否为 iPhone 5SE
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f

// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f

// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f

//获取系统版本
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//判断 iOS 8 或更高的系统版本
#define IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))


//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//获取沙盒路径
//获取temp
#define kPathTemp NSTemporaryDirectory()

//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//GCD 的宏定义
//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);

//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

//GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlock);

//在主队列延迟执行
#define kDISPATCH_AFTER(delayInSeconds,block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);

//Network(必须引入AFNetWoring)
#define isNetWork ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus > 0)

//APP信息
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define AppBuild [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define AppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define DeviceMode [[UIDevice currentDevice] model]

// 设备版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


//警告框(iOS 8以下使用)
#define ALERT(title, msg)   [[[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show]

//错误信息
#define ERROR(m,c,d) [NSError errorWithDomain:m code:c userInfo:d]

//NSStringFormat
#define WQ(string, args...)  [NSString stringWithFormat:string, args]


//NSUserDefaults
#define UserDefaults  [NSUserDefaults standardUserDefaults]

//适配6plus/6splus字体大小
#define AdapterSize(value)  ((SCREEEN_WIDTH > 375) ? (SCREEEN_WIDTH / 375 * value) : value)
#define AdapterSizeFromIphone6(value)  (SCREEEN_WIDTH / 375.0 * value)

//中文字体
#define CHINESE_FONT_NAME @"Heiti SC"

//MainScreen bounds
#define Main_Screen_Bounds [[UIScreen mainScreen] bounds]

//字体大小
#define BOLDSYSTEMFONT(FONTSIZE) [UIFont boldSystemFontOfSize:FONTSIZE]

#define SYSTEMFONT(FONTSIZE) [UIFont systemFontSize:FONTSIZE]

#define FONT(NAME,FONTSIZE) [UIFont fontWithName:(NAME) size:(FONTSIZE)]

//判断是否是空对象
#define IS_NULL_CLASS(OBJECT) [OBJECT isKindOfClass[NSNull class]]

//获取全局并发队列
//默认优先级
#define GETGLOBAL_DEFAULT_QUEUE     dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define GETGLOBAL_HIGH_QUEUE     dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
#define GETGLOBAL_LOW_QUEUE     dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
#define GETGLOBAL_BACKGROUND_QUEUE     dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)

//创建串行/并行队列
#define CREAT_QUEUE(NAME,TYPE)  dispatch_queue_create(NAME, TYPE)

//判断当前线程
#define CURRENT_THREAD [NSThread currentThread]
//主线程
#define MAIN_THREAD [NSThread mainThread]


