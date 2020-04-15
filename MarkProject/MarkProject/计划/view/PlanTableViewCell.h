//
//  PlanTableViewCell.h
//  MarkProject
//
//  Created by 孙冬 on 2020/4/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlanTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *daylabel;///<日期
@property (nonatomic, strong) UIView *calendarView;///<日程表表格
@property (nonatomic, strong) PlanModel *model;

+ (id)cellForTableview:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
