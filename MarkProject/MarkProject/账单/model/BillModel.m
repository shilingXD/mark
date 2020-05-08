//
//  BillModel.m
//  MarkProject
//
//  Created by 孙冬 on 2020/5/8.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BillModel.h"

@implementation BillModel

@end

@implementation BillDayModel
- (NSMutableArray<BillModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
