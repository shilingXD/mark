//
//  LoginViewController.m
//  MarkProject
//
//  Created by MAC on 2020/5/6.
//  Copyright © 2020 mac. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [MDInstance sharedInstance].themeColor;
    [self setContentView];
}

- (void)setNav
{
    [super setNav];
    
}
-(void)setContentView
{
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*0.8, 40));
        make.top.mas_equalTo(self.navigationView.mas_bottom).offset(10);
    }];
    self.accontFiled.leftViewMode = UITextFieldViewModeAlways;
    self.accontFiled.backgroundColor = [UIColor clearColor];
    self.accontFiled.leftView = [self addleftViewWithImage:[UIImage imageNamed:@"我的"]];
    self.accontFiled.attributedPlaceholder = [MDMethods ChangeNSMutabelAttributedString:@"请输入邮箱" WithTargetValue:rgba(255, 255, 255, 0.5) AndTargetString:@"请输入邮箱"];
    [self.accontFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*0.8, 35));
        make.top.mas_equalTo(self.tipLabel.mas_bottom).offset(50);
    }];
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.accontFiled.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*0.8, 0.5));
    }];
    self.secertFiled.leftViewMode = UITextFieldViewModeAlways;
    self.secertFiled.leftView = [self addleftViewWithImage:[UIImage imageNamed:@"密码"]];
    self.secertFiled.attributedPlaceholder = [MDMethods ChangeNSMutabelAttributedString:@"请输入密码" WithTargetValue:rgba(255, 255, 255, 0.5) AndTargetString:@"请输入密码"];
    self.secertFiled.backgroundColor = [UIColor clearColor];
    [self.secertFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*0.8, 35));
        make.top.mas_equalTo(self.accontFiled.mas_bottom).offset(20);
    }];
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.secertFiled.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*0.8, 0.5));
    }];
    self.loginButtn.layer.cornerRadius = 25;
    self.loginButtn.layer.masksToBounds = YES;
    [self.loginButtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*0.8, 50));
        make.top.mas_equalTo(self.secertFiled.mas_bottom).offset(50);
    }];
}
-(UIView *)addleftViewWithImage:(UIImage *)image
{
    UIView *LeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 40)];
    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
    [LeftView addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.mas_equalTo(LeftView.mas_left).mas_offset(10);
        make.right.mas_equalTo(LeftView.mas_right).mas_offset(-5);
        make.centerY.mas_equalTo(LeftView);
    }];
    
    return LeftView;
}
@end
