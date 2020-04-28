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

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;///<<#注释#>
@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) NSArray *ItemsArray;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _ItemsArray = @[@[@"主题",@"主题"],@[@"云同步",@"云同步"],@[@"毒鸡汤",@"毒鸡汤"],@[@"账单",@"账单"],@[@"密码本",@"密码本"],@[@"日记",@"日记"],@[@"备忘录",@"备忘录"],@[@"计划",@"计划"]];
    [self setNav];
    [self setupTableView];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.tableHeaderView setBackgroundColor:[MDInstance sharedInstance].themeColor];
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
    headImageView.image = ([MDInstance sharedInstance].headImage == nil)?[UIImage imageNamed:@"头像"]:[MDInstance sharedInstance].headImage;
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
    nameLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:21];
    nameLabel.textColor = GrayWhiteColor;
    [headView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headImageView.mas_top).offset(10);
        make.left.mas_equalTo(headImageView.mas_right).offset(15);
    }];
    UILabel *emailLabel = [[UILabel alloc] init];
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
    vc.NavTitle = _ItemsArray[indexPath.row][0];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)LoginOutBtn:(UIButton *)sender
{
    
}
-(void)headClick
{
    [self openImagePick];
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
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        self.headImageView.image = photos[0];
      [MDInstance sharedInstance].headImage = photos[0];
//        NSMutableString *base64 = [NSMutableString string];
//        NSData *imageData = UIImageJPEGRepresentation(photos[0], 1);
//        
//        [base64 appendString:[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]] ;
        
//        [self ReplyImageWithbase64:base64] ;
    }];
//    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

@end
