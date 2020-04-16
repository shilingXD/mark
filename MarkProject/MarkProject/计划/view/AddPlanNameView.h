//
//  AddPlanNameView.h
//  MarkProject
//
//  Created by 孙冬 on 2020/4/16.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddPlanNameView : BaseView
@property (weak, nonatomic) IBOutlet UITextField *TitleField;
@property (weak, nonatomic) IBOutlet UIButton *HeighBtn;
@property (weak, nonatomic) IBOutlet UIButton *MidBtn;
@property (weak, nonatomic) IBOutlet UIButton *LowBtn;

+ (instancetype)init;
@end

NS_ASSUME_NONNULL_END
