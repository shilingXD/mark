//
//  MoreActionView.h
//  MarkProject
//
//  Created by 孙冬 on 2020/4/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoreActionView : BaseView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;///<<#注释#>
@property (nonatomic, strong) NSArray *dataArray;///<<#注释#>
@end

NS_ASSUME_NONNULL_END
