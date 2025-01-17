//
//  AppDelegate.m
//  ThirdLoginDemo
//
//  Created by bioongroup on 15/7/20.
//  Copyright (c) 2015年 ylk. All rights reserved.
//

#import "AppDelegate.h"
/**
 *  导入头文件
 */
#import "Header.h"

@interface AppDelegate ()
{
    /**
     *  设置启动页/sdk<8.0
     */
    UIImageView *_bgImageView;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //NSLog(@"沙盒路径:%@",NSHomeDirectory());
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //    系统栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window.backgroundColor = [UIColor whiteColor];
    

    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"8f0a05e74b10"
          activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeWechat),@(SSDKPlatformTypeQQ),]
                 onImport:nil
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              
              switch (platformType)
              {
                  case SSDKPlatformTypeSinaWeibo:
                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupSinaWeiboByAppKey:@"589153281"
                                                appSecret:@"a041260319ceb3c26112a1330379b668"
                                              redirectUri:@"http://www.baidu.com"
                                                 authType:SSDKAuthTypeWeb];
                      break;
                      
                  case SSDKPlatformTypeWechat:
                      //设置微信应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupWeChatByAppId:@"your appid"
                                            appSecret:@"your secret"];
                      break;
                  case SSDKPlatformTypeQQ:
                      //设置QQ应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupQQByAppId:@"your appid"
                                           appKey:@"your appkey"
                                         authType:SSDKAuthTypeBoth];
                      break;
                  default:
                      break;
              }
              
          }];
    //8.0以后的系统有起始界面，之前的没有
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 8.0)
    {
        [self inViewRootVC];
    }
    else
    {
        _bgImageView        = [[UIImageView alloc] initWithFrame:self.window.bounds];
        _bgImageView.image  = [UIImage imageNamed:@"go.jpg"];
        [self.window addSubview:_bgImageView];
        
        [self                       performSelector:@selector(inViewRootVC)
                                         withObject:nil
                                         afterDelay:1.5];
    }
    

    return YES;
}
/**
 * 设置根视图
 */
-(void)inViewRootVC
{
    ViewController *vc          = [[ViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
