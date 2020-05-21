//
//  NewfileView.h
//  MarkProject
//
//  Created by 孙冬 on 2020/4/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewfileView : BaseView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *TitleLbal;
@property (weak, nonatomic) IBOutlet UITextField *Inputfield;
@property (weak, nonatomic) IBOutlet UIView *FieldLine;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIView *lineview;
@property (weak, nonatomic) IBOutlet UIButton *SureBtn;
@property (nonatomic, copy) NSString *Type;///<1文件2文件夹
@property (nonatomic, copy) NSString *FilePath;///<所属文件夹 如果没有所属文件夹首页展示
@property (nonatomic, copy) void (^reloadBlock) (void);///<<#注释#>
+ (instancetype)init;
@end

NS_ASSUME_NONNULL_END
