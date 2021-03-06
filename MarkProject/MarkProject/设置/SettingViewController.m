//
//  SettingViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "CustomSettingViewController.h"
#import "LoginViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;///<<#注释#>
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *NameLabel;///<用户名
@property (nonatomic, strong) UILabel *emailLabel;///<邮箱
@property (nonatomic, strong) UIButton *LoginOutBtn;///<退出button
@property (nonatomic, strong) UILabel *upLoadLabel;///<云同步事件
@property (nonatomic, strong) NSArray *ItemsArray;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _ItemsArray = @[@[@"主题",@"主题"],@[@"云同步",@"云同步"],@[@"毒鸡汤",@"毒鸡汤"],@[@"账单",@"账单"],@[@"密码本",@"密码本"],@[@"随笔",@"随笔"],@[@"便签",@"便签"],@[@"计划",@"计划"]];
    [self setNav];
    [self setupTableView];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.tableHeaderView setBackgroundColor:[MDInstance sharedInstance].themeColor];
    if ([MDInstance sharedInstance].isLogin) {
        if ([MDInstance sharedInstance].headImage) {
            self.headImageView.image = [MDInstance sharedInstance].headImage;
        } else {
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[MDInstance sharedInstance].headImageURL] placeholderImage:[UIImage imageNamed:@"头像"] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image){
                    [MDInstance sharedInstance].headImage = image;
                   }else{
                       //something went wrong
                   }
            }];
        }
        self.NameLabel.text = [MDInstance sharedInstance].UserName;
        self.emailLabel.text = [MDInstance sharedInstance].Email;
        self.LoginOutBtn.hidden = NO;
    }else{
        self.headImageView.image = [UIImage imageNamed:@"头像"];
        self.NameLabel.text = @"未登录";
        self.emailLabel.text = @"请点击头像登录";
        self.LoginOutBtn.hidden = YES;
    }
}
-(void)setNav
{
    [self.navigationView setTitle:@"设置"];
    self.navigationView.backgroundView.image = nil ;
    self.navigationView.backgroundView.backgroundColor = [MDInstance sharedInstance].themeColor;
    self.navigationView.lineView.backgroundColor = [MDInstance sharedInstance].themeColor;
    
}
-(void)setupTableView
{
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 50;
    _tableView.bounces = NO;
    _tableView.backgroundColor = GrayWhiteColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"SettingTableViewCell" bundle:nil] forCellReuseIdentifier:@"SettingTableViewCell"];
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom);
    }];
    [self setupHeadView];
    [self setupFootView];
}

-(void)setupHeadView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    headView.backgroundColor = [MDInstance sharedInstance].themeColor;
    [self.view addSubview:headView];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(headView.frame.size.width, 0)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, headView.frame.size.height)];
    [path addQuadCurveToPoint:CGPointMake(headView.frame.size.width, headView.frame.size.height*0.6) controlPoint:CGPointMake(headView.frame.size.width*0.7, headView.frame.size.height)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame=headView.bounds;
    maskLayer.path= path.CGPath;
    headView.layer.mask= maskLayer;
    
    UIImageView *headImageView = [[UIImageView alloc] init];
    self.headImageView = headImageView;
    headImageView.backgroundColor = [UIColor grayColor];
    headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    headImageView.layer.borderWidth = 2;
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 75/2;
    [headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick)]];
    headImageView.userInteractionEnabled = YES;
    [headView addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(75, 75));
        make.left.mas_equalTo(headView.mas_left).offset(20);
        make.top.mas_equalTo(headView.mas_top).offset(20);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"时零";
    self.NameLabel = nameLabel;
    nameLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:21];
    nameLabel.textColor = GrayWhiteColor;
    [headView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headImageView.mas_top).offset(10);
        make.left.mas_equalTo(headImageView.mas_right).offset(15);
    }];
    UILabel *emailLabel = [[UILabel alloc] init];
    self.emailLabel = emailLabel;
    emailLabel.text = @"邮箱：ling_shi_dong@163.com";
    emailLabel.font = [UIFont fontWithName:@"PingFang SC" size:13];
    emailLabel.textColor = GrayWhiteColor;
    [headView addSubview:emailLabel];
    [emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(headImageView.mas_bottom).offset(-15);
        make.left.mas_equalTo(headImageView.mas_right).offset(15);
    }];
    
    UIButton *LoginOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, SCREEN_WIDTH-30, 50)];
    [LoginOutBtn setImage:[UIImage imageNamed:@"退出登录"] forState:UIControlStateNormal];
    LoginOutBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    LoginOutBtn.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:13];
    [LoginOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [LoginOutBtn addTarget:self action:@selector(LoginOutBtn:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:LoginOutBtn];
    [LoginOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 50));
        make.centerY.mas_equalTo(headImageView);
        make.right.mas_equalTo(headView.mas_right);
    }];
    [self.view layoutIfNeeded];
    LoginOutBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 0);
    LoginOutBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.tableView.tableHeaderView = headView;
}
-(void)setupFootView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    footView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:footView];
    self.tableView.tableFooterView = footView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = rgba(240, 240, 240, 1);
    cell.titleLabel.text = [NSString stringWithFormat:@"   %@",_ItemsArray[indexPath.row][0]];
    cell.iconImage.image = [[UIImage imageNamed:_ItemsArray[indexPath.row][1]] changeColor:rgba(12, 14, 40, 1)];
    if ([_ItemsArray[indexPath.row][0] isEqualToString:@"毒鸡汤"]) {
        cell.stateSwitch.hidden = NO;
        [cell.stateSwitch setOn:[MDInstance sharedInstance].isOpenSoul];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.stateSwitch.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if ([_ItemsArray[indexPath.row][1] isEqualToString:@"云同步"]) {
        [cell addSubview:self.upLoadLabel];
        [self.upLoadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cell.mas_right).offset(-20);
            make.centerY.mas_equalTo(cell);
        }];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.SwitchBlock = ^(BOOL isOn) {
        [MDInstance sharedInstance].isOpenSoul = isOn;
    };
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ItemsArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomSettingViewController *vc = [[CustomSettingViewController alloc] init];
   
    
    switch (indexPath.row) {
        case 0:
             vc.NavTitle = _ItemsArray[indexPath.row][0];
            [self.navigationController pushViewController:vc animated:YES];
            break;
            case 1:
            [self upLoadData];
            break;
        default:
            break;
    }
}
-(void)LoginOutBtn:(UIButton *)sender
{
    [MDMethods clearAllUserDefaultsData];
    [MDInstance sharedInstance].isLogin = NO;
    [self viewWillAppear:YES];
    [MDInstance sharedInstance].themeColor = TintColor;
    [MDMethods clearAllUserDefaultsData];
}
-(void)headClick
{
    if ([MDInstance sharedInstance].isLogin) {
        [self openImagePick];
    } else {
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)openImagePick
{         
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.isSelectOriginalPhoto = YES;
    [imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }];
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowCameraLocation = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.sortAscendingByModificationDate = YES;
    imagePickerVc.allowTakePicture = YES;
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    imagePickerVc.showSelectedIndex = NO;
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = YES;
    imagePickerVc.needCircleCrop = YES;
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 5;
    NSInteger widthHeight = self.view.width - 2 * left;
    NSInteger top = (self.view.height - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    imagePickerVc.scaleAspectFillCrop = YES;
    imagePickerVc.needCircleCrop = YES;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        self.headImageView.image = photos[0];
        if (![[MDInstance sharedInstance].headImage isEqual:photos[0]]) {
            [MDInstance sharedInstance].headImage = photos[0];
            [self upLoadHeadImage];
        }
        
        [MDInstance setNSUserDefaults];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
-(void)upLoadHeadImage
{
    BmobObject *user = [BmobObject objectWithoutDataWithClassName:@"UserList" objectId:[MDInstance sharedInstance].objectID];
//    [user setObject:[MDMethods imageToString:] forKey:@"user_image"];
    [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        NSLog(@"%@",@(isSuccessful));
    }];
    NSData *data = UIImagePNGRepresentation([MDInstance sharedInstance].headImage);
    BmobObject *obj = [BmobObject objectWithoutDataWithClassName:@"UserList" objectId:[MDInstance sharedInstance].objectID];
    BmobFile *file = [[BmobFile alloc]initWithFileName:[NSString stringWithFormat:@"user%@_head_image.png",obj.objectId] withFileData:data];
    
    [file saveInBackground:^(BOOL isSuccessful, NSError *error) {
    //如果文件保存成功，则把文件添加到filetype列
    if (isSuccessful) {
    //上传文件的URL地址
    [obj setObject:file.url  forKey:@"user_head_image"];
    //此处相当于新建一条记录,         //关联至已有的记录请使用 [obj updateInBackground];
    [obj updateInBackground];
    }else{
    //进行处理
    }
    }];
}
#pragma mark  - ------  懒加载  ------
- (UILabel *)upLoadLabel
{
    if (!_upLoadLabel) {
        _upLoadLabel = [[UILabel alloc] init];
        NSInteger time = [[NSUserDefaults standardUserDefaults] integerForKey:@"upLoadTime"];
        _upLoadLabel.text = time?[@"上次同步时间:" stringByAppendingString:[MDMethods changeTimeDate:[MDMethods getDateStringWithTimeStr:[NSString stringWithFormat:@"%zd",time]]]]:@"尚未同步";
        _upLoadLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        _upLoadLabel.textColor = [UIColor grayColor];
    }
    return _upLoadLabel;
}
#pragma mark  - ------  事件响应  ------
-(void)upLoadData
{
    self.upLoadLabel.text = @"正在同步...";
    BmobObject *user = [BmobObject objectWithoutDataWithClassName:@"UserList" objectId:[MDInstance sharedInstance].objectID];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"UserList"];
    WeakBlock(self, weak_self);
    [bquery getObjectInBackgroundWithId:user.objectId block:^(BmobObject *object,NSError *error){
        if ([[NSString stringWithFormat:@"%@",[object objectForKey:@"user_data_updated"]] integerValue]>[[NSUserDefaults standardUserDefaults] integerForKey:@"upLoadTime"]) {
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[object objectForKey:@"user_data"]]];
        //        //写入文件
                [data writeToFile:[DocumentsDirectoryPath stringByAppendingPathComponent:FMDBMainName] atomically:YES];
                [[NSUserDefaults standardUserDefaults] setInteger:[[MDMethods currentTimeStr] integerValue]  forKey:@"upLoadTime"];
            } else {
                
                NSData *data = [NSData dataWithContentsOfFile:[DocumentsDirectoryPath stringByAppendingPathComponent:FMDBMainName]];
                BmobObject *obj = [BmobObject objectWithoutDataWithClassName:@"UserList" objectId:[MDInstance sharedInstance].objectID];
                BmobFile *file = [[BmobFile alloc]initWithFileName:@"MarkProject.sqlite" withFileData:data];
                
                [file saveInBackground:^(BOOL isSuccessful, NSError *error) {
                    //如果文件保存成功，则把文件添加到filetype列
                    if (isSuccessful) {
                        [[NSUserDefaults standardUserDefaults] setInteger:[[MDMethods currentTimeStr] integerValue]  forKey:@"upLoadTime"];
                        //上传文件的URL地址
                        [obj setObject:file.url  forKey:@"user_data"];
                        //此处相当于新建一条记录,         //关联至已有的记录请使用 [obj updateInBackground];
                        [obj updateInBackground];
                    }else{
                        //进行处理
                    }
                }];
            }
    NSInteger time = [[NSUserDefaults standardUserDefaults] integerForKey:@"upLoadTime"];
        weak_self.upLoadLabel.text = [@"上次同步时间:" stringByAppendingString:[MDMethods changeTimeDate:[MDMethods getDateStringWithTimeStr:[NSString stringWithFormat:@"%zd",time]]]];
    [user setObject:@([[MDMethods currentTimeStr] integerValue]) forKey:@"user_data_updated"];
    //    [user setObject:[MDMethods imageToString:] forKey:@"user_image"];
    [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        NSLog(@"%@",@(isSuccessful));
    }];
    
    }];
//    WeakBlock(self, weak_self);
    
    
}

@end
