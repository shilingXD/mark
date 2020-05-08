//
//  BillTableViewCell.h
//  MarkProject
//
//  Created by 孙冬 on 2020/5/2.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BillTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *MyContentView;
@property (weak, nonatomic) IBOutlet UIImageView *tipImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailNumLabel;
@property (nonatomic, strong) BillModel *model;///<<#注释#>
@end

NS_ASSUME_NONNULL_END
