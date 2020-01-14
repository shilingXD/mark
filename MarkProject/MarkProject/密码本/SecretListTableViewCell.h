//
//  SecretListTableViewCell.h
//  MarkProject
//
//  Created by 孙冬 on 2020/1/13.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecretListTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView *myContentView;///<<#注释#>

+ (id)cellForTableview:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
