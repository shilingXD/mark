//
//  AddSecretViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/13.
//  Copyright © 2020 mac. All rights reserved.
//

#import "AddSecretViewController.h"

@interface AddSecretViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *IconLabel;
@property (nonatomic, strong) UITextField *namefield;///<名称
@property (nonatomic, strong) UITextField *Accountfield;///<账号
@property (nonatomic, strong) UITextField *Pwdfield;///<密码
@property (nonatomic, strong) UITextField *Urlfield;///<网址
@property (nonatomic, strong) UITextField *Notefield;///<备注
@end

@implementation AddSecretViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:GrayWhiteColor];
    [self setbar];
    [self setupContentView];
}

-(void)setbar
{
    UIView *barView = [[UIView alloc] init];
    barView.backgroundColor = TintColor;
    [self.view addSubview:barView];
    [barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(barView);
        make.width.mas_equalTo(70);
    }];
    
    UIButton *sureBtn = [[UIButton alloc] init];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(barView);
        make.width.mas_equalTo(70);
    }];
}

-(void)setupContentView
{
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.tag =100;
    iconView.layer.cornerRadius = 5;
    iconView.layer.masksToBounds = YES;
    iconView.backgroundColor = rgba(68, 107, 255, 1);
    [self.view addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(80);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.attributedText = [MDMethods ChangeNSMutabelAttributedString:@"*请输入您的名称" WithTargetValue:[UIColor redColor] AndTargetString:@"*"];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconView.mas_right).offset(10);
        make.bottom.mas_equalTo(iconView.mas_bottom).offset(-40);
    }];
    
    UITextField *nameField = [[UITextField alloc] init];
    self.namefield = nameField;
    nameField.borderStyle = UITextBorderStyleNone;
    nameField.placeholder = @"名称";
    nameField.delegate = self;
    nameField.font = [UIFont systemFontOfSize:17];
    [nameField becomeFirstResponder];
    [self.view addSubview:nameField];
    [nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconView.mas_right).offset(10);
        make.bottom.mas_equalTo(iconView.mas_bottom).offset(-10);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(30);
    }];
    UIView *lineview = [[UIView alloc] init];
    lineview.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:lineview];
    [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(nameField);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *AccontLabel = [[UILabel alloc] init];
    AccontLabel.attributedText = [MDMethods ChangeNSMutabelAttributedString:@"*请输入您的用户名" WithTargetValue:[UIColor redColor] AndTargetString:@"*"];
    AccontLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:AccontLabel];
    [AccontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(nameField.mas_bottom).offset(30);
    }];
    
    UITextField *AccountField = [[UITextField alloc] init];
    self.Accountfield = AccountField;
    AccountField.borderStyle = UITextBorderStyleNone;
    AccountField.font = [UIFont systemFontOfSize:17];
    AccountField.placeholder = @"用户名";
    [self.view addSubview:AccountField];
    [AccountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(AccontLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(30);
    }];
    UIView *lineview2 = [[UIView alloc] init];
    lineview2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:lineview2];
    [lineview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(AccountField);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *PwdLabel = [[UILabel alloc] init];
    PwdLabel.attributedText = [MDMethods ChangeNSMutabelAttributedString:@"*请输入您的密码" WithTargetValue:[UIColor redColor] AndTargetString:@"*"];;
    PwdLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:PwdLabel];
    [PwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(AccountField.mas_bottom).offset(10);
    }];
    UITextField *PwdField = [[UITextField alloc] init];
    self.Pwdfield = PwdField;
    PwdField.borderStyle = UITextBorderStyleNone;
    PwdField.placeholder = @"密码";
    PwdField.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:PwdField];
    [PwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(PwdLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(30);
    }];
    UIView *lineview3 = [[UIView alloc] init];
    lineview3.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:lineview3];
    [lineview3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(PwdField);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *urlLabel = [[UILabel alloc] init];
    urlLabel.text = @"网址";
    urlLabel.font = [UIFont systemFontOfSize:15];
    urlLabel.textColor = [UIColor blackColor];
    [self.view addSubview:urlLabel];
    [urlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(PwdField.mas_bottom).offset(10);
    }];
    
    UITextField *urlField = [[UITextField alloc] init];
    self.Urlfield = urlField;
    urlField.borderStyle = UITextBorderStyleNone;
    urlField.placeholder = @"网址（选填）";
    urlField.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:urlField];
    [urlField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(urlLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(30);
    }];
    UIView *lineview4 = [[UIView alloc] init];
    lineview4.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:lineview4];
    [lineview4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(urlField);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *Notelabel = [[UILabel alloc] init];
    Notelabel.text = @"备注";
    Notelabel.font = [UIFont systemFontOfSize:15];
    Notelabel.textColor = [UIColor blackColor];
    [self.view addSubview:Notelabel];
    [Notelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(urlField.mas_bottom).offset(10);
    }];
    
    UITextField *NoteField = [[UITextField alloc] init];
    self.Notefield = NoteField;
    NoteField.borderStyle = UITextBorderStyleNone;
    NoteField.placeholder = @"备注（选填）";
    NoteField.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:NoteField];
    [NoteField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Notelabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(30);
    }];
    UIView *lineview5 = [[UIView alloc] init];
    lineview5.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:lineview5];
    [lineview5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(NoteField);
        make.height.mas_equalTo(1);
    }];
}

-(void)cancel:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)sure:(UIButton *)sender
{
    FMDatabase *db = [MDMethods openOrCreateDBWithDBName:@"SecretList.sqlite" Success:^{
        
    } Fail:^{
        return ;
    }];
    //1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
//    BOOL result = [db executeUpdate:@"INSERT INTO SecretList (name, age, sex) VALUES (?,?,?)",name,@(age),sex];
    //2.executeUpdateWithForamat：不确定的参数用%@，%d等来占位 （参数为原始数据类型，执行语句不区分大小写）
        BOOL result = [db executeUpdateWithFormat:@"insert into SecretList (Name,NameURL,Account,PassWord,Note,CreateTime,UpdateTime,currentTime) values (%@,%@,%@,%@,%@,%@,%@,%@)",self.namefield.text,self.Urlfield.text,self.Accountfield.text,self.Pwdfield.text,self.Notefield.text,[MDMethods currentDateStr],[MDMethods currentDateStr],[MDMethods currentTimeStr]];
    //3.参数是数组的使用方式
    //    BOOL result = [_db executeUpdate:@"INSERT INTO t_student(name,age,sex) VALUES  (?,?,?);" withArgumentsInArray:@[name,@(age),sex]];
    if (result) {
        NSLog(@"插入成功");
        self.dismissBlock();
    } else {
        NSLog(@"插入失败");
        return;
    }
    
    [self dismissViewControllerAnimated:YES completion:^{}];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.IconLabel.text = textField.text.length >= 2?[textField.text substringToIndex:2]:textField.text;
}

- (UILabel *)IconLabel
{
    if (!_IconLabel) {
        UILabel *IconLabel = [[UILabel alloc] init];
        IconLabel.font = [UIFont systemFontOfSize:25];
        IconLabel.textColor = [UIColor whiteColor];
        [self.view addSubview:IconLabel];
        UIImageView *imageview = [self.view viewWithTag:100];
        [IconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(imageview);
        }];
        _IconLabel = IconLabel;
    }
    return _IconLabel;
}
@end
