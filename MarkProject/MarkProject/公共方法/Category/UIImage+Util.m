//
//  UIImage+Util.m
//  IflysseEnterprisePush
//
//  Created by iflysse on 2017/12/14.
//  Copyright © 2017年 iflysse. All rights reserved.
//

#import "UIImage+Util.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (Util)
//模糊图片
- (UIImage *)blur:(CGFloat)blur {
    
    if (blur < 0.f || blur > 1.f) {
        
        blur = 0.5f;
        
    }
    
    int boxSize = (int)(blur * 100);
    
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    
    inBuffer.height = CGImageGetHeight(img);
    
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *   CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        
    //    NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    
    outBuffer.width = CGImageGetWidth(img);
    
    outBuffer.height = CGImageGetHeight(img);
    
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       
                                       &outBuffer,
                                       
                                       NULL,
                                       
                                       0,
                                       
                                       0,
                                       
                                       boxSize,
                                       
                                       boxSize,
                                       
                                       NULL,
                                       
                                       kvImageEdgeExtend);
    
    if (error) {
        
      //  NSLog(@"error from convolution %ld", error);
        
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(
                                             
                                             outBuffer.data,
                                             
                                             outBuffer.width,
                                             
                                             outBuffer.height,
                                             
                                             8,
                                             
                                             outBuffer.rowBytes,
                                             
                                             colorSpace,
                                             
                                             kCGImageAlphaNoneSkipLast);
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    
    CGContextRelease(ctx);
    
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    
    CGImageRelease(imageRef);
    
    return returnImage;
}

+(UIImage *) imageWithColor:(UIColor *)color{
    
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage * theImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
}

-(UIImage *) changeColor:(UIColor *) color{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
