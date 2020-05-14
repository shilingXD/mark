//
//  Instance.m
//  MarkProject
//
//  Created by 孙冬 on 2019/12/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "MDInstance.h"

@implementation MDInstance
+(MDInstance *)sharedInstance{
    static MDInstance *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance =[[self alloc]init];
    });
    return _sharedInstance;
}
+(void)setNSUserDefaults
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    MDInstance *instance = [MDInstance sharedInstance];
    [user setBool:instance.isLogin forKey:@"user_isLogin"];
    [user setObject:instance.Email forKey:@"user_email"];
    [user setObject:instance.DeviceID forKey:@"user_DeviceID"];
    [user setObject:instance.UserName forKey:@"user_UserName"];
    NSData *data = UIImageJPEGRepresentation(instance.headImage, 1);
    [user setObject:data forKey:@"user_headImage"];
    [user setObject:instance.themeColor.hexString forKey:@"user_themeColor"];
}
- (NSString *)Email
{
    if (!_Email) {
        _Email = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_email"];
    }
    return _Email;
}
- (BOOL)isLogin
{
    if (!_isLogin) {
        _isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"user_isLogin"];
    }
    return _isLogin;
}
- (NSString *)DeviceID
{
    if (!_DeviceID ){
        _DeviceID = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_DeviceID"];
    }
    return _DeviceID;
}
- (NSString *)UserName
{
    if (!_UserName ){
        _UserName = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_UserName"];
    }
    return _UserName;
}
- (UIImage *)headImage
{
    if (!_headImage) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_headImage"];
        _headImage = [UIImage imageWithData:data];
    }
    return _headImage;
}
- (UIColor *)themeColor
{
    
    if (!_themeColor) {
        _themeColor = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_themeColor"]?[UIColor colorWithHexString:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_themeColor"]]:TintColor;
    }
    return _themeColor;
}
@end
