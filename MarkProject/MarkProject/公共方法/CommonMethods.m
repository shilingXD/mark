//
//  CommonMethods.m
//  MarkProject
//
//  Created by 孙冬 on 2019/12/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CommonMethods.h"
#import <sys/utsname.h>

@implementation CommonMethods
//+(CommonMethods *)sharedInstance{
//    static CommonMethods *_sharedInstance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _sharedInstance =[[self alloc]init];
//    });
//    return _sharedInstance;
//}

+(NSString *)getDeviceOSType
{
    NSString *systemVersion =  [NSString stringWithFormat:@"%@",
                                [[UIDevice currentDevice] systemVersion]];
    
    
    return systemVersion;
}

//获取设备版本号
+(NSString *) GetAppVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    return [infoDic objectForKey:@"CFBundleShortVersionString"];
    
}

+(NSString *)getBundelID
{
    return [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleName"];
}
+(void)setLabelSpace:(UILabel*)label withSpace:(CGFloat)space withFont:(UIFont*)font
{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = space; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f
                          };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:label.text attributes:dic];
    label.attributedText = attributeStr;
}
+(NSMutableAttributedString *)ChangeNSMutabelAttributedString:(NSString *)string WithTargetValue:(id)value AndTargetString:(NSString *)targetString
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range1 = [[str string] rangeOfString:targetString];
    if ([value isKindOfClass:[UIColor class]]) {
        [str addAttribute:NSForegroundColorAttributeName value: value range:range1];
    }else{
        [str addAttribute:NSFontAttributeName value: value range:range1];
    }
    return str;
}
+(NSMutableAttributedString *)ChangeNSMutabelAttributedString:(NSString *)string TargetFonts:(UIFont *)font TargetColors:(UIColor *)color AndTargetString:(NSString *)targetString
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range1 = [[str string] rangeOfString:targetString];
    [str addAttribute:NSForegroundColorAttributeName value: color range:range1];
    [str addAttribute:NSFontAttributeName value: font range:range1];
    return str;
}
+(NSString *)JudgeNULL:(id)string
{
    if ([string isEqual:@"NULL"] ||
        [string isKindOfClass:[NSNull class]] ||
        [string isEqual:[NSNull null]] ||
        [string isEqual:NULL] ||
        [[string class] isSubclassOfClass:[NSNull class]] ||
        string == nil ||
        string == NULL ||
        [string isKindOfClass:[NSNull class]] ||
        [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0 ||
        [string isEqualToString:@"<null>"] ||
        [string isEqualToString:@"(null)"]) {
        return @"";
    } else {
        return string;
    }
}
+ (NSDate*)getNSDateByString:(NSString*)string formate:(NSString*)formate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:string];
    return date;
}
+ (void)addShadowToView:(UIView *)view
            withOpacity:(float)shadowOpacity
           shadowRadius:(CGFloat)shadowRadius
        andCornerRadius:(CGFloat)cornerRadius
            shadowColor:(UIColor *)color
{
    //////// shadow /////////
    CALayer *shadowLayer = [CALayer layer];
    shadowLayer.frame = view.frame;
    
    shadowLayer.shadowColor = color.CGColor;//shadowColor阴影颜色
    shadowLayer.shadowOffset = CGSizeMake(0, 0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    shadowLayer.shadowOpacity = shadowOpacity;//0.8;//阴影透明度，默认0
    shadowLayer.shadowRadius = shadowRadius;//8;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = shadowLayer.bounds.size.width;
    float height = shadowLayer.bounds.size.height;
    float x = shadowLayer.bounds.origin.x;
    float y = shadowLayer.bounds.origin.y;
    
    CGPoint topLeft      = shadowLayer.bounds.origin;
    CGPoint topRight     = CGPointMake(x + width, y);
    CGPoint bottomRight  = CGPointMake(x + width, y + height);
    CGPoint bottomLeft   = CGPointMake(x, y + height);
    
    CGFloat offset = -1.f;
    [path moveToPoint:CGPointMake(topLeft.x - offset, topLeft.y + cornerRadius)];
    
    [path addLineToPoint:CGPointMake(topLeft.x - offset, topLeft.y + cornerRadius)];
    [path addArcWithCenter:CGPointMake(topLeft.x + cornerRadius, topLeft.y + cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI endAngle:M_PI_2 * 3 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(topRight.x - cornerRadius, topRight.y - offset)];
    [path addArcWithCenter:CGPointMake(topRight.x - cornerRadius, topRight.y + cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI_2 * 3 endAngle:M_PI * 2 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(bottomRight.x + offset, bottomRight.y - cornerRadius)];
    [path addArcWithCenter:CGPointMake(bottomRight.x - cornerRadius, bottomRight.y - cornerRadius) radius:(cornerRadius + offset) startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(bottomLeft.x + cornerRadius, bottomLeft.y + offset)];
    [path addArcWithCenter:CGPointMake(bottomLeft.x + cornerRadius, bottomLeft.y - cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    
    //设置阴影路径
    shadowLayer.shadowPath = path.CGPath;
    
    //////// cornerRadius /////////
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
    view.layer.shouldRasterize = YES;
    view.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    [view.superview.layer insertSublayer:shadowLayer below:view.layer];
}
+ (UIViewController *)getRootViewController
{
    
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}
+ (UIViewController *)getCurrentViewController
{
    
    UIViewController* currentViewController = [self getRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                
                return currentViewController;
            } else {
                
                return currentViewController;
            }
        }
        
    }
    return currentViewController;
}
+ (NSString*)getDeviceInfo
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString*phoneType = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([phoneType  isEqualToString:@"iPhone1,1"])  return@"iPhone 2G";
    
    if([phoneType  isEqualToString:@"iPhone1,2"])  return@"iPhone 3G";
    
    if([phoneType  isEqualToString:@"iPhone2,1"])  return@"iPhone 3GS";
    
    if([phoneType  isEqualToString:@"iPhone3,1"])  return@"iPhone 4";
    
    if([phoneType  isEqualToString:@"iPhone3,2"])  return@"iPhone 4";
    
    if([phoneType  isEqualToString:@"iPhone3,3"])  return@"iPhone 4";
    
    if([phoneType  isEqualToString:@"iPhone4,1"])  return@"iPhone 4S";
    
    if([phoneType  isEqualToString:@"iPhone5,1"])  return@"iPhone 5";
    
    if([phoneType  isEqualToString:@"iPhone5,2"])  return@"iPhone 5";
    
    if([phoneType  isEqualToString:@"iPhone5,3"])  return@"iPhone 5c";
    
    if([phoneType  isEqualToString:@"iPhone5,4"])  return@"iPhone 5c";
    
    if([phoneType  isEqualToString:@"iPhone6,1"])  return@"iPhone 5s";
    
    if([phoneType  isEqualToString:@"iPhone6,2"])  return@"iPhone 5s";
    
    if([phoneType  isEqualToString:@"iPhone7,1"])  return@"iPhone 6 Plus";
    
    if([phoneType  isEqualToString:@"iPhone7,2"])  return@"iPhone 6";
    
    if([phoneType  isEqualToString:@"iPhone8,1"])  return@"iPhone 6s";
    
    if([phoneType  isEqualToString:@"iPhone8,2"])  return@"iPhone 6s Plus";
    
    if([phoneType  isEqualToString:@"iPhone8,4"])  return@"iPhone SE";
    
    if([phoneType  isEqualToString:@"iPhone9,1"])  return@"iPhone 7";
    
    if([phoneType  isEqualToString:@"iPhone9,2"])  return@"iPhone 7 Plus";
    
    if([phoneType  isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([phoneType  isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([phoneType  isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([phoneType  isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([phoneType  isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([phoneType  isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([phoneType  isEqualToString:@"iPhone11,8"]) return@"iPhone XR";
    
    if([phoneType  isEqualToString:@"iPhone11,2"]) return@"iPhone XS";
    
    if([phoneType  isEqualToString:@"iPhone11,4"]) return@"iPhone XS Max";
    
    if([phoneType  isEqualToString:@"iPhone11,6"]) return@"iPhone XS Max";
    if ([phoneType isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if ([phoneType isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if ([phoneType isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    return Safe(phoneType) ;
}

+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^[1][3-9]+\\d{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
+ (void)openUrl:(NSString *)strUrl
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strUrl] options:@{} completionHandler:nil];
}
@end
