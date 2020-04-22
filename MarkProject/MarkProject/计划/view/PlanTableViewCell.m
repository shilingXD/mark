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
        make.height.mas_equalTo(150);
    }];
    
}
- (void)getArray:(NSArray *)array
{
    CGFloat minutesWidth = (SCREEN_WIDTH-60)/1440;
    NSOrderedSet *orderSet = [NSOrderedSet orderedSetWithArray:array];
    array = [orderSet array];
    if (array.count>0) {
        [self.calendarView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50 * array.count );
        }];
        for (int i = 0; i<array.count; i++) {
            PlanModel *Daymodel = array[i];
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(60+(SCREEN_WIDTH-60)/48 + minutesWidth*Daymodel.PlanItemBeginDate, (50*i), minutesWidth*Daymodel.PlanItemEndDate-minutesWidth*Daymodel.PlanItemBeginDate, 50)];
            view.layer.cornerRadius  = 7;
            if (Daymodel.priority == 1) {
                view.backgroundColor = [UIColor hexStringToColor:@"3A87FB"];
            } else  if(Daymodel.priority == 2){
                view.backgroundColor = [UIColor orangeColor];
            } else {
                view.backgroundColor = [UIColor redColor];
            }
            [self addSubview:view];
            UILabel *title = [[UILabel alloc] initWithFrame:view.frame];
            title.numberOfLines = 2;
            title.text =[NSString stringWithFormat:@"%@\n%@ - %@", Daymodel.PlanTitle,[self dealWithTotalTime:Daymodel.PlanItemBeginDate],[self dealWithTotalTime:Daymodel.PlanItemEndDate]];
            title.textAlignment = NSTextAlignmentCenter;
            title.font = [UIFont fontWithName:@"PingFang SC" size:12];
            title.textColor = [UIColor whiteColor];
            [self addSubview:title];
        }
    }
}
- (NSString *)dealWithTotalTime:(int)totalTime {
    
    NSInteger totalSecond = totalTime * 60;
    
    NSInteger sec = totalSecond % 60;
    NSInteger min = (totalSecond - sec) / 60 % 60;
    NSInteger hour = (totalSecond - sec - 60*min) / 3600;
    
    NSString *hourStr = @"";
    NSString *minStr = @"";
    NSString *secStr = @"";
    
    
    if (hour < 10) {
        hourStr = [NSString stringWithFormat:@"0%ld",(long)hour];
    }else {
        hourStr = [NSString stringWithFormat:@"%ld",(long)hour];
    }
    
    if (min < 10) {
        minStr = [NSString stringWithFormat:@"0%ld",(long)min];
    }else {
        minStr = [NSString stringWithFormat:@"%ld",(long)min];
    }
    
    if (sec < 10) {
        secStr = [NSString stringWithFormat:@"0%ld",(long)sec];
    }else {
        secStr = [NSString stringWithFormat:@"%ld",(long)sec];
    }
    
    NSString *totalStr = [NSString stringWithFormat:@"%@:%@",hourStr,minStr];
    
    return totalStr;
    
}
@end
