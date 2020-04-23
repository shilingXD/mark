//
//  SettingViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;///<<#注释#>
@property (nonatomic, strong) UIImageView *headImageView;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setupTableView];
}
-(void)setNav
{
    [self.navigationView setTitle:@"设置"];
    self.view.backgroundColor = TintColor;
    self.navigationView.backgroundView.image = nil ;
    self.navigationView.backgroundView.backgroundColor = TintColor;
    self.navigationView.lineView.backgroundColor = TintColor;
    
}
-(void)setupTableView
{
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 50;
    _tableView.bounces = NO;
    _tableView.backgroundColor = rgba(240, 240, 240, 1);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom);
    }];
    [self setupHeadView];
}

-(void)setupHeadView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    headView.backgroundColor = TintColor;
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
    headImageView.backgroundColor = TintColor;
    headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    headImageView.layer.borderWidth = 2;
    headImageView.image = [MDMethods stringToImage:[MDInstance sharedInstance].UserheadimageBase64];
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
    nameLabel.text = @"点击头像登陆";
    nameLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:21];
    nameLabel.textColor = GrayWhiteColor;
    [headView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headImageView.mas_top).offset(2);
        make.left.mas_equalTo(headImageView.mas_right).offset(15);
    }];
    
    
    self.tableView.tableHeaderView = headView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = rgba(240, 240, 240, 1);
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"选项";
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
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
      [MDInstance sharedInstance].UserheadimageBase64 = [MDMethods imageToString:photos[0]];
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
