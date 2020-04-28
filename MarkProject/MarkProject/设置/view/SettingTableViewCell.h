//
//  SettingTableViewCell.h
//  MarkProject
//
//  Created by 孙冬 on 2020/4/27.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *stateSwitch;
@property (nonatomic, copy) void (^SwitchBlock)(BOOL isOn);///<<#注释#>
@end

NS_ASSUME_NONNULL_END
