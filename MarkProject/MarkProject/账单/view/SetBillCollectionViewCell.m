//
//  SetBillCollectionViewCell.m
//  MarkProject
//
//  Created by 孙冬 on 2020/5/6.
//  Copyright © 2020 mac. All rights reserved.
//

#import "SetBillCollectionViewCell.h"

@implementation SetBillCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tipImageView.layer.cornerRadius = (SCREEN_WIDTH/8)/2;
    self.tipImageView.layer.masksToBounds = YES;
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/8, SCREEN_WIDTH/8));
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.centerX.mas_equalTo(self);
    }];
    [self.tiplabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.tipImageView.mas_bottom).offset(10);
    }];
}

@end
