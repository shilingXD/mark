//
//  TipTableViewCell.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import "TipTableViewCell.h"

@implementation TipTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dateLabel.numberOfLines = 2;
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.mas_left).offset(15);
    }];
    [self.tipimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.mas_left).offset(100);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.centerX.mas_equalTo(self.tipimageView);
        make.bottom.mas_equalTo(self.tipimageView.mas_top);
        make.width.mas_equalTo(1);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tipimageView.mas_bottom);
        make.centerX.mas_equalTo(self.tipimageView);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.mas_equalTo(1);
    }];
    self.titleView.layer.cornerRadius = 5;
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.tipimageView.mas_right).offset(50);
    }];
    self.titleLabel.text = @"笔记本";
    self.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:18];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.numberOfLines = 2;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleView.mas_left).offset(15);
        make.right.mas_equalTo(self.titleView.mas_right).offset(-15);
        make.centerY.mas_equalTo(self);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
