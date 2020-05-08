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

@interface ListDetailViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *NameView;
@property (nonatomic, strong) UIImageView *iconImage;///<iocn视图
@property (nonatomic, strong) UILabel *IconLabel;///<icon中的标题
@property (nonatomic, strong) UITextField *namefield;///<名称
@property (nonatomic, strong) UIView *AccountView;///<<#注释#>
@property (nonatomic, strong) UITextField *Accountfield;///<账号
@property (nonatomic, strong) UIView *PwdView;///<<#注释#>
@property (nonatomic, strong) UITextField *Pwdfield;///<密码
@property (nonatomic, strong) UIView *UrlView;///<<#注释#>
@property (nonatomic, strong) UITextField *Urlfield;///<网址
@property (nonatomic, strong) UIView *NoteView;///<<#注释#>
@property (nonatomic, strong) UITextField *Notefield;///<备注
@property (nonatomic, strong) UILabel *editLabel;///<编辑label
@property (nonatomic, assign) BOOL isEdit;///<是否编辑

@property(nonatomic ,strong) UITextField * firstResponderTextF;//记录将要编辑的输入框
@end

@implementation ListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavitem];
    [self setupListOne];
    [self setupListTwo];
    [self setupListThree];
    [self setupFooter];
    
}

-(void)setNavitem
{
    [self.navigationView setTitle:@""];
    self.view.backgroundColor = rgba(240, 240, 240, 1);
    self.navigationView.backgroundView.image = nil ;
    self.navigationView.backgroundView.backgroundColor = [MDInstance sharedInstance].themeColor;
    self.navigationView.lineView.backgroundColor = [MDInstance sharedInstance].themeColor;
    
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
    _NameView = [[UIView alloc] init];
    _NameView.backgroundColor = [UIColor whiteColor];
    _NameView.tag = 100;
    [_NameView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap:)]];
    [self.view addSubview:_NameView];
    [_NameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom);
        make.height.mas_equalTo(90);
    }];
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.layer.cornerRadius = 5;
    self.iconImage = iconView;
    iconView.layer.masksToBounds = YES;
    iconView.backgroundColor = rgba(68, 107, 255, 1);
    [self.view addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.centerY.mas_equalTo(self.NameView);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    self.IconLabel.text = self.model.Name.length >= 2?[self.model.Name substringToIndex:2]:self.model.Name;
    UITextField *nameField = [[UITextField alloc] init];
    self.namefield = nameField;
    nameField.enabled = NO;
    nameField.borderStyle = UITextBorderStyleNone;
    nameField.placeholder = @"名称";
    nameField.returnKeyType = UIReturnKeyNext;
    nameField.delegate = self;
    nameField.text = self.model.Name;
    nameField.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    nameField.textColor = inputColor;
    [self.view addSubview:nameField];
    [nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconView.mas_right).offset(10);
        make.right.mas_equalTo(self.NameView.mas_right);
        make.centerY.mas_equalTo(iconView).mas_offset(-10);
        make.height.mas_equalTo(30);
    }];
    UILabel *tiplabel = [[UILabel alloc] init];
    tiplabel.text = @"名称";
    tiplabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
    tiplabel.textColor = rgba(130, 136, 156, 1);
    [self.NameView addSubview:tiplabel];
    [tiplabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconView.mas_right).offset(10);
        make.right.mas_equalTo(self.NameView.mas_right);
        make.centerY.mas_equalTo(iconView).mas_offset(10);
        make.height.mas_equalTo(30);
    }];
    UIView *lineview = [[UIView alloc] init];
    lineview.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:lineview];
    [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.NameView);
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
        make.top.mas_equalTo(self.NameView.mas_bottom).offset(15);
    }];
    _AccountView = [[UIView alloc] init];
    _AccountView.backgroundColor = [UIColor whiteColor];
    _AccountView.tag = 200;
    [_AccountView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap:)]];
    [self.view addSubview:_AccountView];
    [_AccountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.NameView.mas_bottom).offset(15);
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
    _Accountfield = [[UITextField alloc] init];
    _Accountfield.enabled = NO;
    _Accountfield.borderStyle = UITextBorderStyleNone;
    _Accountfield.placeholder = @"帐户名";
    _Accountfield.returnKeyType = UIReturnKeyNext;
    _Accountfield.delegate = self;
    _Accountfield.text = self.model.Account;
    _Accountfield.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    _Accountfield.textColor = inputColor;
    [self.view addSubview:_Accountfield];
    [_Accountfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(BackView.mas_right);
        make.top.mas_equalTo(tiplabel1.mas_bottom);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(self.AccountView.mas_bottom).offset(-10);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.AccountView);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.height.mas_equalTo(1);
    }];
    
    _PwdView = [[UIView alloc] init];
    _PwdView.backgroundColor = [UIColor whiteColor];
    _PwdView.tag = 300;
    [_PwdView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap:)]];
    [self.view addSubview:_PwdView];
    [_PwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.AccountView.mas_bottom).offset(10);
        make.bottom.mas_equalTo(BackView.mas_bottom);
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
    
    _Pwdfield = [[UITextField alloc] init];
    _Pwdfield.enabled = NO;
    _Pwdfield.borderStyle = UITextBorderStyleNone;
    _Pwdfield.placeholder = @"密码";
    _Pwdfield.returnKeyType = UIReturnKeyNext;
    _Pwdfield.delegate = self;
    _Pwdfield.text = self.model.PassWord;
    _Pwdfield.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    _Pwdfield.textColor = inputColor;
    [self.view addSubview:_Pwdfield];
    [_Pwdfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(BackView.mas_right);
        make.top.mas_equalTo(tiplabel2.mas_bottom);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(self.PwdView.mas_bottom).offset(-10);
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
        make.top.mas_equalTo(self.PwdView.mas_bottom).offset(15);
    }];
    _UrlView = [[UIView alloc] init];
    _UrlView.backgroundColor = [UIColor whiteColor];
    _UrlView.tag = 400;
    [_UrlView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap:)]];
    [self.view addSubview:_UrlView];
    [_UrlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(BackView.mas_top);
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
    _Urlfield = [[UITextField alloc] init];
    _Urlfield.enabled = NO;
    _Urlfield.returnKeyType = UIReturnKeyNext;
    _Urlfield.delegate = self;
    _Urlfield.borderStyle = UITextBorderStyleNone;
    _Urlfield.placeholder = @"网址";
    _Urlfield.text = self.model.NameURL;
    _Urlfield.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    _Urlfield.textColor = inputColor;
    [self.view addSubview:_Urlfield];
    [_Urlfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(BackView.mas_right);
        make.top.mas_equalTo(tiplabel1.mas_bottom);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(self.UrlView.mas_bottom).offset(-10);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.UrlView);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.height.mas_equalTo(1);
    }];
    _NoteView = [[UIView alloc] init];
    _NoteView.backgroundColor = [UIColor whiteColor];
    _NoteView.tag = 500;
    [_NoteView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap:)]];
    [self.view addSubview:_NoteView];
    [_NoteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.UrlView.mas_bottom).offset(10);
        make.bottom.mas_equalTo(BackView.mas_bottom);
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
    
    _Notefield = [[UITextField alloc] init];
    _Notefield.enabled = NO;
    _Notefield.borderStyle = UITextBorderStyleNone;
    _Notefield.placeholder = @"备注";
    _Notefield.returnKeyType = UIReturnKeyDone;
    _Notefield.delegate = self;
    _Notefield.text = self.model.Note;
    _Notefield.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    _Notefield.textColor = inputColor;
    [self.view addSubview:_Notefield];
    [_Notefield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(BackView.mas_right);
        make.top.mas_equalTo(tiplabel2.mas_bottom);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(self.NoteView.mas_bottom).offset(-11);
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
        make.top.mas_equalTo(self.NoteView.mas_bottom).offset(20);
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
#pragma mark  - ------  懒加载  ------
- (UILabel *)IconLabel
{
    if (!_IconLabel) {
        UILabel *IconLabel = [[UILabel alloc] init];
        IconLabel.font = [UIFont systemFontOfSize:25];
        IconLabel.textColor = [UIColor whiteColor];
        [self.view addSubview:IconLabel];
        [IconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.iconImage);
        }];
        _IconLabel = IconLabel;
    }
    return _IconLabel;
}
#pragma mark  - ------  事件响应  ------
-(void)Tap:(UITapGestureRecognizer *)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    switch (sender.view.tag) {
        case 100:
            
            break;
        case 200:
            [MDMethods showTextMessage:@"账号已复制到剪切板"];
            pasteboard.string = self.Accountfield.text;
            break;
        case 300:
            [MDMethods showTextMessage:@"密码已复制到剪切板"];
            pasteboard.string = self.Pwdfield.text;
            break;
        case 400:
            if (![NSString isEmptyOfString:self.Urlfield.text]) {
                [MDMethods showTextMessage:@"网址已复制到剪切板"];
                pasteboard.string = self.Urlfield.text;
            }
            break;
        case 500:
            
            break;
            
        default:
            break;
    }
}
-(void)editList
{
    self.isEdit = !self.isEdit;
    _namefield.enabled = !_namefield.enabled;
    _Accountfield.enabled = !_Accountfield.enabled;
    _Pwdfield.enabled = !_Pwdfield.enabled;
    _Urlfield.enabled = !_Urlfield.enabled;
    _Notefield.enabled = !_Notefield.enabled;
    if (self.isEdit) {
        [self.namefield becomeFirstResponder];
        self.editLabel.text = @"完成";
        
    } else {
        if ([NSString isEmptyOfString:self.namefield.text]) {
            [MDMethods showTextMessage:@"名称不能为空"];
        } else if ([NSString isEmptyOfString:self.Accountfield.text]) {
            [MDMethods showTextMessage:@"帐户名不能为空"];
        } else if ([NSString isEmptyOfString:self.Pwdfield.text]) {
            [MDMethods showTextMessage:@"密码不能为空"];
        } else {
            [self.view endEditing:YES];
            self.editLabel.text = @"编辑";
            [self updateDB];
        }
    }
    
}

-(void)updateDB
{
    FMDatabase *db = [MDMethods openOrCreateDBWithDBName:FMDBMainName Success:^{
        
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

#pragma mark  - ------  fieldDelegate  ------
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.IconLabel.text = self.namefield.text.length >= 2?[_namefield.text substringToIndex:2]:_namefield.text;
}
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
    [super keyboardWillShow:notification];
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
    [super keyboardWillHide:notification];
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
@end
