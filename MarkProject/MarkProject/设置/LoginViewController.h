//
//  LoginViewController.h
//  MarkProject
//
//  Created by MAC on 2020/5/6.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *accontFiled;
@property (weak, nonatomic) IBOutlet UITextField *secertFiled;
@property (weak, nonatomic) IBOutlet UIButton *loginButtn;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UIView *lineView2;

@end

NS_ASSUME_NONNULL_END
