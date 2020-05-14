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
    self.accontFiled.leftView = [self addleftViewWithImage:[UIImage imageNamed:@"邮箱"]];
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
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    [LeftView addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.left.mas_equalTo(LeftView.mas_left).mas_offset(7.5);
        make.right.mas_equalTo(LeftView.mas_right).mas_offset(-7.5);
        make.centerY.mas_equalTo(LeftView);
    }];
    
    return LeftView;
}
- (IBAction)LgoinAction:(id)sender {
    if (self.accontFiled.text.length == 0) {
        [MDMethods showTextMessage:@"邮箱不能为空"];
        return;
    }
    if (self.secertFiled.text.length == 0) {
        [MDMethods showTextMessage:@"密码不能为空"];
        return;
    }
    
    if ([MDMethods isValidateEmail:self.accontFiled.text]) {
        [MDInstance sharedInstance].Email = self.accontFiled.text;
    }else{
        [MDMethods showTextMessage:@"邮箱格式错误"];
        return;
    }
    if (self.secertFiled.text.length>=8 && self.secertFiled.text.length<=16) {
        [MDInstance sharedInstance].UserPassWord = self.secertFiled.text;
    }else{
        [MDMethods showTextMessage:@"密码为8-16位"];
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    //查找表
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"UserList"];
    //查找表里面id为0c6db13c的数据
    WeakBlock(self, weak_self);
    [bquery queryInBackgroundWithBQL:[NSString stringWithFormat:@"select * from UserList where user_email = '%@'",self.accontFiled.text] block:^(BQLQueryResult *result, NSError *error) {
        if (error){
            //进行错误处理
        }else{
            if (result.resultsAry.count == 0) {
                [weak_self newAccount];
                [hud hideAnimated:YES];
            } else {
                BmobObject *object = result.resultsAry[0];
                NSString *pwd = [object objectForKey:@"user_password"];
                if ([pwd isEqualToString:self.secertFiled.text]) {
                    [MDInstance sharedInstance].UserName = [object objectForKey:@"user_name"];
                    [self showSussecessWithMsg:@"登录成功！"];
                    [hud hideAnimated:YES];
                } else {
                    
                }
            }
        }
    }];
    [bquery getObjectInBackgroundWithId:@"0c6db13c" block:^(BmobObject *object,NSError *error){
        
    }];
    
    
}
-(void)newAccount
{
    BmobObject *user = [BmobObject objectWithClassName:@"UserList"];
    [user setObject:self.accontFiled.text forKey:@"user_email"];
    [user setObject:self.secertFiled.text forKey:@"user_password"];
    [user setObject:[MDMethods getUUIDByKeyChain] forKey:@"user_deviceid"];
     [user saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
         //进行操作
         NSLog(@"%@",error.description);
         if (isSuccessful) {
             [self showSussecessWithMsg:@"注册成功"];
             [MDInstance sharedInstance].UserName = @"用户";
         }
     }];
}

-(void)showSussecessWithMsg:(NSString *)msg
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];

    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    // Optional label text.
    hud.label.text = msg;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    });
    [self setUserInfo];
}
-(void)setUserInfo
{
    [MDInstance sharedInstance].isLogin = YES;
    [[NSUserDefaults standardUserDefaults] setObject:self.accontFiled.text forKey:@"user_Email"];
    [[NSUserDefaults standardUserDefaults] setObject:self.secertFiled.text forKey:@"user_UserPassWord"];
    [MDInstance setNSUserDefaults];
}
@end
