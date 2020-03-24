//
//  SecretListTableViewCell.m
//  MarkProject
//
//  Created by 孙冬 on 2020/1/13.
//  Copyright © 2020 mac. All rights reserved.
//

#import "SecretListTableViewCell.h"

@implementation SecretListTableViewCell

+ (id)cellForTableview:(UITableView *)tableView
{
    static NSString *cellID = @"SecretListTableViewCell";
    SecretListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SecretListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self.backgroundColor = rgba(252, 252, 255, 1);
    self.contentView.backgroundColor = rgba(252, 252, 255, 1);
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _IconView = [[UIImageView alloc] init];
        _IconView.image = [self getImage:@"万物"];
        [self addSubview:_IconView];
        
      
    }
    [self layoutIfNeeded];
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.IconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(15);
//        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.mas_equalTo(self);
    }];
    
}

- (UIImage *)getImage:(NSString *)name
{
    UIColor *color = [self randomColor];  //获取随机颜色
    CGRect rect = CGRectMake(0.0f, 0.0f, 128, 128);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSString *headerName = nil;
    if (name.length < 3) {
        headerName = name;
    }else{
        headerName = [name substringFromIndex:name.length-2];
    }
    UIImage *headerimg = [self imageToAddText:img withText:headerName];
    return headerimg;
}

//随机颜色
- (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

//把文字绘制到图片上
- (UIImage *)imageToAddText:(UIImage *)img withText:(NSString *)text
{
    //1.获取上下文
    UIGraphicsBeginImageContext(img.size);
    //2.绘制图片
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    //3.绘制文字
    CGRect rect = CGRectMake(0,(img.size.height-45)/2, img.size.width, 25);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    //文字的属性
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:30],NSParagraphStyleAttributeName:style,NSForegroundColorAttributeName:[UIColor whiteColor]};
    //将文字绘制上去
    [text drawInRect:rect withAttributes:dic];
    //4.获取绘制到得图片
    UIImage *watermarkImg = UIGraphicsGetImageFromCurrentImageContext();
    //5.结束图片的绘制
    UIGraphicsEndImageContext();
    
    return watermarkImg;
}

@end
