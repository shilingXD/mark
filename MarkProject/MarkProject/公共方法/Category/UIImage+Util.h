//
//  UIImage+Util.h
//  IflysseEnterprisePush
//
//  Created by iflysse on 2017/12/14.
//  Copyright © 2017年 iflysse. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIImage (Util)
//用颜色创建图片
+(UIImage *) imageWithColor:(UIColor *) color ;
//模糊图片
- (UIImage *)blur:(CGFloat)blur ;

- (UIImage *) changeColor:(UIColor *) color ;
@end
