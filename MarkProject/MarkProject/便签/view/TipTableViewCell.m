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
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH*0.5);
    }];
    UILabel *title = [[UILabel alloc] init];
    title.center = self.titleView.center;
    title.text = @"笔记本";
    title.font = [UIFont fontWithName:@"PingFang SC" size:20];
    title.textColor = [UIColor blackColor];
    [self.titleView addSubview:title];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
