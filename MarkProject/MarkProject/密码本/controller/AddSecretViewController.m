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
@property(nonatomic ,strong) UITextField * firstResponderTextF;//记录将要编辑的输入框
@end

@implementation AddSecretViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:GrayWhiteColor];
    [self setbar];
    [self setupContentView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)dealloc{
    //移除键盘通知监听者
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
-(void)setbar
{
    UIView *barView = [[UIView alloc] init];
    barView.backgroundColor = [MDInstance sharedInstance].themeColor;
    [self.view addSubview:barView];
    [barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
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
        make.top.mas_equalTo(self.view.mas_top).mas_offset(70);
        make.size.mas_equalTo(CGSizeMake(70, 70));
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
    nameField.returnKeyType = UIReturnKeyNext;
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
    AccontLabel.attributedText = [MDMethods ChangeNSMutabelAttributedString:@"*请输入您的帐户名" WithTargetValue:[UIColor redColor] AndTargetString:@"*"];
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
    AccountField.delegate = self;
    AccountField.returnKeyType = UIReturnKeyNext;
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
    PwdField.delegate = self;
    PwdField.returnKeyType = UIReturnKeyNext;
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
    urlField.delegate = self;
    urlField.returnKeyType = UIReturnKeyNext;
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
    NoteField.delegate = self;
    NoteField.returnKeyType = UIReturnKeyDone;
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
    if ([NSString isEmptyOfString:self.namefield.text]) {
        [MDMethods showTextMessage:@"名称不能为空"];
    } else if ([NSString isEmptyOfString:self.Accountfield.text]) {
        [MDMethods showTextMessage:@"帐户名不能为空"];
    } else if ([NSString isEmptyOfString:self.Pwdfield.text]) {
        [MDMethods showTextMessage:@"密码不能为空"];
    } else {
        FMDatabase *db = [MDMethods openOrCreateDBWithDBName:FMDBMainName Success:^{
            
        } Fail:^{
            return ;
        }];
        BOOL result = [db executeUpdate:@"insert into SecretList (Name,NameURL,Account,PassWord,Note,createdAt,updatedAt) values (?,?,?,?,?,?,?)",self.namefield.text,self.Urlfield.text,self.Accountfield.text,self.Pwdfield.text,self.Notefield.text,@([[MDMethods currentTimeStr] integerValue]),@([[MDMethods currentTimeStr] integerValue])];
        [db close];
        if (result) {
            NSLog(@"插入成功");
            self.dismissBlock();
        } else {
            NSLog(@"插入失败");
            return;
        }
        
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField != self.namefield) {
        return;
    }
    self.IconLabel.text = textField.text.length >= 2?[textField.text substringToIndex:2]:textField.text;
}
#pragma mark  - ------  fieldDelegate  ------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.namefield)
    {
        [self.Accountfield becomeFirstResponder];
    }else if (textField == self.Accountfield){
        [self.Pwdfield becomeFirstResponder];
    }
    else if (textField == self.Pwdfield){
        [self.Urlfield becomeFirstResponder];
    }
    else if (textField == self.Urlfield){
        [self.Notefield becomeFirstResponder];
    }
    else if (textField == self.Notefield){
        [self.view endEditing:YES];
    }
    
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.firstResponderTextF isFirstResponder])[self.firstResponderTextF resignFirstResponder];
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES]; //实现该方法是需要注意view需要是继承UIControl而来的
//}
#pragma maek UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.firstResponderTextF = textField;//当将要开始编辑的时候，获取当前的textField
    return YES;
}
#pragma mark : UIKeyboardWillShowNotification/UIKeyboardWillHideNotification
- (void)keyboardWillShow:(NSNotification *)notification{
    CGRect rect = [self.firstResponderTextF.superview convertRect:self.firstResponderTextF.frame toView:self.view];//获取相对于self.view的位置
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];//获取弹出键盘的fame的value值
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:self.view.window];//获取键盘相对于self.view的frame ，传window和传nil是一样的
    CGFloat keyboardTop = keyboardRect.origin.y;
    NSNumber * animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];//获取键盘弹出动画时间值
    NSTimeInterval animationDuration = [animationDurationValue doubleValue];
    if (keyboardTop < CGRectGetMaxY(rect)) {//如果键盘盖住了输入框
        CGFloat gap = keyboardTop - CGRectGetMaxY(rect) - 10;//计算需要网上移动的偏移量（输入框底部离键盘顶部为10的间距）
        __weak typeof(self)weakSelf = self;
        [UIView animateWithDuration:animationDuration animations:^{
            weakSelf.view.frame = CGRectMake(weakSelf.view.frame.origin.x, gap, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
        }];
    }
}
- (void)keyboardWillHide:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSNumber * animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];//获取键盘隐藏动画时间值
    NSTimeInterval animationDuration = [animationDurationValue doubleValue];
    if (self.view.frame.origin.y < 0) {//如果有偏移，当影藏键盘的时候就复原
        __weak typeof(self)weakSelf = self;
        [UIView animateWithDuration:animationDuration animations:^{
            weakSelf.view.frame = CGRectMake(weakSelf.view.frame.origin.x, 0, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
        }];
    }
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
