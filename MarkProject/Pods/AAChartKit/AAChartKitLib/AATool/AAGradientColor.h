//
//  AAGradientColor.h
//  AAChartKitDemo
//
//  Created by AnAn on 2018/11/18.
//  Copyright © 2018 Danny boy. All rights reserved.
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************

/*
 
 * -------------------------------------------------------------------------------
 *
 * 🌕 🌖 🌗 🌘  ❀❀❀   WARM TIPS!!!   ❀❀❀ 🌑 🌒 🌓 🌔
 *
 * Please contact me on GitHub,if there are any problems encountered in use.
 * GitHub Issues : https://github.com/AAChartModel/AAChartKit/issues
 * -------------------------------------------------------------------------------
 * And if you want to contribute for this project, please contact me as well
 * GitHub        : https://github.com/AAChartModel
 * StackOverflow : https://stackoverflow.com/users/7842508/codeforu
 * JianShu       : https://www.jianshu.com/u/f1e6753d4254
 * SegmentFault  : https://segmentfault.com/u/huanghunbieguan
 *
 * -------------------------------------------------------------------------------
 
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AALinearGradientDirection) {
    AALinearGradientDirectionToTop = 0,     //⇧⇧⇧⇧⇧⇧
    AALinearGradientDirectionToBottom,      //⇩⇩⇩⇩⇩⇩
    AALinearGradientDirectionToLeft,        //⇦⇦⇦⇦⇦⇦
    AALinearGradientDirectionToRight,       //⇨⇨⇨⇨⇨⇨
    AALinearGradientDirectionToTopLeft,     //⇖⇖⇖⇖⇖⇖
    AALinearGradientDirectionToTopRight,    //⇗⇗⇗⇗⇗⇗
    AALinearGradientDirectionToBottomLeft,  //⇙⇙⇙⇙⇙⇙
    AALinearGradientDirectionToBottomRight, //⇘⇘⇘⇘⇘⇘
};

@interface AAGradientColor : NSObject

+ (NSDictionary *)oceanBlueColor;
+ (NSDictionary *)sanguineColor;
+ (NSDictionary *)lusciousLimeColor;
+ (NSDictionary *)purpleLakeColor;
+ (NSDictionary *)freshPapayaColor;
+ (NSDictionary *)ultramarineColor;
+ (NSDictionary *)pinkSugarColor;
+ (NSDictionary *)lemonDrizzleColor;
+ (NSDictionary *)victoriaPurpleColor;
+ (NSDictionary *)springGreensColor;
+ (NSDictionary *)mysticMauveColor;
+ (NSDictionary *)reflexSilverColor;
+ (NSDictionary *)neonGlowColor;
+ (NSDictionary *)berrySmoothieColor;
+ (NSDictionary *)newLeafColor;
+ (NSDictionary *)cottonCandyColor;
+ (NSDictionary *)pixieDustColor;
+ (NSDictionary *)fizzyPeachColor;
+ (NSDictionary *)sweetDreamColor;
+ (NSDictionary *)firebrickColor;
+ (NSDictionary *)wroughtIronColor;
+ (NSDictionary *)deepSeaColor;
+ (NSDictionary *)coastalBreezeColor;
+ (NSDictionary *)eveningDelightColor;

+ (NSDictionary *)oceanBlueColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)sanguineColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)lusciousLimeColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)purpleLakeColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)freshPapayaColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)ultramarineColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)pinkSugarColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)lemonDrizzleColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)victoriaPurpleColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)springGreensColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)mysticMauveColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)reflexSilverColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)neonGlowColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)berrySmoothieColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)newLeafColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)cottonCandyColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)pixieDustColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)fizzyPeachColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)sweetDreamColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)firebrickColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)wroughtIronColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)deepSeaColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)coastalBreezeColorWithDirection:(AALinearGradientDirection)direction;
+ (NSDictionary *)eveningDelightColorWithDirection:(AALinearGradientDirection)direction;

+ (NSDictionary *)gradientColorWithStartColorString:(NSString *)startColorStr
                                     endColorString:(NSString *)endColorStr;
    
+ (NSDictionary *)gradientColorWithDirection:(AALinearGradientDirection)direction
                            startColorString:(NSString *)startColorStr
                              endColorString:(NSString *)endColorStr;

+ (NSDictionary *)gradientColorWithDirection:(AALinearGradientDirection)direction
                                  stopsArray:(NSArray *)stopsArray;

@end

NS_ASSUME_NONNULL_END


