//
//  AddPlanNameView.h
//  MarkProject
//
//  Created by 孙冬 on 2020/4/16.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddPlanNameView : BaseView <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *Noticelabel;
@property (weak, nonatomic) IBOutlet UITextField *TitleField;
@property (weak, nonatomic) IBOutlet UIView *fieldLine;
@property (weak, nonatomic) IBOutlet UIButton *HeighBtn;
@property (weak, nonatomic) IBOutlet UIButton *MidBtn;
@property (weak, nonatomic) IBOutlet UIButton *LowBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (nonatomic, strong) PlanModel *model;///<<#注释#>

+ (instancetype)init;
@end

NS_ASSUME_NONNULL_END
