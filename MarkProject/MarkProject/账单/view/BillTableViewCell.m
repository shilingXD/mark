//
//  BillTableViewCell.m
//  MarkProject
//
//  Created by 孙冬 on 2020/5/2.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BillTableViewCell.h"

@implementation BillTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.MyContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(60);
    }];
    
    
    self.tipImageView.backgroundColor = [UIColor redColor];
    self.tipImageView.layer.masksToBounds  = YES;
    self.tipImageView.layer.cornerRadius = 2.5;
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.MyContentView.mas_left).offset(15);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(5, 5));
    }];
    [self.detailNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tipImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(self);
    }];
    [self.detailNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.MyContentView.mas_right).offset(-15);
        make.centerY.mas_equalTo(self);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(BillModel *)model
{
    _model = model;
    self.tipImageView.backgroundColor = model.type == 1 ? rgba(53, 195, 126, 1) : rgba(255, 115, 115, 1);
    self.detailNumLabel.textColor = model.type == 1 ? rgba(53, 195, 126, 1) : rgba(255, 115, 115, 1);
    self.detailNameLabel.text = model.name;
    self.detailNumLabel.text = model.type == 1 ? [NSString stringWithFormat:@"¥ +%@",model.money]:[NSString stringWithFormat:@"¥ -%@",model.money];
}
@end
