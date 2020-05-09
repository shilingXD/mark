//
//  BillModel.h
//  MarkProject
//
//  Created by 孙冬 on 2020/5/8.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BillModel : NSObject
@property (nonatomic, assign) int BillID;///账单编号
@property (nonatomic, assign) int type;///<0支出1收入
@property (nonatomic, copy) NSString * money;///<金额
@property (nonatomic, copy) NSString *currentDate;///<创建的时间戳
@property (nonatomic, copy) NSString *currentDateStr;///<创建的时间
@property (nonatomic, copy) NSString *name;///<账单名称
@property (nonatomic, copy) NSString *mark;///<备注
@end


@interface BillDayModel : NSObject
@property (nonatomic, copy) NSString *dataString;///<日期
@property (nonatomic, strong,nullable) NSDecimalNumber *income;///<收入详情
@property (nonatomic, strong,nullable) NSDecimalNumber *cost;///<支出详情
@property (nonatomic, strong) NSMutableArray<BillModel *> *dataArray;///<<#注释#>
@end

NS_ASSUME_NONNULL_END
