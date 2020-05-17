//
//  DemoCell.m
//  CCFoldCellDemo
//
//  Created by eHome on 17/2/23.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import "MemoCell.h"

@implementation MemoCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.foregroundView.layer.cornerRadius = 5;
    self.foregroundView.layer.masksToBounds = YES;
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.mas_equalTo(self.foregroundView);
        make.width.mas_equalTo(88);
    }];
    
    [self.closeNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.leftView);
        make.top.mas_equalTo(self.mas_top).offset(10);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.leftView);
        make.bottom.mas_equalTo(self.foregroundView.mas_bottom).offset(-10);
    }];
    [self.DataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.leftView);
        make.left.right.mas_equalTo(self.leftView);
        make.top.mas_equalTo(self.timeLabel.mas_top).offset(-10);
    }];
    
    
    self.openView.backgroundColor = [UIColor whiteColor];
    self.openView.layer.cornerRadius = 5;
    self.openView.layer.masksToBounds = YES;
    [self.openTitlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.openView);
        make.height.mas_equalTo(40);
    }];
    [self .editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(self.openView);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    self.contentTextView.delegate = self;
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.openView.mas_left).offset(15);
        make.right.mas_equalTo(self.openView.mas_right).offset(-15);
        make.top.mas_equalTo(self.openTitlelabel.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.openView.mas_bottom);
    }];
    self.contentTextView.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNumber:(NSInteger)number
{
    self.closeNumberLabel.text = @(number + 1).stringValue;
}

- (NSTimeInterval)animationDurationWithItemIndex:(NSInteger)itemIndex animationType:(AnimationType)type
{
    NSArray<NSNumber *> *array = @[@(0.5f),@(.25f),@(.25f)];
    return array[itemIndex].doubleValue;
}
- (IBAction)editAction:(UIButton *)sender {
    UITableView *table = (UITableView *)self.superview;
    [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:([self.closeNumberLabel.text integerValue]-1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    if (self.callSelectRowBlock) {
        self.callSelectRowBlock([self.closeNumberLabel.text integerValue]-1);
    }
    self.contentTextView.userInteractionEnabled = !self.contentTextView.userInteractionEnabled;
    [sender setTitle:self.contentTextView.userInteractionEnabled?@"完成":@"编辑" forState:UIControlStateNormal];
    if (self.contentTextView.userInteractionEnabled) {
        [self.contentTextView becomeFirstResponder];
    }else{
        [self.contentTextView resignFirstResponder];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.callSelectRowBlock) {
        self.callSelectRowBlock([self.closeNumberLabel.text integerValue]-1);
    }
}
- (void)setModel:(MemoModel *)model
{
    _model = model;
    NSString *dateStr = [MDMethods getDateStringWithTimeStr:[NSString stringWithFormat:@"%zd",model.createdAt]];
    self.DataLabel.text = [MDMethods changeBillTimeDate:dateStr];
    NSDate *date = [MDMethods NSStringToDate:dateStr];
    self.timeLabel.text = (date.hour<=12)?[NSString stringWithFormat:@"%02zd:%02zd AM",date.hour,date.minute]:[NSString stringWithFormat:@"%02zd:%02zd PM",date.hour-12,date.minute];
    self.titleLabel.text = model.memoTitle;
    self.detailLabel.text = [NSString stringWithFormat:@"字数统计:%zd字",model.memoContent.length];
    
    self.openTitlelabel.text = model.memoTitle;
    self.contentTextView.text = model.memoContent;
    
    self.leftView.backgroundColor = [UIColor hexStringToColor:model.memoColorHex];
    self.openTitlelabel.backgroundColor = [UIColor hexStringToColor:model.memoColorHex];
    
}
@end
