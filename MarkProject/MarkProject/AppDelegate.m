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

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

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
    //注册消息推送
    [self p_registerForUserNotificationHandler:application];
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

- (void)p_registerForUserNotificationHandler:(UIApplication *)application{
    if (@available(iOS 10.0,*)) {
        //iOS10特有
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        // 必须写代理，不然无法监听通知的接收与点击
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // 点击允许
                NSLog(@"requestAuthorization成功");
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    NSLog(@"getNotificationSettings :: %@", settings);
                }];
            } else {
                // 点击不允许
                NSLog(@"requestAuthorization失败");
            }
        }];
    }else{
        //iOS8 - iOS10
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
[application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
        #pragma clang diagnostic pop
        
    }
}
#pragma mark - ios 8 - 10 收到通知。
- (void)application:(UIApplication *)application didReceiveLocalNotification:(nonnull UILocalNotification *)notification{
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {// app位于前台通知
        NSLog(@"前台本地通知，didReceiveLocalNotification");
    }else{
        NSLog(@"后台本地通知，didReceiveLocalNotification");
    }
}
#pragma mark - ios >= 10 收到通知。
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(nonnull UNNotification *)notification withCompletionHandler:(nonnull void (^)(UNNotificationPresentationOptions))completionHandler __IOS_AVAILABLE(10.0) {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (userInfo) {
        NSLog(@"app位于前台通知(willPresentNotification:):%@", userInfo);
    }
    //前台显示通知消息 仅支持10以后。
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
    //    completionHandler(UNNotificationPresentationOptionNone);
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler __IOS_AVAILABLE(10.0) {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (userInfo) {
        NSLog(@"app位于后台通知 点击通知触发 (didReceiveNotificationResponse:):%@,", userInfo);
        if ([userInfo[@"id"] isEqualToString:@"LOCAL_NOTIFY_SCHEDULE_ID"]) {
            NSLog(@"收到了指定通知 做出特定处理");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"acceptLocalNotification" object:nil];
        }
        //如果设置了badge值 需要清除。
    }
    
    completionHandler();
}

-(void)setTheme
{
    if ([MDInstance sharedInstance].isLogin) {
        NSString *filePath = [DocumentsDirectoryPath stringByAppendingPathComponent:UserPreferencesPlist];
        //判断用户偏好plist是否存在
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            
        } else {
            
        }
        
    } else {
        [MDInstance sharedInstance].themeColor = TintColor;
    }
    
    
    
    
    
}
#pragma mark  - ------  bomb云  ------
-(void)getUserInfo
{
    [Bmob registerWithAppKey:@"82ca2e259fd2d0cf3412e1b0796b8dd4"];
    //往GameScore表添加一条playerName为小明，分数为78的数据
    
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
