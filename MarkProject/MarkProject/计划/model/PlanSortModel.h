//
//  PlanSortModel.h
//  MarkProject
//
//  Created by MAC on 2020/4/21.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlanDaySortModel : NSObject
@property (nonatomic, copy) NSString *Day;///<月份
@property (nonatomic, strong) NSMutableArray *dayArray;///<当日的计划（）
@end


@interface PlanSortModel : NSObject
@property (nonatomic, copy) NSString *Month;///<月份
@property (nonatomic, strong) NSMutableArray<PlanDaySortModel *> *monthArray;///<当月的计划
@end


NS_ASSUME_NONNULL_END
