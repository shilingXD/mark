
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XYString : NSObject

+ (instancetype)sharedInstance;

#pragma mark -  json转换
/**
 *  json转换
 */
+(id )getObjectFromJsonString:(NSString *)jsonString;
/**
 *  json转换
 */
+(NSString *)getJsonStringFromObject:(id)object;

#pragma mark -  NSDate互转NSString
/**
 *  比较时间与当前时间相比是否是昨天
 *
 *  @param date 传入比较的时间
 *
 *  @return YES是 NO否
 */
+ (BOOL)CompaireIsYesterdayWithYourDate:(NSDate *)date;
/**
 *  比较时间与当前时间相比是否是前天
 *
 *  @param date 传入比较的时间
 *
 *  @return YES是 NO否
 */
+ (BOOL)CompaireIsTheDayBeforeYesterdayWithYourDate:(NSDate *)date;

/**
 *  比较两个日期的先后
 *
 *  @param oneDay     第一个日期
 *  @param anotherDay 第二个日期
 *
 *  @return 1oneDay时间大 -1anotherDay时间大 0日期相同
 */
+(int)CompareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
/**
 *  判断时间与当前时间相比
 *
 *  @param date 传入要比较的时间
 *
 *  @return YES过期 NO没过期
 */
+ (BOOL)TimeIsOldOrNotForDate:(NSDate *)date;
/**
 *  比较两个日期的大小
 *
 *  @param firstDate  第一个日期
 *  @param secondTime 第二个日期
 *
 *  @return YES第一个日期大 NO第二个日期大
 */
+ (BOOL)CompireFromFirstTime:(NSDate *)firstDate toSecondTime:(NSDate *)secondTime;

/**
 从某日期开始增加月数
 
 @param monthCount 增加的月数
 @param fromDate 从某个日期开始
 @return 增加后的日期
 */
+ (NSDate *)addMonthCount:(NSInteger)monthCount fromDate:(NSDate *)fromDate;

/**
 *  NSDate互转NSString

 */
+(NSDate *)NSStringToDate:(NSString *)dateString;
/**
 *  NSDate互转NSString
 */
+(NSDate *)NSStringToDate:(NSString *)dateString withFormat:(NSString *)formatestr;
/**
 *  NSDate互转NSString
 */
+(NSString *)NSDateToString:(NSDate *)dateFromString withFormat:(NSString *)formatestr;
#pragma mark -  判断字符串是否为空,为空的话返回 某字符串 （一般用于保存字典时）
+(NSString *)IsNotNull:(id)string withString:(NSString *)placeString;

#pragma mark - 1,2,3转换一，二，三
/**
 1,2,3转换一，二，三
 */
+ (NSString *)NSNumberToString:(NSInteger)num;

#pragma mark -  判断字符串是否为空,为空的话返回 “” （一般用于保存字典时）
/**
 *  判断字符串是否为空,为空的话返回 “” （一般用于保存字典时）
 */
+(NSString *)IsNotNull:(NSString*)string;
/**
 *  判断字符串是否为空,为空的话返回 “” （一般用于保存字典时）
 */
+(BOOL) isBlankString:(id)string;


#pragma mark - 如何通过一个整型的变量来控制数值保留的小数点位数。以往我们通类似@"%.2f"来指定保留2位小数位，现在我想通过一个变量来控制保留的位数
/**
 *  如何通过一个整型的变量来控制数值保留的小数点位数。以往我们通类似@"%.2f"来指定保留2位小数位，现在我想通过一个变量来控制保留的位数
 */
+(NSString *)newFloat:(float)value withNumber:(int)numberOfPlace;


#pragma mark - 使用subString去除float后面无效的0
/**
 *  使用subString去除float后面无效的0
 */
+(NSString *)changeFloatWithString:(NSString *)stringFloat;

#pragma mark - 去除float后面无效的0
/**
 *  去除float后面无效的0
 */
+(NSString *)changeFloatWithFloat:(CGFloat)floatValue;


#pragma mark -  手机号码验证
/**
 *  手机号码验证
 */
+(BOOL) isValidateMobile:(NSString *)mobile;

#pragma mark -  阿里云压缩图片
/**
 *  阿里云压缩图片
 */
+(NSURL*)UrlWithStringForImage:(NSString*)string;
+(NSString*)removeYaSuoAttribute:(NSString*)string;

#pragma mark - 字符串类型判断
/**
 *  字符串类型判断
 */
+ (BOOL)isPureInt:(NSString*)string;
+ (BOOL)isPureFloat:(NSString*)string;

#pragma mark -  计算内容文本的高度方法
/**
 *  计算内容文本的高度方法
 */
+ (CGFloat)HeightForText:(NSString *)text withSizeOfLabelFont:(CGFloat)font withWidthOfContent:(CGFloat)contentWidth;

#pragma mark -  计算字符串长度
/**
 *  计算字符串长度
 */
+ (CGFloat)WidthForString:(NSString *)text withSizeOfFont:(CGFloat)font;

#pragma mark - 1,2,3转换每周几
/**
 1,2,3转换每周几
 */
+ (NSString *)dayNumToString:(NSString *)dayNum;

#pragma mark -  计算两个时间相差多少秒
/**
 *  计算两个时间相差多少秒
 */
+(NSInteger)getSecondsWithBeginDate:(NSString*)currentDateString  AndEndDate:(NSString*)tomDateString;

#pragma mark - 根据出生日期获取年龄
/**
 *  根据出生日期获取年龄
 */
+ (NSInteger)ageWithDateOfBirth:(NSDate *)date;

#pragma mark - 根据经纬度计算两个位置之间的距离
/**
 *  根据经纬度计算两个位置之间的距离
 */
+(double)distanceBetweenOrderBylat1:(double)lat1 lat2:(double)lat2 lng1:(double)lng1 lng2:(double)lng2;

#pragma mark - 今天 昨天 具体日期 yyyy-mm-dd hh：mm

+ (NSString *)formatDateForDayYMD:(NSString *)dateStr;

#pragma mark - 随机 字母和数字

/**
 随机 字母和数字

 @param num 位数
 */
+ (NSString *)getRandomStringWithNum:(NSInteger)num;

#pragma mark - 秒数转换为00：00：00

+ (NSString *)dealWithTotalTime:(NSString *)totalTime;

@end
