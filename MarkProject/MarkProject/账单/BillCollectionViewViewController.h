//
//  BillCollectionViewViewController.h
//  MarkProject
//
//  Created by 孙冬 on 2020/5/6.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(int, BillType) {
    cost = 0,
    income = 1
};
NS_ASSUME_NONNULL_BEGIN

@interface BillCollectionViewViewController : UIViewController
@property (nonatomic, strong) NSArray *dataArray;///<<#注释#>
@property (nonatomic, assign) BillType type;///<<#注释#>
@end

NS_ASSUME_NONNULL_END
