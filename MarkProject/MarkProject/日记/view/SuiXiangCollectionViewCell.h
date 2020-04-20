//
//  SuiXiangCollectionViewCell.h
//  MarkProject
//
//  Created by 孙冬 on 2020/3/31.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuiXiangCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *Titlelabel;///<标题
@property (nonatomic, strong) UIImageView *imageView;///<类型图标
@property (nonatomic, strong) UILabel *Datelabel;///<日期
@property (nonatomic, strong) UIButton *morebtn;///<更多操作
@end

NS_ASSUME_NONNULL_END
