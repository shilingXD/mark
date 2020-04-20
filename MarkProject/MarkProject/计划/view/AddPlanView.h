//
//  AddPlanView.h
//  MarkProject
//
//  Created by 孙冬 on 2020/4/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BaseView.h"
#import "DoubleSliderView.h"
#import "PlanModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddPlanView : BaseView

@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *SureBtn;

@property (nonatomic, assign) NSInteger minMinutes;
@property (nonatomic, assign) NSInteger maxMinutes;
@property (nonatomic, assign) NSInteger curMinMinutes;
@property (nonatomic, assign) NSInteger curMaxMinutes;
@property (nonatomic, strong) DoubleSliderView *doubleSliderView;
@property (nonatomic, strong) LXCalendarView *calenderView;
@property (nonatomic, strong) PlanModel *model;///<<#注释#>


+ (instancetype)init;
@end

NS_ASSUME_NONNULL_END
