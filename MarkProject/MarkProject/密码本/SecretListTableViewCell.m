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
        _myContentView = [[UIView alloc] init];
        _myContentView.backgroundColor = RandomColor;
        _myContentView.layer.cornerRadius = 5;
        _myContentView.layer.masksToBounds = YES;
//        [MDMethods addBackGroundShadowToView:_myContentView withColor:rgba(68, 139, 255, 1)];
        [self addSubview:_myContentView];
        
      
    }
    [self layoutIfNeeded];
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.myContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
    }];
    
}


@end
