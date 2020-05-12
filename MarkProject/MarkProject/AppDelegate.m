//
//  AppDelegate.m
//  MarkProject
//
//  Created by 孙冬 on 2019/11/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    EasyNavigationOptions *options = [EasyNavigationOptions shareInstance];
    options.titleColor = [UIColor whiteColor];
    options.buttonTitleFont = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    options.navigationBackButtonImageName = @"back_btn";
    options.buttonTitleColor = [UIColor whiteColor];
    options.btnTitleType = FBackBtnTitleType_Default;
    
    EasyNavigationController *navVC = [[EasyNavigationController alloc]initWithRootViewController:[MainViewController new]];
    self.window.rootViewController = navVC ;
    [MDInstance sharedInstance].DeviceID = [MDMethods getUUIDByKeyChain];
    [self setTheme];
    [self getUserInfo];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called inƒstead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];//进入前台取消应用消息图标
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)setTheme
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [MDInstance sharedInstance].isLogin = [userdefaults boolForKey:IsLoginPath];
    if ([MDInstance sharedInstance].isLogin) {
        NSString *filePath = [DocumentsDirectoryPath stringByAppendingPathComponent:UserPreferencesPlist];
        //判断用户偏好plist是否存在
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            <#statements#>
        } else {
            <#statements#>
        }
        [MDInstance sharedInstance].themeColor = [userdefaults objectForKey:ThemeColorPath];
    } else {
        [MDInstance sharedInstance].themeColor = TintColor;
    }
    
    
    
    
    
}
#pragma mark  - ------  bomb云  ------
-(void)getUserInfo
{
    [Bmob registerWithAppKey:@"82ca2e259fd2d0cf3412e1b0796b8dd4"];
    //往GameScore表添加一条playerName为小明，分数为78的数据
    BmobObject *gameScore = [BmobObject objectWithClassName:@"UserList"];
    [gameScore setObject:@"ling_shi" forKey:@"user_email"];
    [gameScore setObject:@"dsfdf" forKey:@"user_password"];
    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //进行操作
        NSLog(@"%@",error.description);
    }];
    NSLog(@"%@",DocumentsDirectoryPath);
    //    NSData *data = [NSData dataWithContentsOfFile:<#(nonnull NSString *)#>];
    
//    //获取沙盒目录
//      NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//      NSString *plistPath1 = [paths objectAtIndex:0];
//
//      //得到完整的文件名
//      NSString *filename=[plistPath1 stringByAppendingPathComponent:@"my.plist"];
//      NSDictionary * dic = @{@"my":@"haha"};
//      [dic  writeToFile:filename atomically:YES];
//
//      //取数据
//      NSDictionary * getDic = [NSDictionary dictionaryWithContentsOfFile:filename];
//      NSLog(@"%@",getDic);
}

@end
