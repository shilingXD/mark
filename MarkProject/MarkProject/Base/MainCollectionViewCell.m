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
