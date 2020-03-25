//
//  SecretListTableViewCell.h
//  MarkProject
//
//  Created by 孙冬 on 2020/1/13.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecretModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecretListTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *IconView;///<密码图标
@property (nonatomic, strong) UILabel *iconText;///<密码图标文字
@property (nonatomic, strong) UILabel *Title;///<账号标题
@property (nonatomic, strong) UILabel *Account;///<账号
@property (nonatomic, strong) UIView *lineView;///<分割线

@property (nonatomic, strong) SecretModel *model;///<<#注释#>
+ (id)cellForTableview:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
