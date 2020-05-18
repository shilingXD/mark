//
//  CommonMethods.m
//  MarkProject
//
//  Created by 孙冬 on 2019/12/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "MDMethods.h"
#import <sys/utsname.h>
#import "KeyChainStore.h"
#import <AdSupport/AdSupport.h>
#import "NSDate+gyh.h"
#import "NSString+Util.h"

@implementation MDMethods
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
/**  获取UUID*/
+ (NSString *)getUUIDByKeyChain{
    // 这个key的前缀最好是你的BundleID
    NSString*strUUID = (NSString*)[KeyChainStore load:@"com.shilingXD.MarkProject.UUID"];
    //首次执行该方法时，uuid为空
    if([strUUID isEqualToString:@""]|| !strUUID)
    {
        // 获取UUID 这个是要引入<AdSupport/AdSupport.h>的
        strUUID = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        
        if(strUUID.length ==0 || [strUUID isEqualToString:@"00000000-0000-0000-0000-000000000000"])
        {
            //生成一个uuid的方法
            CFUUIDRef uuidRef= CFUUIDCreate(kCFAllocatorDefault);
            strUUID = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault,uuidRef));
            CFRelease(uuidRef);
        }
        
        //将该uuid保存到keychain
        [KeyChainStore save:@"com.shilingXD.MarkProject.UUID" data:strUUID];
    }
    return strUUID;
}
+ (NSString *)setStringByKeyChainWithString:(NSString *)str{
//    // 这个key的前缀最好是你的BundleID
//    NSString*strUUID = (NSString*)[KeyChainStore load:@"com.shilingXD.MarkProject.UUID"];
//    //首次执行该方法时，uuid为空
//    if([strUUID isEqualToString:@""]|| !strUUID)
//    {
//        // 获取UUID 这个是要引入<AdSupport/AdSupport.h>的
//        strUUID = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//
//        if(strUUID.length ==0 || [strUUID isEqualToString:@"00000000-0000-0000-0000-000000000000"])
//        {
//            //生成一个uuid的方法
//            CFUUIDRef uuidRef= CFUUIDCreate(kCFAllocatorDefault);
//            strUUID = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault,uuidRef));
//            CFRelease(uuidRef);
//        }
//
//        //将该uuid保存到keychain
//        [KeyChainStore save:@"com.shilingXD.MarkProject.UUID" data:strUUID];
//    }
    return [NSString string];
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

#pragma mark -  json转换
+(id )getObjectFromJsonString:(NSString *)jsonString
{
    NSError *error = nil;
    if (jsonString) {
        id rev=[NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUnicodeStringEncoding] options:NSJSONReadingMutableLeaves error:&error];
        if (error==nil) {
            return rev;
        }
        else
        {
            return nil;
        }
    }
    return nil;
}

+(NSString *)getJsonStringFromObject:(id)object
{
    if ([NSJSONSerialization isValidJSONObject:object])
        
    {
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
        
        
        
        return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    return nil;
}

#pragma mark -  NSDate互转NSString
+(NSDate *)NSStringToDate:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:dateString];
    return dateFromString;
}

+(NSDate *)NSStringToDate:(NSString *)dateString withFormat:(NSString *)formatestr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatestr];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:dateString];
    return dateFromString;
}

+(NSString *)NSDateToString:(NSDate *)dateFromString withFormat:(NSString *)formatestr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatestr];
    NSString *strDate = [dateFormatter stringFromDate:dateFromString];
    return strDate;
}

+(int)CompareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}

+ (BOOL)TimeIsOldOrNotForDate:(NSDate *)date {
    
    NSDate *firstDate = [NSDate date];
    
    NSTimeInterval _fitstDate = [firstDate timeIntervalSince1970]*1;
    
    NSDate *secondDate = date;
    
    NSTimeInterval _secondDate = [secondDate timeIntervalSince1970]*1;
    
    if (_fitstDate - _secondDate > 0) {
        //第一个时间大
        return YES;
    }else {
        return NO;
    }
    
}
+ (BOOL)CompireFromFirstTime:(NSDate *)firstDate toSecondTime:(NSDate *)secondTime {
    
    
    NSTimeInterval _fitstDate  = [firstDate timeIntervalSince1970]*1;
    
    NSTimeInterval _secondDate = [secondTime timeIntervalSince1970]*1;
    
    if (_fitstDate - _secondDate > 0) {
        
        //第一个时间大
        return YES;
    }
    return NO;
    
}

/**
 从某日期开始增加月数
 
 @param monthCount 增加的月数
 @param fromDate 从某个日期开始
 @return 增加后的日期
 */
+ (NSDate *)addMonthCount:(NSInteger)monthCount fromDate:(NSDate *)fromDate {
    
    NSCalendar *calender2 = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [calender2 setFirstWeekday:2];// 国外是从周日 开始算的 我们是周一 所以 写了2
    
    NSDateComponents *components2 = nil;
    
    components2 = [calender2 components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:fromDate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc]init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:+monthCount];
    
    [adcomps setDay:0];
    
    NSDate *newdate = [calender2 dateByAddingComponents:adcomps toDate:fromDate options:0];
    
    NSLog(@"newdate =%@",newdate);
    
    return newdate;
}

+ (BOOL)CompaireIsYesterdayWithYourDate:(NSDate *)date {
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *yearsterDay =  [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay];
    //假设这是你要比较的date：NSDate *yourDate = ……
    //日历
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:yearsterDay];
    
    if ( comp1.year == comp2.year && comp1.month == comp2.month && comp1.day == comp2.day) {
        NSLog(@"昨天");
        return YES;
    }
    return NO;
}
+ (BOOL)CompaireIsTheDayBeforeYesterdayWithYourDate:(NSDate *)date {
    NSTimeInterval secondsPerDay = 24 * 60 * 60 * 2;
    NSDate *yearsterDay =  [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay];
    //假设这是你要比较的date：NSDate *yourDate = ……
    //日历
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:yearsterDay];
    
    if ( comp1.year == comp2.year && comp1.month == comp2.month && comp1.day == comp2.day) {
        NSLog(@"前天");
        return YES;
    }
    return NO;
}

#pragma mark -  判断字符串是否为空,为空的话返回 某字符串 （一般用于保存字典时）
+(NSString *)IsNotNull:(id)string withString:(NSString *)placeString {
    
    if (![string isKindOfClass:[NSString class]]) {
        
        if (![placeString isKindOfClass:[NSString class]]) {
            return @"";
        }else {
            if ([self isBlankString:placeString]) {
                return @"";
            }else {
                return placeString;
            }
        }
        
    }else {
        
        if ([self isBlankString:string]){
            
            if ([self isBlankString:placeString]) {
                return @"";
            }else {
                return placeString;
            }
            
        }else {
            
            return string;
        }
    }
    
}

#pragma mark -  判断字符串是否为空,为空的话返回 “” （一般用于保存字典时）
+(NSString *)IsNotNull:(id)string {
    
    //    if (![string isKindOfClass:[NSString class]]) {
    //        return @"";
    //    }
    
    NSString * str = [NSString stringWithFormat:@"%@",string];
    
    if ([self isBlankString:str]){
        string = @"";
    }
    
    return string;
    
}

//..判断字符串是否为空字符的方法
+(BOOL) isBlankString:(id)string {
    
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    NSString * str = (NSString*)string;
    if((NSNull *)str == [NSNull null])
    {
        return YES;
    }
    if (str == nil || str == NULL) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([str isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([str isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    if (str.length <= 0) {
        return YES;
    }
    
    return NO;
}

#pragma mark - 日期1,2,3转换一，二，三
+ (NSString *)NSNumberToString:(NSInteger)num {
    
    NSString *string = @"";
    switch (num) {
        case 1:
        {
            string = @"一";
        }
            break;
        case 2:
        {
            string = @"二";
        }
            break;
        case 3:
        {
            string = @"三";
        }
            break;
        case 4:
        {
            string = @"四";
        }
            break;
        case 5:
        {
            string = @"五";
        }
            break;
        case 6:
        {
            string = @"六";
        }
            break;
        case 7:
        {
            string = @"日";
        }
            break;
        default:
            break;
    }
    
    return string;
}

#pragma mark - 日期1,2,3转换一，二，三
+ (NSString *)numToString:(NSInteger)num {
    
    NSString *string = @"";
    switch (num) {
        case 1:
        {
            string = @"周一";
        }
            break;
        case 2:
        {
            string = @"周二";
        }
            break;
        case 3:
        {
            string = @"周三";
        }
            break;
        case 4:
        {
            string = @"周四";
        }
            break;
        case 5:
        {
            string = @"周五";
        }
            break;
        case 6:
        {
            string = @"周六";
        }
            break;
        case 7:
        {
            string = @"周日";
        }
            break;
        default:
            break;
    }
    
    return string;
}

#pragma mark - 1,2,3转换每周几
+ (NSString *)dayNumToString:(NSString *)dayNum {
    
    NSArray *temArr = [dayNum componentsSeparatedByString:@","];
    
    NSInteger count = 0;
    
    for (int i = 0; i < temArr.count; i++) {
        
        if ([temArr[i] integerValue] != 0) {
            count = count + 1;
        }
        
    }
    
    if (count == 0) {
        return @"";
    }else if (count == 7) {
        return @"每天";
    }else {
        
        if ([dayNum isEqualToString:@"1,2"] || [dayNum isEqualToString:@"1,2,3"]|| [dayNum isEqualToString:@"1,2,3,4"]|| [dayNum isEqualToString:@"1,2,3,4,5"]|| [dayNum isEqualToString:@"1,2,3,4,5,6"]|| [dayNum isEqualToString:@"2,3"]|| [dayNum isEqualToString:@"2,3,4"]|| [dayNum isEqualToString:@"2,3,4,5"]|| [dayNum isEqualToString:@"2,3,4,5,6"]|| [dayNum isEqualToString:@"2,3,4,5,6,7"]|| [dayNum isEqualToString:@"3,4"]|| [dayNum isEqualToString:@"3,4,5"]|| [dayNum isEqualToString:@"3,4,5,6"] || [dayNum isEqualToString:@"3,4,5,6,7"] || [dayNum isEqualToString:@"4,5"] || [dayNum isEqualToString:@"4,5,6"] || [dayNum isEqualToString:@"4,5,6,7"] || [dayNum isEqualToString:@"5,6"] || [dayNum isEqualToString:@"5,6,7"] || [dayNum isEqualToString:@"6,7"]) {
            
            NSArray *array = [dayNum componentsSeparatedByString:@","];
            
            NSString *firstString = @"";
            NSString *secondString = @"";
            
            firstString = [self numToString:[array.firstObject integerValue]];
            secondString = [self numToString:[array.lastObject integerValue]];
            
            NSString *temString = [NSString stringWithFormat:@"每%@至%@",firstString,secondString];
            return temString;
            
        }else {
            
            NSArray *array = [dayNum componentsSeparatedByString:@","];
            
            NSString *selectString = @"";
            for (NSString *numString in array) {
                
                if (numString.integerValue != 0) {
                    selectString = [selectString stringByAppendingString:[NSString stringWithFormat:@"%@、",[self numToString:numString.integerValue]]];
                }
                
            }
            selectString = [NSString stringWithFormat:@"每%@",selectString];
            selectString = [selectString substringToIndex:selectString.length - 1];
            
            return selectString;
        }
        
    }
    
}

#pragma mark - 使用subString去除float后面无效的0
+(NSString *)changeFloatWithString:(NSString *)stringFloat

{
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    NSInteger i = length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0') {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}

#pragma mark - 去除float后面无效的0
+(NSString *)changeFloatWithFloat:(CGFloat)floatValue

{
    return [self changeFloatWithString:[NSString stringWithFormat:@"%f",floatValue]];
}

#pragma mark - 如何通过一个整型的变量来控制数值保留的小数点位数。以往我们通类似@"%.2f"来指定保留2位小数位，现在我想通过一个变量来控制保留的位数
+(NSString *)newFloat:(float)value withNumber:(int)numberOfPlace
{
    NSString *formatStr = @"%0.";
    formatStr = [formatStr stringByAppendingFormat:@"%df", numberOfPlace];
    NSLog(@"____%@",formatStr);
    
    formatStr = [NSString stringWithFormat:formatStr, value];
    NSLog(@"____%@",formatStr);
    
    printf("formatStr %s\n", [formatStr UTF8String]);
    return formatStr;
}


#pragma mark -  手机号码验证
+(BOOL) isValidateMobile:(NSString *)mobile
{
    /*
     //手机号以13， 15，18开头，八个 \d 数字字符
     NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
     NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
     return [phoneTest evaluateWithObject:mobile];
     */
    
    NSPredicate* phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"1[34578]([0-9]){9}"];
    
    return [phoneTest evaluateWithObject:mobile];
    
}

#pragma mark -  阿里云压缩图片
+(NSURL*)UrlWithStringForImage:(NSString*)string{
    NSString * str = [NSString stringWithFormat:@"%@@800w_600h_10Q.jpg",string];
    NSLog(@"加载图片地址=%@",str);
    return [NSURL URLWithString:str];
}

//..去掉压缩属性“@800w_600h_10Q.jpg”
+(NSString*)removeYaSuoAttribute:(NSString*)string{
    NSString * str = @"";
    if ([string rangeOfString:@"@"].location != NSNotFound) {
        NSArray * arry = [string componentsSeparatedByString:@"@"];
        str = arry[0];
    }
    return str;
}

#pragma mark - 字符串类型判断
//..判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}


#pragma mark -  计算内容文本的高度方法
+ (CGFloat)HeightForText:(NSString *)text withSizeOfLabelFont:(CGFloat)font withWidthOfContent:(CGFloat)contentWidth
{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGSize size = CGSizeMake(contentWidth, 2000);
    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size.height;
}

#pragma mark -  计算字符串长度
+ (CGFloat)WidthForString:(NSString *)text withSizeOfFont:(CGFloat)font
{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGSize size = [text sizeWithAttributes:dict];
    return size.width;
}



#pragma mark -  计算两个时间相差多少秒

+(NSInteger)getSecondsWithBeginDate:(NSString*)currentDateString  AndEndDate:(NSString*)tomDateString{
    
    NSDate * currentDate = [MDMethods NSStringToDate:currentDateString withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSInteger currSec = [currentDate timeIntervalSince1970];
    
    NSDate *tomDate = [MDMethods NSStringToDate:tomDateString withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSInteger tomSec = [tomDate timeIntervalSince1970];
    
    NSInteger newSec = tomSec - currSec;
    NSLog(@"相差秒：%ld",(long)newSec);
    return newSec;
}


#pragma mark - 根据出生日期获取年龄
+ (NSInteger)ageWithDateOfBirth:(NSDate *)date;
{
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    return iAge;
}


#pragma mark - 根据经纬度计算两个位置之间的距离
+(double)distanceBetweenOrderBylat1:(double)lat1 lat2:(double)lat2 lng1:(double)lng1 lng2:(double)lng2{
    double dd = M_PI/180;
    double x1=lat1*dd,x2=lat2*dd;
    double y1=lng1*dd,y2=lng2*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    //返回km
    return  distance/1000;
    
    //返回m
    //return   distance;
    
}

#pragma mark - 今天 昨天 具体日期 yyyy-mm-dd hh：mm

+ (NSString *)formatDateForDayYMD:(NSString *)dateStr {
    
    if ([MDMethods isBlankString:dateStr]) {
        return @"";
    }
    
    if (dateStr.length > 19) {
        dateStr = [dateStr substringToIndex:19];
    }
    
    NSDate * reference = [self NSStringToDate:dateStr withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    float different = [reference timeIntervalSinceDate:[NSDate date]];
    if (different < 0) {
        different = -different;
    }
    // days = different / (24 * 60 * 60), take the floor value
    float dayDifferent = floor(different / 86400);
    
    int days = (int)dayDifferent;
    
    // It belongs to today
    if (dayDifferent <= 0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString * need_yMd = [dateFormatter stringFromDate:reference];
        NSString *now_yMd = [dateFormatter stringFromDate:[NSDate date]];
        
        if ([need_yMd isEqualToString:now_yMd]) {
            //在同一天
            return [NSString stringWithFormat:@"今天"];
        }else{
            //昨天
            return [NSString stringWithFormat:@"昨天"];
        }
        
    } else if (days ==1) {
        return @"昨天";
    } else {
        return [self NSDateToString:reference withFormat:@"yyyy-MM-dd HH:mm"];
    }
    return @"";
}

#pragma mark - 随机 字母和数字

+ (NSString *)getRandomStringWithNum:(NSInteger)num {
    
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < num; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
    
}

#pragma mark - 秒数转换为00：00：00

+ (NSString *)dealWithTotalTime:(NSString *)totalTime {
    
    NSInteger totalSecond = [totalTime integerValue];
    
    NSInteger sec = totalSecond % 60;
    NSInteger min = (totalSecond - sec) / 60 % 60;
    NSInteger hour = (totalSecond - sec - 60*min) / 3600;
    
    NSString *hourStr = @"";
    NSString *minStr = @"";
    NSString *secStr = @"";
    
    
    if (hour < 10) {
        hourStr = [NSString stringWithFormat:@"0%ld",(long)hour];
    }else {
        hourStr = [NSString stringWithFormat:@"%ld",(long)hour];
    }
    
    if (min < 10) {
        minStr = [NSString stringWithFormat:@"0%ld",(long)min];
    }else {
        minStr = [NSString stringWithFormat:@"%ld",(long)min];
    }
    
    if (sec < 10) {
        secStr = [NSString stringWithFormat:@"0%ld",(long)sec];
    }else {
        secStr = [NSString stringWithFormat:@"%ld",(long)sec];
    }
    
    NSString *totalStr = [NSString stringWithFormat:@"%@:%@:%@",hourStr,minStr,secStr];
    
    return totalStr;
    
}
+ (FMDatabase *)openOrCreateDBWithDBName:(NSString *)Name Success:(void (^)(void))success Fail:(void (^)(void))fail
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [docPath stringByAppendingPathComponent:Name];
    NSLog(@"path = %@",path);
    // 1..创建数据库对象
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    // 2.打开数据库
    if ([db open]) {
        // do something
        success();
        NSLog(@"Open database Success");
    } else {
        fail();
        NSLog(@"fail to open database");
    }
    return db;
}
///获取当前时间
+ (NSString *)currentDateStr{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSString *dateString = [dateFormatter stringFromDate:currentDate];//将时间转化成字符串
    return dateString;
}
///获取当前时间戳
+ (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}
/// 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
+ (NSString *)getDateStringWithTimeStr:(NSString *)str{
    NSTimeInterval time=[str doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}
///字符串转时间戳 如：2017-4-10 17:15:10
+ (NSString *)getTimeStrWithString:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]*1000];//字符串转成时间戳,精确到毫秒*1000
    return timeStr;
}
+(NSString *)changeTimeDate:(NSString *)getTime {
    
    if(![NSString isEmptyOfString:getTime]){
        //获取后台穿过来的事件
        NSDate * dateTime = [MDMethods getNSDateByString:getTime formate:@"yyyy-MM-dd HH:mm:ss"];
        if(dateTime==nil){
            dateTime = [MDMethods getNSDateByString:getTime formate:@"yyyy年MM月dd日 HH:mm"];
        }
        
        if (dateTime.isThisYear) {
            return [MDMethods getDateStringByFormateString:@"MM月dd日 HH:mm" date:dateTime] ;
        } else { // 非今年
            return  [MDMethods getDateStringByFormateString:@"yyyy年MM月dd日 HH:mm" date:dateTime] ;
        }
    }else{
        return @"" ;
    }
}
//改变账单的时间格式
+(NSString *)changeBillTimeDate:(NSString *)getTime {
    
    if(![NSString isEmptyOfString:getTime]){
        //获取后台穿过来的事件
        NSDate * dateTime = [MDMethods getNSDateByString:getTime formate:@"yyyy-MM-dd HH:mm:ss"];
        if(dateTime==nil){
            dateTime = [MDMethods getNSDateByString:getTime formate:@"yyyy-MM-dd"];
        }
        NSString *weekDayStr;
        switch(dateTime.weekday) {
            case 1:
                weekDayStr =@"周日";
                break;
            case 2:
                weekDayStr =@"周一";
                break;
            case 3:
                weekDayStr =@"周二";
                break;
            case 4:
                weekDayStr =@"周三";
                break;
            case 5:
                weekDayStr =@"周四";
                break;
            case 6:
                weekDayStr =@"周五";
                break;
            case 7:
                weekDayStr =@"周六";
                break;
            default:
                weekDayStr =@"";
                break;
        }
        if (dateTime.isThisYear) {
            if (dateTime.isToday) {
                return [MDMethods getDateStringByFormateString:@"MM月dd日 今天" date:dateTime];
            } else if (dateTime.isYesterday) {
                return [MDMethods getDateStringByFormateString:@"MM月dd日 昨天" date:dateTime];
            } else if (dateTime.isDayBeforeYesterday) {
                return [MDMethods getDateStringByFormateString:@"MM月dd日 前天" date:dateTime];
            } else {
                return [[MDMethods getDateStringByFormateString:@"MM月dd日 " date:dateTime] stringByAppendingString:weekDayStr];
            }
        } else { // 非今年
            return  [[MDMethods getDateStringByFormateString:@"yyyy年MM月dd日 " date:dateTime] stringByAppendingString:weekDayStr] ;
        }
    }else{
        return @"" ;
    }
}
+ (NSString*)getDateStringByFormateString:(NSString*)formateString date:(NSDate*)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formateString];
    NSString *strDate = [formatter stringFromDate:date];
    return strDate;
}

#pragma mark  - ------  Toast相关  ------
+ (void)showTextMessage:(NSString *)message
{
    UIView *messageView = [[UIView alloc] init];
    messageView.backgroundColor = [UIColor clearColor];
    messageView.gk_size = CGSizeMake(SCREEN_WIDTH,NavigationBar_Height + 30);
    CGFloat width1=[message boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:15]} context:nil].size.width;
    UILabel *msglabel = [[UILabel alloc] init];
    msglabel.text = message;
    msglabel.textAlignment = NSTextAlignmentCenter;
    msglabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    msglabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    msglabel.layer.cornerRadius = 3;
    msglabel.layer.masksToBounds = YES;
    msglabel.textColor = [UIColor whiteColor];
    
    [messageView addSubview:msglabel];
    [msglabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(messageView.mas_bottom);
        make.centerX.mas_equalTo(messageView);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(width1 + 20);
    }];
    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:messageView style:GKCoverStyleTransparent showStyle:GKCoverShowStyleTop showAnimStyle:GKCoverShowAnimStyleTop hideAnimStyle:GKCoverHideAnimStyleTop notClick:YES];
    [GKCover hideCoverAfterDelay:1];
}
// 64base字符串转图片

+ (UIImage *)stringToImage:(NSString *)str {
    if ([NSString isEmptyOfString:str]) {
        return [UIImage imageWithColor:[UIColor clearColor]];
    }
    NSData * imageData =[[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *photo = [UIImage imageWithData:imageData ];
    
    return photo;
    
}

// 图片转64base字符串

+ (NSString *)imageToString:(UIImage *)image {
    
    NSData *imagedata = UIImagePNGRepresentation(image);
    
    NSString *image64 = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return image64;
    
}
/**
 *  清除所有的存储本地的数据
 */
+ (void)clearAllUserDefaultsData
{
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    
}
+(void)showAlertWithTitle:(NSString *)title SureTitle:(NSString *)sureTitle SureBlock:(void(^)(void))sureBlock CancelTitle:(NSString *)cancelTitle CancelBlock:(void(^)(void))cancelBlock
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:title preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancelBlock();
    }];
    //    action1
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sureBlock();
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [[MDMethods getCurrentViewController] presentViewController:alert animated:YES completion:^{
        
    }];
}

@end
