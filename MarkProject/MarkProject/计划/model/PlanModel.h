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
@property (nonatomic, copy) NSString *PlanDayDate;///<当日日程的时间 yyyy-mm-dd
@property (nonatomic, copy) NSString *PlanTitle;///<计划标题
@property (nonatomic, strong) NSMutableArray *array;///<该日的计划
@property (nonatomic, copy) NSString *PlanItemBeginDate;///<计划开始时间 hh:mm
@property (nonatomic, copy) NSString *PlanItemEndDate;///<结束时间
@property (nonatomic, copy) NSString *currentTime;///<时间戳

@end

NS_ASSUME_NONNULL_END
