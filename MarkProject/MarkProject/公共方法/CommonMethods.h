
//  CommonMethods.h
//  MarkProject
//
//  Created by 孙冬 on 2019/12/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <ImageIO/ImageIO.h>
NS_ASSUME_NONNULL_BEGIN

@interface CommonMethods : NSObject
//+(CommonMethods *)sharedInstance;

/**
 获取设备os版本

 @return 获取设备os版本
 */
+(NSString *)getDeviceOSType;
/**
 获取app版本

 @return 获取app版本
 */
+(NSString *)GetAppVersion;
/**
 获取BundelID

 @return 获取BundelID
 */
+(NSString *)getBundelID;
/**
 设置label行间距

 @param label target label
 @param space 行间距
 @param font label字体
 */
+(void)setLabelSpace:(UILabel *)label withSpace:(CGFloat)space withFont:(UIFont*)font;
/**
 改变字体和颜色

 @param string target string
 @param font target font
 @param color target color
 @param targetString target string
 @return 已修改字符串
 */
+(NSMutableAttributedString *)ChangeNSMutabelAttributedString:(NSString *)string TargetFonts:(UIFont *)font TargetColors:(UIColor *)color AndTargetString:(NSString *)targetString;
/**
 改变字体或颜色

 @param string target string
 @param value target font/color
 @param targetString target string
 @return 已修改字符串
 */
+(NSMutableAttributedString *)ChangeNSMutabelAttributedString:(NSString *)string WithTargetValue:(id)value AndTargetString:(NSString *)targetString;
/**
 判断字符串是否为空

 @param string target string
 @return 为空返回“”n不为空返回原字符串
 */
+(NSString *)JudgeNULL:(id)string;
/**
 字符串转日期格式

 @param string target string
 @param formate 需要转换的日期格式（@"yyyy-MM-dd HH:mm:ss"）
 @return 日期
 */
+ (NSDate*)getNSDateByString:(NSString*)string formate:(NSString*)formate;

/**
 添加背景阴影

 @param view <#view description#>
 @param shadowOpacity <#shadowOpacity description#>
 @param shadowRadius <#shadowRadius description#>
 @param cornerRadius <#cornerRadius description#>
 @param color <#color description#>
 */
+ (void)addShadowToView:(UIView *)view
            withOpacity:(float)shadowOpacity
           shadowRadius:(CGFloat)shadowRadius
        andCornerRadius:(CGFloat)cornerRadius
            shadowColor:(UIColor *)color;
/**
 获取根视图

 @return 返回根视图
 */
+ (UIViewController *)getRootViewController;

/**
 获取当前所在视图

 @return 返回当前所在视图
 */
+ (UIViewController *)getCurrentViewController;
/**
 获取设备型号

 @return 返回设备型号
 */
+ (NSString*)getDeviceInfo;
/**
 验证手机号的合法性

 @param mobile 手机号字符串
 @return yes/no
 */
+ (BOOL) validateMobile:(NSString *)mobile;
/**
 验证邮箱的合法性

 @param email 邮箱
 @return yes/no
 */
+ (BOOL)isValidateEmail:(NSString *)email;
/**
 app跳转浏览器打开url

 @param strUrl <#strUrl description#>
 */
+(void)openUrl:(NSString *)strUrl;
@end

NS_ASSUME_NONNULL_END
