//
//  BillDetailView.h
//  MarkProject
//
//  Created by 孙冬 on 2020/5/13.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BillDetailView : BaseView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;

@property (nonatomic, strong) BillModel *model;///<<#注释#>

+ (instancetype)init ;
@end

NS_ASSUME_NONNULL_END
