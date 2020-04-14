//
//  ListDetailViewController.m
//  MarkProject
//
//  Created by MAC on 2020/4/13.
//  Copyright © 2020 mac. All rights reserved.
//

#import "ListDetailViewController.h"
#import "NSString+Util.h"

@interface ListDetailViewController ()
@property (nonatomic, strong) UITextField *namefield;///<名称
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
    [self setupList];
//    [self setupContentView];
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
//        [self.view addSubview:self.MenuView];
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
    [self addtaprecognizerWith:self.isEdit];
    
}
-(void)setupList{
    UIView *iconbackView = [[UIView alloc] init];
    iconbackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:iconbackView];
    [iconbackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom);
        make.height.mas_equalTo(100);
    }];
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.tag =100;
    iconView.layer.cornerRadius = 5;
    iconView.layer.masksToBounds = YES;
    iconView.backgroundColor = rgba(68, 107, 255, 1);
    [self.view addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.centerY.mas_equalTo(iconbackView);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"用户名称";
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconView.mas_right).offset(10);
        make.bottom.mas_equalTo(iconView.mas_bottom).offset(-40);
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
        make.top.mas_equalTo(self.navigationView.mas_bottom).mas_offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"用户名称";
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
    nameField.text = self.model.Name;
    nameField.font = [UIFont systemFontOfSize:17];
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
    AccontLabel.text = @"用户名称";
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
    AccountField.text = self.model.Account;
    [self.view addSubview:AccountField];
    [AccountField addTarget:self action:@selector(Tap:) forControlEvents:UIControlEventTouchUpInside];
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
    PwdLabel.text = @"密码";
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
    PwdField.text = self.model.PassWord;
    [self.view addSubview:PwdField];
    [PwdField addTarget:self action:@selector(Tap:) forControlEvents:UIControlEventTouchUpInside];
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
    urlField.text = ![NSString isEmptyOfString:self.model.NameURL] ?self.model.NameURL:@"-";
    urlField.font = [UIFont systemFontOfSize:17];
    [urlField addTarget:self action:@selector(Tap:) forControlEvents:UIControlEventTouchUpInside];
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
    NoteField.text = [NSString isEmptyOfString:self.model.Note]?@"-":self.model.Note;
    [self.view addSubview:NoteField];
    [NoteField addTarget:self action:@selector(Tap:) forControlEvents:UIControlEventTouchUpInside];
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
    [self addtaprecognizerWith:NO];
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
-(void)Tap:(UITapGestureRecognizer *)sender
{
    
}

-(void)addtaprecognizerWith:(BOOL)isedit
{
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap:)];
//    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap:)];
//    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap:)];
//    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap:)];
//    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap:)];
//    if (isedit) {
//        [_namefield removeGestureRecognizer:tap1];
//        [_Accountfield removeGestureRecognizer:tap2];
//        [_Pwdfield removeGestureRecognizer:tap3];
//        [_Urlfield removeGestureRecognizer:tap4];
//        [_Notefield removeGestureRecognizer:tap5];
//    } else {
//        [_namefield addGestureRecognizer:tap1];
//        [_Accountfield addGestureRecognizer:tap2];
//        [_Pwdfield addGestureRecognizer:tap3];
//        [_Urlfield addGestureRecognizer:tap4];
//        [_Notefield addGestureRecognizer:tap5];
//    }
}
-(void)updateDB
{
    FMDatabase *db = [MDMethods openOrCreateDBWithDBName:@"SecretList.sqlite" Success:^{
        
    } Fail:^{
        return ;
    }];
//    //1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
//    //    BOOL result = [db executeUpdate:@"INSERT INTO SecretList (name, age, sex) VALUES (?,?,?)",name,@(age),sex];
//    //2.executeUpdateWithForamat：不确定的参数用%@，%d等来占位 （参数为原始数据类型，执行语句不区分大小写）
//    BOOL result = [db executeUpdateWithFormat:@"insert into SecretList (Name,NameURL,Account,PassWord,Note,CreateTime,UpdateTime,currentTime) values (%@,%@,%@,%@,%@,%@,%@,%@)",self.namefield.text,self.Urlfield.text,self.Accountfield.text,self.Pwdfield.text,self.Notefield.text,[MDMethods currentDateStr],[MDMethods currentDateStr],[MDMethods currentTimeStr]];
//    // 更改数据

    BOOL result2 = [db executeUpdateWithFormat:@"update SecretList set Name = %@,NameURL = %@,Account = %@,PassWord = %@,Note = %@,UpdateTime = %@,currentTime = %@ where id = %d",self.namefield.text,self.Urlfield.text,self.Accountfield.text,self.Pwdfield.text,self.Notefield.text,[MDMethods currentDateStr],[MDMethods currentTimeStr],self.model.secretID];
    if (result2) {
        NSLog(@"修改成功");
        self.dismissBlock();
    } else {
        NSLog(@"修改失败");
    }
}
@end
