//
//  PlanTableViewCell.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "PlanTableViewCell.h"
@implementation PlanTableViewCell

+ (id)cellForTableview:(UITableView *)tableView
{
    static NSString *cellID = @"PlanTableViewCell";
    PlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PlanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
     if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         _daylabel = [[UILabel alloc] init];
         _daylabel.text = @"5日";
         _daylabel.textAlignment = NSTextAlignmentCenter;
         _daylabel.font = [UIFont fontWithName:@"PingFangSC-Thin" size: 14];
         _daylabel.textColor = [UIColor whiteColor];
         [self addSubview:_daylabel];
         
         _calendarView = [[UIView alloc] init];
         _calendarView.backgroundColor = [UIColor lightTextColor];
         [self addSubview:_calendarView];
     }
    [self layoutIfNeeded];
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.daylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(60);
    }];
    [self.calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.left.mas_equalTo(self.daylabel.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(200);
    }];

}

- (void)setModel:(PlanModel *)model
{
    CGFloat hourwidth = (SCREEN_WIDTH-60)/24;//小时宽度
    CGFloat minwidth = hourwidth/60;//分钟宽度
    
    for (int i = 0; i<model.array.count; i++) {
        NSArray *array = model.array[i];
        
        int begin ;
        int end;
        UIView *task = [[UIView alloc] init];
    }
}
//字符串转时间戳 如：2017-4-10 17:15:10
- (NSString *)getTimeStrWithString:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]*100];//字符串转成时间戳,精确到毫秒*1000
    return timeStr;
}
@end
