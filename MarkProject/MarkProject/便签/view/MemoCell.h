//
//  DemoCell.h
//  CCFoldCellDemo
//
//  Created by eHome on 17/2/23.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCFoldCell.h"
#import "MemoModel.h"

@interface MemoCell : CCFoldCell<UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *closeNumberLabel;
@property (weak, nonatomic) IBOutlet UIView *leftView;

@property (weak, nonatomic) IBOutlet UILabel *DataLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet UIView *openView;
@property (weak, nonatomic) IBOutlet UILabel *openTitlelabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UILabel *completeLabel;
@property (nonatomic, copy) void (^callSelectRowBlock) (NSInteger row);
@property (nonatomic, copy) void (^callUpdateBlock) (void);
@property (nonatomic, strong) MemoModel *model;

- (void)setNumber:(NSInteger)number;

@end
