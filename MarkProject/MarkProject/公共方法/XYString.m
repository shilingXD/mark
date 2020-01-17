#import "XYString.h"

@implementation XYString

+ (instancetype)sharedInstance {
    
    static XYString *xystr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        xystr = [[self alloc]init];
    });
    return xystr;
    
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
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
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
    
    NSDate * currentDate = [XYString NSStringToDate:currentDateString withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSInteger currSec = [currentDate timeIntervalSince1970];
    
    NSDate *tomDate = [XYString NSStringToDate:tomDateString withFormat:@"yyyy-MM-dd HH:mm:ss"];
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
    
    if ([XYString isBlankString:dateStr]) {
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


@end
