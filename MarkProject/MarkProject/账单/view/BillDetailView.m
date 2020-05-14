//
//  BillDetailView.m
//  MarkProject
//
//  Created by 孙冬 on 2020/5/13.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BillDetailView.h"

@implementation BillDetailView
+ (instancetype)init {
    BillDetailView *view = [BillDetailView loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    [view initUI];
    view.layer.cornerRadius = 5;
    return view;
}
- (void)initUI
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top).offset(10);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(30);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*0.4, (self.height-30)/3));
        make.left.mas_equalTo(self.mas_left);
    }];
    [self.categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*0.4, (self.height-30)/3));
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(self.moneyLabel.mas_bottom);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*0.4, (self.height-30)/3));
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(self.categoryLabel.mas_bottom);
    }];
    
    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(30);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*0.6, (self.height-30)/3));
        make.right.mas_equalTo(self.mas_right);
    }];
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*0.6, (self.height-30)/3));
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.moneyLabel.mas_bottom);
    }];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*0.6, (self.height-30)/3));
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.categoryLabel.mas_bottom);
    }];
    
//    self.line1.hidden = YES;
//    self.line2.hidden = YES;
//    self.line3.hidden = YES;
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.moneyLabel.mas_right);
        make.top.mas_equalTo(self.mas_top).offset(30);
        make.size.mas_equalTo(CGSizeMake(0.5, self.height-30));
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moneyLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.categoryLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
}
- (void)setModel:(BillModel *)model
{
    _model = model;
    self.moneyLabel.text = [NSString stringWithFormat:@"金额\n%@",model.money];
    self.categoryLabel.text = [NSString stringWithFormat:@"类别\n%@",model.name];
    self.timeLabel.text = [NSString stringWithFormat:@"创建时间\n%@",model.currentDateStr];
    self.markLabel.text = [model.mark isEqualToString:@""]?@"备注\n无":[NSString stringWithFormat:@"备注\n%@",model.mark];
}
@end
