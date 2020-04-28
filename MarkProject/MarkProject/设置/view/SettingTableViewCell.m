//
//  SettingTableViewCell.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/27.
//  Copyright © 2020 mac. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImage.layer.masksToBounds = YES;
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    self.titleLabel.textColor = rgba(12, 14, 40, 1);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.iconImage.mas_right).offset(7);
    }];
    [self.stateSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.right).offset(-10);
        make.centerY.mas_equalTo(self);
    }];
}
- (IBAction)StateSwitch:(UISwitch *)sender {
    self.SwitchBlock(sender.isOn);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
