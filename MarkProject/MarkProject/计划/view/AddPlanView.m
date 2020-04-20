//
//  AddPlanView.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "AddPlanView.h"
#import "PlanViewController.h"

@implementation AddPlanView
+ (instancetype)init {
    AddPlanView *view = [AddPlanView loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH-50, 470)];
    [view initUI];
    return view;
}
- (void)initUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    
    self.calenderView =[[LXCalendarView alloc] initWithFrame:CGRectMake(10, 0, self.width - 20, 0)];
    
    self.calenderView.currentMonthTitleColor =[UIColor hexStringToColor:@"2c2c2c"];
    self.calenderView.lastMonthTitleColor =[UIColor hexStringToColor:@"8a8a8a"];
    self.calenderView.nextMonthTitleColor =[UIColor hexStringToColor:@"8a8a8a"];
    
    self.calenderView.isHaveAnimation = YES;
    
    self.calenderView.isCanScroll = YES;
    
    self.calenderView.isShowLastAndNextBtn = YES;
    
    self.calenderView.isShowLastAndNextDate = YES;
    
    self.calenderView.todayTitleColor =[UIColor hexStringToColor:@"617FDE"];
    
    self.calenderView.selectBackColor =[UIColor hexStringToColor:@"617FDE"];
    
    self.calenderView.backgroundColor =[UIColor whiteColor];
    
    
    [self.calenderView dealData];
    
    [self addSubview:self.calenderView];
    
    
    WeakBlock(self, weak_self);
    self.calenderView.selectBlock = ^(NSInteger year, NSInteger month, NSInteger day) {
        NSLog(@"%ld年 - %.2ld月 - %.2ld日",year,month,day);
        weak_self.model.PlanDayDate = [NSString stringWithFormat:@"%ld-%.2ld-%.2ld",year,month,day];
    };
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.calenderView.mas_left);
        make.top.mas_equalTo(self.calenderView.mas_bottom).offset(10);
    }];
    
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.width/2, 50));
    }];
    
    
    self.lineView.layer.cornerRadius = 0.5;
    self.lineView.layer.masksToBounds = YES;
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(1, 30));
        make.bottom.mas_equalTo(self.bottom).offset(-10);
    }];
    
    [self.SureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.width/2, 50));
    }];
    
    self.minMinutes = 0;
    self.maxMinutes = 288;
    self.curMinMinutes = 0;
    self.curMaxMinutes = 288;
    self.doubleSliderView.maxTintColor = [[UIColor hexStringToColor:@"617FDE"] colorWithAlphaComponent:0.2];
    self.doubleSliderView.minTintColor = [[UIColor hexStringToColor:@"617FDE"] colorWithAlphaComponent:0.2];
    self.doubleSliderView.midTintColor = [[UIColor hexStringToColor:@"617FDE"] colorWithAlphaComponent:1];
    [self.doubleSliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(self.width-20, 55));
    }];
    

    
}
- (IBAction)cancelClick:(id)sender {
    [GKCover hideCover];
}
- (IBAction)sureClick:(id)sender {
    
    FMDatabase *db = [MDMethods openOrCreateDBWithDBName:@"MarkProject.sqlite" Success:^{} Fail:^{return;}];
    NSString *createTableSqlString = @"CREATE TABLE IF NOT EXISTS PlanList (PlanID integer PRIMARY KEY AUTOINCREMENT, PlanTitle text NOT NULL, PlanDayDate text NOT NULL, priority integer NOT NULL, PlanItemBeginDate integer NOT NULL, PlanItemEndDate integer NOT NULL, CurrentTime integer NOT NULL)";
    [db executeUpdate:createTableSqlString];
    
    BOOL result = [db executeUpdateWithFormat:@"insert into PlanList (PlanTitle,PlanDayDate,priority,PlanItemBeginDate,PlanItemEndDate,currentTime) values (%@,%@,%d,%d,%d,%@)",self.model.PlanTitle,self.model.PlanDayDate,self.model.priority,self.model.PlanItemBeginDate,self.model.PlanItemEndDate,[MDMethods currentTimeStr]];
    
    if (result) {
        NSLog(@"插入成功");
        PlanViewController *vc = (PlanViewController *)[MDMethods getCurrentViewController];
        [vc getPlanList];
    } else {
        NSLog(@"插入失败");
        return;
    }
    [db close];
    [GKCover hideCover];
}
#pragma mark - action
//根据值获取整数

- (CGFloat)fetchIntFromValue:(CGFloat)value {
    CGFloat newValue = floorf(value);
    CGFloat changeValue = value - newValue;
    if (changeValue >= 0.5) {
        newValue = newValue + 1;
    }
    return newValue;
}

- (void)sliderValueChangeActionIsLeft: (BOOL)isLeft finish: (BOOL)finish {
    if (isLeft) {
        CGFloat age = (self.maxMinutes - self.minMinutes) * self.doubleSliderView.curMinValue;
        CGFloat tmpAge = [self fetchIntFromValue:age];
        self.curMinMinutes = (NSInteger)tmpAge + self.minMinutes;
        [self changeAgeTipsText];
    }else {
        CGFloat age = (self.maxMinutes - self.minMinutes) * self.doubleSliderView.curMaxValue;
        CGFloat tmpAge = [self fetchIntFromValue:age];
        self.curMaxMinutes = (NSInteger)tmpAge + self.minMinutes;
        [self changeAgeTipsText];
    }
    if (finish) {
        [self changeSliderValue];
    }
}

//值取整后可能改变了原始的大小，所以需要重新改变滑块的位置
- (void)changeSliderValue {
    CGFloat finishMinValue = (CGFloat)(self.curMinMinutes - self.minMinutes)/(CGFloat)(self.maxMinutes - self.minMinutes);
    CGFloat finishMaxValue = (CGFloat)(self.curMaxMinutes - self.minMinutes)/(CGFloat)(self.maxMinutes - self.minMinutes);
    self.doubleSliderView.curMinValue = finishMinValue;
    self.doubleSliderView.curMaxValue = finishMaxValue;
    [self.doubleSliderView changeLocationFromValue];
}

- (void)changeAgeTipsText {
    NSString *from = [self dealWithTotalTime:self.curMinMinutes];
    NSString *to = [self dealWithTotalTime:self.curMaxMinutes];
    self.model.PlanItemBeginDate = (int)self.curMinMinutes * 5;
    self.model.PlanItemEndDate = (int)self.curMaxMinutes * 5;
    if ((self.curMaxMinutes - self.curMinMinutes) == 288) {
        self.timeLabel.text = @"时间段: 全天";
    }else {
        self.timeLabel.text = [NSString stringWithFormat:@"时间段: %@ ~ %@", from, to];
    }
}

- (DoubleSliderView *)doubleSliderView {
    if (!_doubleSliderView) {
        _doubleSliderView = [[DoubleSliderView alloc] initWithFrame:CGRectMake(0, 0, self.width - 20, 35 + 20)];
        _doubleSliderView.needAnimation = true;
                CGFloat offset = self.maxMinutes - self.minMinutes;
                if (offset > 1.0) {
                    _doubleSliderView.minInterval = 1.0/(offset);
                }
        __weak typeof(self) weakSelf = self;
        _doubleSliderView.sliderBtnLocationChangeBlock = ^(BOOL isLeft, BOOL finish) {
            [weakSelf sliderValueChangeActionIsLeft:isLeft finish:finish];
        };
        [self addSubview:_doubleSliderView];
    }
    return _doubleSliderView;
}
- (PlanModel *)model
{
    if (!_model) {
        _model = [[PlanModel alloc] init];
    }
    return _model;
}
//转换为00：00
- (NSString *)dealWithTotalTime:(NSInteger)totalTime {
    
    NSInteger totalSecond = totalTime*5*60;
    
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
