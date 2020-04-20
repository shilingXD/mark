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

+ (instancetype)init;
@end

NS_ASSUME_NONNULL_END
