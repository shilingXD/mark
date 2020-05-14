//
//  DemoCell.h
//  CCFoldCellDemo
//
//  Created by eHome on 17/2/23.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCFoldCell.h"

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
@property (nonatomic, copy) void (^callSelectRowBlock) (NSInteger row);

- (void)setNumber:(NSInteger)number;

@end
