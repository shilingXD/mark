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

@interface MainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSArray *array;///<<#注释#>
@property (nonatomic, strong) UIView *MenuView;///<菜单
@property (nonatomic, assign) BOOL MenuOpen;///<菜单是否打开
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:TintColor];
    [self createContentView];
    _array = @[@"账单",@"备忘录",@"计划",@"随想",@"密码本",@"设置"];//收藏夹（网页链接、微信文章等--支持本地打开和跳转浏览器）
    [self.navigationView setTitle:@"首页"];
    
    self.navigationView.backgroundView.image = nil ;
    self.navigationView.backgroundView.backgroundColor = TintColor;
    self.navigationView.lineView.backgroundColor = TintColor;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"菜单"]];
    [leftView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(leftView);
    }];
    WeakBlock(self, weakSelf);
    [self.navigationView addLeftView:leftView callback:^(UIView *view) {
        [weakSelf Menu];
    }];
[self.view addSubview:self.MenuView];
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
    } else if(indexPath.row == 3){
         SuiXiangViewController *vc = [[SuiXiangViewController alloc] init];
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

#pragma mark  - ------  setter  ------
- (UIView *)MenuView
{
    if (!_MenuView) {
        _MenuView = [[UIView alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH*0.8, 0, SCREEN_WIDTH*0.8, SCREEN_HEIGHT)];
        _MenuView.backgroundColor = [UIColor whiteColor];
        
    }
    return _MenuView;
}
@end
