//
//  NSString+Util.m
//  IflysseEnterprisePush
//
//  Created by iflysse on 2017/11/8.
//  Copyright © 2017年 iflysse. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString (Util)

-(NSString *) trim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]] ;
}

-(NSString *) capitalizedFirst{
    return [NSString stringWithFormat:@"%@%@", [[self substringToIndex:1] capitalizedString], [self substringFromIndex:1] ] ;
}

+(Boolean) isEmptyOfString:(NSString *)str{
    return str == nil || [str isEqual:[NSNull null]] ||[[str trim] isEqualToString:@""] ;
}


-(CGSize) getSizeWithMaxSize:(CGSize)size andFont:(UIFont *)font{
      return  [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

-(CGFloat) getWidthInSize:(CGSize)size withFont:(UIFont *)font{
    return [self getSizeWithMaxSize:size andFont:font].width;

}
-(CGFloat) getWidthWithFont:(UIFont *)font{
    return [self getWidthInSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) withFont:font];
}

-(CGFloat) getHeightWithFont:(UIFont *)font{
    return [self getSizeWithMaxSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) andFont:font].height ;
}

@end
