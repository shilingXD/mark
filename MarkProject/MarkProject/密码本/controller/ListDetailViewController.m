//
//  ListDetailViewController.m
//  MarkProject
//
//  Created by MAC on 2020/4/13.
//  Copyright © 2020 mac. All rights reserved.
//

#import "ListDetailViewController.h"
#import "NSString+Util.h"

#define litteTitlecolor TintColor
#define inputColor rgba(36, 53, 78, 1)

@interface ListDetailViewController ()
@property (nonatomic, strong) UITextField *namefield;///<名称
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *Accountfield;///<账号
@property (nonatomic, strong) UITextField *Pwdfield;///<密码
@property (nonatomic, strong) UITextField *Urlfield;///<网址
@property (nonatomic, strong) UITextField *Notefield;///<备注
@property (nonatomic, strong) UILabel *editLabel;///<编辑label
@property (nonatomic, assign) BOOL isEdit;///<是否编辑
@end

@implementation ListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
//    [self setupListOne];
//    [self setupListTwo];
//    [self setupListThree];
    [self setupFooter];
}

-(void)setNav
{
    [self.navigationView setTitle:@""];
    self.view.backgroundColor = rgba(240, 240, 240, 1);
    self.navigationView.backgroundView.image = nil ;
    self.navigationView.backgroundView.backgroundColor = TintColor;
    self.navigationView.lineView.backgroundColor = TintColor;
    
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    UILabel *Label = [[UILabel alloc] init];
    self.editLabel = Label;
    Label.text = @"编辑";
    Label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    Label.textColor = [UIColor whiteColor];
    [rightView addSubview:Label];
        [Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(rightView);
        }];
        WeakBlock(self, weakSelf);
        [self.navigationView addRightView:rightView callback:^(UIView *view) {
            [weakSelf editList];
        }];
}
-(void)setupListOne
{
    UIView *iconbackView = [[UIView alloc] init];
    iconbackView.backgroundColor = [UIColor whiteColor];
    iconbackView.tag = 100;
    [iconbackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap:)]];
    [self.view addSubview:iconbackView];
    [iconbackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom);
        make.height.mas_equalTo(90);
    }];
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.layer.cornerRadius = 5;
    iconView.layer.masksToBounds = YES;
    iconView.backgroundColor = rgba(68, 107, 255, 1);
    [self.view addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.centerY.mas_equalTo(iconbackView);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    nameLabel.text = self.model.Name;
    nameLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    nameLabel.textColor = inputColor;
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconView.mas_right).offset(10);
        make.right.mas_equalTo(iconbackView.mas_right);
        make.centerY.mas_equalTo(iconView).mas_offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    UITextField *nameField = [[UITextField alloc] init];
    self.namefield = nameField;
    nameField.hidden = YES;
    nameField.borderStyle = UITextBorderStyleNone;
    nameField.placeholder = @"名称";
    nameField.text = self.model.Name;
    nameField.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    nameField.textColor = inputColor;
    [self.view addSubview:nameField];
    [nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconView.mas_right).offset(10);
        make.right.mas_equalTo(iconbackView.mas_right);
        make.centerY.mas_equalTo(iconView).mas_offset(-10);
        make.height.mas_equalTo(30);
    }];
    UILabel *tiplabel = [[UILabel alloc] init];
    tiplabel.text = @"名称";
    tiplabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
    tiplabel.textColor = rgba(130, 136, 156, 1);
    [iconbackView addSubview:tiplabel];
    [tiplabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconView.mas_right).offset(10);
        make.right.mas_equalTo(iconbackView.mas_right);
        make.centerY.mas_equalTo(iconView).mas_offset(10);
        make.height.mas_equalTo(30);
    }];
    UIView *lineview = [[UIView alloc] init];
    lineview.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:lineview];
    [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(iconbackView);
        make.height.mas_equalTo(1);
    }];
}
-(void)setupListTwo
{
    UIView *BackView = [[UIView alloc] init];
    BackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:BackView];
    [BackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom).offset(105);
    }];
    UILabel *tiplabel1 = [[UILabel alloc] init];
    tiplabel1.text = @"帐户名";
    tiplabel1.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    tiplabel1.textColor = TintColor;
    [self.view addSubview:tiplabel1];
    [tiplabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.top.mas_equalTo(BackView.mas_top).offset(10);
    }];
    UILabel *accountLabel = [[UILabel alloc] init];
//    self.nameLabel = accountLabel;
    accountLabel.text = self.model.Account;
    accountLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    accountLabel.textColor = inputColor;
    [self.view addSubview:accountLabel];
    [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(BackView.mas_right);
        make.top.mas_equalTo(tiplabel1.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    
    _Accountfield = [[UITextField alloc] init];
    _Accountfield.hidden = YES;
    _Accountfield.borderStyle = UITextBorderStyleNone;
    _Accountfield.placeholder = @"帐户名";
    _Accountfield.text = self.model.Account;
    _Accountfield.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    _Accountfield.textColor = inputColor;
    [self.view addSubview:_Accountfield];
    [_Accountfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(accountLabel);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(accountLabel);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *tiplabel2 = [[UILabel alloc] init];
    tiplabel2.text = @"密码";
    tiplabel2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    tiplabel2.textColor = TintColor;
    [self.view addSubview:tiplabel2];
    [tiplabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.top.mas_equalTo(line.mas_bottom).offset(10);
    }];
    UILabel *pwdLabel = [[UILabel alloc] init];
    //    self.nameLabel = accountLabel;
    pwdLabel.text = self.model.PassWord;
    pwdLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    pwdLabel.textColor = inputColor;
    [self.view addSubview:pwdLabel];
    [pwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(BackView.mas_right);
        make.top.mas_equalTo(tiplabel2.mas_bottom);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(BackView.mas_bottom).offset(-11);
    }];
    
    _Pwdfield = [[UITextField alloc] init];
    _Pwdfield.hidden = YES;
    _Pwdfield.borderStyle = UITextBorderStyleNone;
    _Pwdfield.placeholder = @"密码";
//    _Pwdfield.textInputMode =
    _Pwdfield.text = self.model.PassWord;
    _Pwdfield.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    _Pwdfield.textColor = inputColor;
    [self.view addSubview:_Pwdfield];
    [_Pwdfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(accountLabel);
    }];
    
    UIView *lineview = [[UIView alloc] init];
    lineview.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:lineview];
    [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(BackView);
        make.height.mas_equalTo(1);
    }];
    UIView *lineview2 = [[UIView alloc] init];
    lineview2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:lineview2];
    [lineview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(BackView);
        make.height.mas_equalTo(1);
    }];
}
-(void)setupListThree
{
    UIView *BackView = [[UIView alloc] init];
    BackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:BackView];
    [BackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom).offset(220);
        make.height.mas_equalTo(100);
    }];
    UILabel *tiplabel1 = [[UILabel alloc] init];
    tiplabel1.text = @"网址";
    tiplabel1.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    tiplabel1.textColor = TintColor;
    [self.view addSubview:tiplabel1];
    [tiplabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.top.mas_equalTo(BackView.mas_top).offset(10);
    }];
    UILabel *accountLabel = [[UILabel alloc] init];
    //    self.nameLabel = accountLabel;
    accountLabel.text = self.model.Account;
    accountLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    accountLabel.textColor = inputColor;
    [self.view addSubview:accountLabel];
    [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(BackView.mas_right);
        make.top.mas_equalTo(tiplabel1.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    
    _Accountfield = [[UITextField alloc] init];
    _Accountfield.hidden = YES;
    _Accountfield.borderStyle = UITextBorderStyleNone;
    _Accountfield.placeholder = @"网址";
    _Accountfield.text = self.model.Account;
    _Accountfield.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    _Accountfield.textColor = inputColor;
    [self.view addSubview:_Accountfield];
    [_Accountfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(accountLabel);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(accountLabel);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *tiplabel2 = [[UILabel alloc] init];
    tiplabel2.text = @"备注";
    tiplabel2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    tiplabel2.textColor = TintColor;
    [self.view addSubview:tiplabel2];
    [tiplabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.top.mas_equalTo(line.mas_bottom).offset(10);
    }];
    UILabel *pwdLabel = [[UILabel alloc] init];
    //    self.nameLabel = accountLabel;
    pwdLabel.text = self.model.PassWord;
    pwdLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    pwdLabel.textColor = inputColor;
    [self.view addSubview:pwdLabel];
    [pwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(BackView.mas_right);
        make.top.mas_equalTo(tiplabel2.mas_bottom);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(BackView.mas_bottom).offset(-11);
    }];
    
    _Pwdfield = [[UITextField alloc] init];
    _Pwdfield.hidden = YES;
    _Pwdfield.borderStyle = UITextBorderStyleNone;
    _Pwdfield.placeholder = @"备注";
    //    _Pwdfield.textInputMode =
    _Pwdfield.text = self.model.PassWord;
    _Pwdfield.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    _Pwdfield.textColor = inputColor;
    [self.view addSubview:_Pwdfield];
    [_Pwdfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(accountLabel);
    }];
    
    UIView *lineview = [[UIView alloc] init];
    lineview.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:lineview];
    [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(BackView);
        make.height.mas_equalTo(1);
    }];
    UIView *lineview2 = [[UIView alloc] init];
    lineview2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:lineview2];
    [lineview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(BackView);
        make.height.mas_equalTo(1);
    }];
}

-(void)setupFooter
{
    UILabel *createTimelabel = [[UILabel alloc] init];
    createTimelabel.text = [NSString stringWithFormat:@"创建日期  %@",[MDMethods changeTimeDate:self.model.CreateTime]];
    createTimelabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 12];
    createTimelabel.textColor = rgba(130, 136, 156, 1);
    [self.view addSubview:createTimelabel];
    [createTimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-70);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *updateTimelabel = [[UILabel alloc] init];
    updateTimelabel.text = [NSString stringWithFormat:@"修改日期  %@",[MDMethods changeTimeDate:self.model.UpdateTime]];
    updateTimelabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 12];
    updateTimelabel.textColor = rgba(130, 136, 156, 1);
    [self.view addSubview:updateTimelabel];
    [updateTimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(createTimelabel.mas_left);
        make.top.mas_equalTo(createTimelabel.mas_bottom).offset(5);
    }];
}

#pragma mark  - ------  事件响应  ------
-(void)Tap:(UITapGestureRecognizer *)sender
{
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES]; //实现该方法是需要注意view需要是继承UIControl而来的
}
-(void)editList
{
    self.isEdit = !self.isEdit;
    if (self.isEdit) {
        [self.namefield becomeFirstResponder];
        self.editLabel.text = @"完成";
        
    } else {
        [self.view endEditing:YES];
        self.editLabel.text = @"编辑";
        [self updateDB];
    }
    
}

-(void)updateDB
{
    FMDatabase *db = [MDMethods openOrCreateDBWithDBName:@"SecretList.sqlite" Success:^{
        
    } Fail:^{
        return ;
    }];
    BOOL result2 = [db executeUpdateWithFormat:@"update SecretList set Name = %@,NameURL = %@,Account = %@,PassWord = %@,Note = %@,UpdateTime = %@,currentTime = %@ where id = %d",self.namefield.text,self.Urlfield.text,self.Accountfield.text,self.Pwdfield.text,self.Notefield.text,[MDMethods currentDateStr],[MDMethods currentTimeStr],self.model.secretID];
    if (result2) {
        NSLog(@"修改成功");
        self.dismissBlock();
    } else {
        NSLog(@"修改失败");
        [MDMethods showTextMessage:@"修改失败，再尝试一下吧！"];
    }
}
@end
