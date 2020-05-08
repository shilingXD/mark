//
//  ListDetailViewController.h
//  MarkProject
//
//  Created by MAC on 2020/4/13.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecretModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListDetailViewController : BaseViewController
@property (nonatomic, strong) SecretModel *model;///<<#注释#>
@property (nonatomic, copy) void (^dismissBlock)(void);
@end

NS_ASSUME_NONNULL_END
