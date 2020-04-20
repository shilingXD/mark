//
//  PlanModel.h
//  MarkProject
//
//  Created by 孙冬 on 2020/4/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlanModel : NSObject
@property (nonatomic, assign) int PlanID;///<计划编号
@property (nonatomic, copy) NSString *PlanTitle;///<计划标题
@property (nonatomic, copy) NSString *PlanDayDate;///<当日日程的时间 yyyy-mm-dd
@property (nonatomic, assign) int priority;///<优先级  1低优先级 2中优先级 3高优先级
@property (nonatomic, assign) int PlanItemBeginDate;///<计划开始时间 分钟数
@property (nonatomic, assign) int PlanItemEndDate;///<结束时间 分钟数
@property (nonatomic, copy) NSString *currentTime;///<时间戳

@end

NS_ASSUME_NONNULL_END
