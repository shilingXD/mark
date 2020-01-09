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

@interface MainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSArray *array;///<<#注释#>
@end

@implementation MainViewController
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
//}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:TintColor];
    [self createContentView];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    backBtn.title = @"返回";
    self.navigationItem.backBarButtonItem = backBtn;
    _array = @[@"账单",@"备忘录",@"计划",@"随想",@"密码本",@"设置"];//收藏夹（网页链接、微信文章等--支持本地打开和跳转浏览器）
}
-(void)createContentView
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.estimatedItemSize = CGSizeMake(SCREEN_WIDTH/4, SCREEN_WIDTH/4);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*0.24);
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(40,0,SCREEN_WIDTH-80,SCREEN_HEIGHT) collectionViewLayout:layout];
    
    //注册cell
    [_mainCollectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"MainCollectionViewCell"];
    _mainCollectionView.dataSource = self;
    _mainCollectionView.delegate=self;
    _mainCollectionView.bounces = YES;
    _mainCollectionView.backgroundColor = [UIColor clearColor];
    _mainCollectionView.pagingEnabled = YES;
    _mainCollectionView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:_mainCollectionView];
    
}
#pragma mark  - ------  UIcollection代理方法  ------
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCollectionViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = _array[indexPath.row];
 
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
         SecretListViewController *vc = [[SecretListViewController alloc] init];
           [self.navigationController pushViewController:vc animated:YES];
    } else {
         NextViewController *vc = [[NextViewController alloc] init];
           [self.navigationController pushViewController:vc animated:YES];
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

@end
