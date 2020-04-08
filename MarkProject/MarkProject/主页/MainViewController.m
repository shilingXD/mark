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
#import "SuiXiangViewController.h"
#import "SDCycleScrollView.h"

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
    cycleScrollView.autoScroll = (imagesURLStrings.count >= 1)?YES:NO;
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
    
    UIView *view1 = [self setViewWtihTitle:@"账单" SubTitle:@"当日支出:100 当日收入:200" Tag:1001 BackColor:rgba(82, 154, 248, 1)];
    UIView *view2 = [self setViewWtihTitle:@"密码本" SubTitle:@"" Tag:1002 BackColor:rgba(117, 121, 143, 1)];
    UIView *view3 = [self setViewWtihTitle:@"日记" SubTitle:@"" Tag:1003 BackColor:rgba(11, 1, 1, 1)];
    UIView *view4 = [self setViewWtihTitle:@"备忘录" SubTitle:@"明天8:00上班" Tag:1004 BackColor:rgba(11, 1, 1, 1)];
    UIView *view5 = [self setViewWtihTitle:@"计划" SubTitle:@"" Tag:1005 BackColor:rgba(11, 1, 1, 1)];
    UIView *view6 = [self setViewWtihTitle:@"设置" SubTitle:@"" Tag:1006 BackColor:rgba(11, 1, 1, 1)];
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
-(UIView *)setViewWtihTitle:(NSString *)title SubTitle:(NSString *)subtitle Tag:(int)tag BackColor:(UIColor *)color
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    view.layer.cornerRadius = 3;
    view.layer.masksToBounds = YES;
    [self.view addSubview:view];
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

