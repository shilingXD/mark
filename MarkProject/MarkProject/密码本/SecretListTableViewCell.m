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
        _IconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"密码iocn-%d",[self getRandomNumber:1 to:3]]];
        NSLog(@"%@",[NSString stringWithFormat:@"密码iocn-%d",[self getRandomNumber:1 to:3]]);
        [self addSubview:_IconView];
        
        _iconText = [[UILabel alloc] init];
//        _iconText.text = @"密码";
        _iconText.font = [UIFont systemFontOfSize:12];
        _iconText.textColor = [UIColor whiteColor];
        [self.IconView addSubview:_iconText];
        
        _Title = [[UILabel alloc] init];
        _Title.font = [UIFont fontWithName:@"PingFang SC" size: 13];
//        _Title.textColor = rgba(97, 109, 128, 1);
        [self addSubview:_Title];
        
        _Account = [[UILabel alloc] init];
        _Account.font = [UIFont fontWithName:@"PingFang SC" size: 12];
        _Account.textColor = rgba(97, 109, 128, 1);
        [self addSubview:_Account];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor grayColor];
        _lineView.alpha = 0.5;
        [self addSubview:_lineView];
    }
    [self layoutIfNeeded];
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.IconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.centerY.mas_equalTo(self);
    }];
    [self.iconText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.IconView);
    }];
    [self.Title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.IconView.mas_right).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.top.mas_equalTo(self.IconView.mas_top);
    }];
    [self.Account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.IconView.mas_right).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.bottom.mas_equalTo(self.IconView.mas_bottom);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.Title.mas_left);
        make.right.mas_equalTo(self.mas_right).offset(-25);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}
//获取一个随机整数，范围在[from,to），包括from，不包括to
-(int)getRandomNumber:(int)from to:(int)to

{
    
    return (int)(from + (arc4random() % (to - from + 1))); //+1,result is [from to]; else is [from, to)!!!!!!!
    
}

- (void)setModel:(SecretModel *)model
{
    _model = model;
    
    _Title.text = model.Name;
    _iconText.text = model.Name.length >= 2?[model.Name substringToIndex:2]:model.Name;
    _Account.text = model.Account;
}
@end
