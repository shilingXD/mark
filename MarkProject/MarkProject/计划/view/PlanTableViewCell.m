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

//- (void)setPlanTimeArray:(NSArray *)planTimeArray
//{
//////    NSOrderedSet *orderSet = [NSOrderedSet orderedSetWithArray:planTimeArray];
//////    self.planTimeArray = [orderSet array];
////    self.planTimeArray = planTimeArray;
////    if (planTimeArray.count>0) {
////        [self.calendarView mas_updateConstraints:^(MASConstraintMaker *make) {
////            make.height.mas_equalTo(50 * (self.planTimeArray.count - 1) + 50);
////        }];
////        for (int i = 0; i<self.planTimeArray.count; i++) {
////            NSArray *array = self.planTimeArray[i];
////            UIView * view = [[UIView alloc] initWithFrame:CGRectMake([self getpointWithTime:array[0]], 0, [self getpointWithTime:array[1]]-[self getpointWithTime:array[0]], 50)];
////            view.layer.cornerRadius  = 7;
////            view.backgroundColor = RandomColor;
////            [self addSubview:view];
////        }
////    }
//}
-(CGFloat)getpointWithTime:(id)time
{
     CGFloat minutesWidth = (SCREEN_WIDTH-60)/1440;
    
    return minutesWidth * [time floatValue];
}
@end
