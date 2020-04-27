//
//  TipTableViewCell.h
//  MarkProject
//
//  Created by 孙冬 on 2020/4/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TipTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIImageView *tipimageView;
@property (weak, nonatomic) IBOutlet UIView *titleView;

@end

NS_ASSUME_NONNULL_END
