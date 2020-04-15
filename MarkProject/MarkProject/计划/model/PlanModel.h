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
@property (nonatomic, copy) NSString *TimeStr;///<日程时间
@property (nonatomic, strong) NSMutableArray *array;///<该日的计划
@property (nonatomic, copy) NSString *beginTime;///<计划开始时间
@property (nonatomic, copy) NSString *endTime;///<结束时间

@end

NS_ASSUME_NONNULL_END
