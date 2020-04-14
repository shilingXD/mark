//
//  NSString+Util.h
//  IflysseEnterprisePush
//
//  Created by iflysse on 2017/11/8.
//  Copyright © 2017年 iflysse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Util)
//去除字符串两边的空格
-(NSString *) trim ;
-(NSString *) capitalizedFirst ;
//判断是否是空串 null 或者是empty
+(Boolean) isEmptyOfString:(NSString *) str ;

-(CGSize) getSizeWithMaxSize:(CGSize) size andFont:(UIFont *) font ;

-(CGFloat) getWidthInSize:(CGSize) size withFont:(UIFont *) font ;
//默认的maxSize宽度是ScreenWidth
-(CGFloat) getWidthWithFont:(UIFont *) font ;

//默认的maxSize宽度是ScreenWidth
-(CGFloat) getHeightWithFont:(UIFont *) font ;
@end
