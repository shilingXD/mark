//
//  MainCollectionViewCell.m
//  MarkProject
//
//  Created by 孙冬 on 2019/12/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "MainCollectionViewCell.h"

@implementation MainCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//        gradientLayer.colors = @[(__bridge id)RandomColor.CGColor, (__bridge id)RandomColor.CGColor];
//        gradientLayer.locations = @[@0.0, @0.5];
//        gradientLayer.startPoint = CGPointMake(0, 0);
//        gradientLayer.endPoint = CGPointMake(1.0, 0);
//        gradientLayer.frame = self.frame;
//        [self.layer addSublayer:gradientLayer];
        self.backgroundColor = RandomColor;
        self.layer.cornerRadius = 10;
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:17];
        _titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
    }
    return self;
}
@end
