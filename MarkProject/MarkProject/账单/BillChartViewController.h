//
//  BillChartViewController.h
//  MarkProject
//
//  Created by 孙冬 on 2020/5/6.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BillChartViewController : BaseViewController
@property (nonatomic, strong) NSMutableArray<BillModel *> *dataArray;///<<#注释#>
@end

NS_ASSUME_NONNULL_END
