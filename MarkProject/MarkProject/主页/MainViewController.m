//
//  MainViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2019/12/2.
//  Copyright © 2019 mac. All rights reserved.
//
/*
 日记 记账 节日/纪念日/倒计时/提醒 计划 备忘录
 */
#import "MainViewController.h"
#import "MainCollectionViewCell.h"
#import "NextViewController.h"
#import "SecretListViewController.h"
#import "DiaryViewController.h"
#import "SDCycleScrollView.h"
#import "SettingViewController.h"
#import "PlanViewController.h"
#import "BillViewController.h"
#import "MemoViewController.h"

@interface MainViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSArray *array;///<<#注释#>
@property (nonatomic, strong) UIView *MenuView;///<菜单
@property (nonatomic, assign) BOOL MenuOpen;///<菜单是否打开
@property (nonatomic, strong) NSArray *soulArray;///<毒鸡汤数组
@property (nonatomic, strong) UIView *BannerView;///<
@property (nonatomic, strong) UIView *ContentView;///<
@property (nonatomic, strong) UIView *SoulView;///<
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:TintColor];
    _array = @[@"账单",@"备忘录",@"计划",@"随想",@"密码本",@"设置"];//收藏夹（网页链接、微信文章等--支持本地打开和跳转浏览器）
    [self setNav];
    [self setupContentView];
    [self setupBanner];
    [self soulView];
}
#pragma mark  - ------  Nav  ------
-(void)setNav
{
    [self.navigationView setTitle:@"主页"];
    
    self.navigationView.backgroundView.image = nil ;
    self.navigationView.backgroundView.backgroundColor = TintColor;
    self.navigationView.lineView.backgroundColor = TintColor;
    
//    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"菜单"]];
//    [leftView addSubview:image];
//    [image mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(leftView);
//    }];
//    WeakBlock(self, weakSelf);
//    [self.navigationView addLeftView:leftView callback:^(UIView *view) {
//        [weakSelf Menu];
//    }];
//    [self.view addSubview:self.MenuView];
}

#pragma mark  - ------  头部-Banner  ------
-(void)setupBanner
{
    NSArray *imagesURLStrings = [NSArray array];
    imagesURLStrings = @[@"https://s1.ax1x.com/2020/04/08/GfCGWQ.png",@"https://s1.ax1x.com/2020/04/08/GfPxD1.png"];
    UIView *BannerView = [[UIView alloc] init];
    _BannerView = BannerView;
    BannerView.backgroundColor = rgba(255, 255, 255, 0.1);
    BannerView.layer.cornerRadius = 3;
    BannerView.hidden = (imagesURLStrings.count == 0);
    BannerView.layer.masksToBounds = YES;
    [self.view addSubview:BannerView];
    [BannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.bottom.mas_equalTo(self.ContentView.mas_top).offset(-30);
        make.height.mas_equalTo((SCREEN_WIDTH-20)*0.26);
    }];
    // 本地加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero shouldInfiniteLoop:YES imageNamesGroup:imagesURLStrings];
    cycleScrollView.delegate = self;
    cycleScrollView.placeholderImage = [UIImage imageWithColor:TintColor];
    cycleScrollView.autoScroll = (imagesURLStrings.count > 1);
    cycleScrollView.layer.masksToBounds = YES;
    cycleScrollView.layer.cornerRadius = 3;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    [BannerView addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    cycleScrollView.autoScrollTimeInterval = 4.0;
    [cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(BannerView);
    }];
}
#pragma mark  - ------  中部-功能视图  ------
-(void)setupContentView
{
    CGFloat width = (SCREEN_WIDTH-40-10)/3;
    CGFloat height = width *0.82;
    CGFloat lineoffset = 10;//间隔
    UIView *contetView = [[UIView alloc] init];
    _ContentView = contetView;
    [self.view addSubview:contetView];
    [contetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.center.mas_equalTo(self.view);
        make.height.mas_equalTo(height*3+20);
    }];
    /*
     注册 登录 个人管理 备忘录 账单 密码本 计划 日记（markdown）
     */
    
    UIView *view1 = [self setViewWtihTitle:@"账单" SubTitle:@"当日支出:100 当日收入:200" Tag:1001 BackColor:rgba(82, 154, 248, 1) Type:1];
    UIView *view2 = [self setViewWtihTitle:@"密码本" SubTitle:@"" Tag:1002 BackColor:rgba(117, 121, 143, 1) Type:2];
    UIView *view3 = [self setViewWtihTitle:@"日记" SubTitle:@"" Tag:1003 BackColor:rgba(95, 147, 132, 1) Type:2];
    UIView *view4 = [self setViewWtihTitle:@"备忘录" SubTitle:@"明天8:00上班" Tag:1004 BackColor:rgba(68, 107, 255, 1) Type:1];
    UIView *view5 = [self setViewWtihTitle:@"计划" SubTitle:@"" Tag:1005 BackColor:rgba(211, 163, 105, 1) Type:1];
    UIView *view6 = [self setViewWtihTitle:@"设置" SubTitle:@"" Tag:1006 BackColor:rgba(44, 44, 46, 1) Type:2];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contetView.mas_left);
        make.size.mas_equalTo(CGSizeMake(width*2, height));
        make.top.mas_equalTo(contetView.mas_top);
    }];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(contetView.mas_right);
        make.size.mas_equalTo(CGSizeMake(width, height));
        make.top.mas_equalTo(contetView.mas_top);
    }];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contetView.mas_left);
        make.size.mas_equalTo(CGSizeMake(width, height));
        make.top.mas_equalTo(view1.mas_bottom).offset(lineoffset);
    }];
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(contetView.mas_right);
        make.size.mas_equalTo(CGSizeMake(width*2, height));
        make.top.mas_equalTo(view1.mas_bottom).offset(lineoffset);
    }];
    [view5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contetView.mas_left);
        make.size.mas_equalTo(CGSizeMake(width*2, height));
        make.top.mas_equalTo(view3.mas_bottom).offset(lineoffset);
    }];
    [view6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(contetView.mas_right);
        make.size.mas_equalTo(CGSizeMake(width, height));
        make.top.mas_equalTo(view3.mas_bottom).offset(lineoffset);
    }];
    
}

#pragma mark  - ------  底部-毒鸡汤  ------
-(void)soulView
{
    UIView *soulView = [[UIView alloc] init];
    _SoulView = soulView;
    soulView.layer.masksToBounds = YES;
    soulView.layer.cornerRadius = 2;
    soulView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
    soulView.layer.borderWidth = 0.5;
    [self.view addSubview:soulView];
    [soulView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ContentView.mas_bottom).offset(30);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
    }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SoulClick)];
        [soulView addGestureRecognizer:tap];
    
    _soulArray = [self readLocalFileWithName:@"soul"];
    int num = arc4random_uniform(2020);
    NSDictionary *soulDic = _soulArray[num];
    UILabel *soul = [[UILabel alloc] init];
    soul.tag = 233;
    soul.text = [NSString stringWithFormat:@"       %@ — 毒鸡汤",soulDic[@"content"]];
    soul.numberOfLines = 0;
    soul.lineBreakMode = NSLineBreakByCharWrapping;
    soul.font = [UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:16];
    soul.textColor = [UIColor whiteColor];
    [soulView addSubview:soul];
    [soul mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(soulView.mas_top).offset(10);
        make.left.mas_equalTo(soulView.mas_left).offset(5);
        make.right.mas_equalTo(soulView.mas_right).offset(-5);
        make.bottom.mas_equalTo(soulView.mas_bottom).offset(-10);
    }];
    for(NSString *fontfamilyname in [UIFont familyNames])
    {
        NSLog(@"family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"-------------");
    }
}

#pragma mark  - ------  事件响应  ------
-(void)SoulClick
{
    UILabel *soul = [self.view viewWithTag:233];
    int num = arc4random_uniform(2020);
    NSDictionary *soulDic = _soulArray[num];
    soul.text = [NSString stringWithFormat:@"       %@ — 毒鸡汤",soulDic[@"content"]];
}
-(void)Menu{
    if (!_MenuOpen) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.frame = CGRectMake(SCREEN_WIDTH*0.8, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            //            self.MenuView.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.8, SCREEN_HEIGHT);
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            //            self.MenuView.frame = CGRectMake(-SCREEN_WIDTH*0.8, 0, SCREEN_WIDTH*0.8, SCREEN_HEIGHT);
        }];
    }
    _MenuOpen = !_MenuOpen;
}
-(void)functionTap:(UITapGestureRecognizer *)tap
{
    BillViewController *vc1 = [[BillViewController alloc] init];
    SecretListViewController *vc2 = [[SecretListViewController alloc] init];
    DiaryViewController *vc3 = [[DiaryViewController alloc] init];
    MemoViewController *vc4 = [[MemoViewController alloc] init];
    PlanViewController *vc5 = [[PlanViewController alloc] init];
    SettingViewController *vc6 = [[SettingViewController alloc] init];
    switch (tap.view.tag) {
        case 1001://账单
            [self.navigationController pushViewController:vc1 animated:YES];
            break;
        case 1002://密码本
            [self.navigationController pushViewController:vc2 animated:YES];
            break;
        case 1003://日记
            [self.navigationController pushViewController:vc3 animated:YES];
            break;
        case 1004://备忘录
            [self.navigationController pushViewController:vc4 animated:YES];
            break;
        case 1005://计划
            [self.navigationController pushViewController:vc5 animated:YES];
            break;
        case 1006://设置
            [self.navigationController pushViewController:vc6 animated:YES];
            break;
            
        default:
            break;
    }
}
#pragma mark  - ------  公共方法  ------
// 读取本地JSON文件
- (NSArray *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}
-(UIView *)setViewWtihTitle:(NSString *)title SubTitle:(NSString *)subtitle Tag:(int)tag BackColor:(UIColor *)color Type:(int)type
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    view.tag = tag;
    view.layer.cornerRadius = 3;
    view.layer.masksToBounds = YES;
    [self.view addSubview:view];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(functionTap:)]];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (![subtitle isEqualToString:@""]) {
            make.centerX.mas_equalTo(view);
            make.centerY.mas_equalTo(view).offset(-5);
        } else {
            make.center.mas_equalTo(view);
        }
    }];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:title]];
    iconView.alpha = 0.5;
    [view addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (type == 1) {
            make.left.mas_equalTo(view.mas_left).offset(10);
            make.top.mas_equalTo(view.mas_top).offset(10);
            make.size.mas_equalTo(((SCREEN_WIDTH-40-10)/3)*0.3);
        } else {
            make.right.mas_equalTo(view.mas_right).offset(((SCREEN_WIDTH-40-10)/3)*0.2);
            make.bottom.mas_equalTo(view.mas_bottom).offset(0);
            make.size.mas_equalTo(((SCREEN_WIDTH-40-10)/3)*0.7);
        }
    }];
    
    UILabel *subtitleLabel = [[UILabel alloc] init];
    subtitleLabel.text = subtitle;
    subtitleLabel.font = [UIFont systemFontOfSize:12];
    subtitleLabel.textColor = [UIColor whiteColor];
    [view addSubview:subtitleLabel];
    [subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.bottom.mas_equalTo(view.mas_bottom).offset(-15);
    }];
    return view;
}
#pragma mark  - ------  setter  ------
- (UIView *)MenuView
{
    if (!_MenuView) {
        _MenuView = [[UIView alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH*0.8, 0, SCREEN_WIDTH*0.8, SCREEN_HEIGHT)];
        _MenuView.backgroundColor = [UIColor whiteColor];
        
    }
    return _MenuView;
}

#pragma mark  - ------  SDCycleScrollViewDelegate  ------
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}
@end

