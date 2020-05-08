//
//  SuiXiangViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/3/31.
//  Copyright © 2020 mac. All rights reserved.
//

#import "DiaryViewController.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "SuiXiangCollectionViewCell.h"
#import "WMDragView.h"
#import "NextViewController.h"
#import "FIREditPageVC.h"
#import "NewfileView.h"
#import "MDModel.h"
#import "MDEditViewController.h"
#import "DocumentViewController.h"

@interface DiaryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;///<<#注释#>
@property (nonatomic, strong) NSMutableArray *dataArray;///<<#注释#>
@property (nonatomic, strong) UIImageView *emptyView;///<无数据暂未图
@end

@implementation DiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgba(240, 240, 240, 1);
    [self setupNav];
    [self setupView];
    [self AddButton];
    [self getMDList];
}
-(void)setupNav
{
    [self.navigationView setTitle:@"随笔"];
    self.navigationView.backgroundView.image = nil ;
    self.navigationView.backgroundView.backgroundColor = [MDInstance sharedInstance].themeColor;
    self.navigationView.lineView.backgroundColor = [MDInstance sharedInstance].themeColor;
}
-(void)setupView
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.top.mas_equalTo(self.navigationView.mas_bottom);
    }];
}
-(void)AddButton
{
    WMDragView *dragView = [[WMDragView alloc] init];
    dragView.backgroundColor = rgba(85, 85, 85, 1);
    dragView.layer.masksToBounds = YES;
    dragView.layer.cornerRadius = 25;
    dragView.clickDragViewBlock = ^(WMDragView *dragView) {
        [self popSelectedView];
    };
    [self.view addSubview:dragView];
    [dragView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.right.mas_equalTo(self.view).offset(-25);
        make.bottom.mas_equalTo(self.view).offset(-25);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"增加"]];
    [dragView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(dragView);
    }];
    
    
}
-(void)popSelectedView
{
    UIView *popView = [[UIView alloc] init];
    popView.backgroundColor = [UIColor whiteColor];
    UIButton *createFileBtn = [[UIButton alloc] init];
    createFileBtn.tag = 100;
    [createFileBtn  setImage:[[UIImage imageNamed:@"文件"] changeColor:TintColor] forState:UIControlStateNormal];
    [createFileBtn addTarget:self action:@selector(createClick:) forControlEvents:UIControlEventTouchUpInside];
    [popView addSubview:createFileBtn];
    [createFileBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(popView);
        make.left.mas_equalTo(popView.mas_left).offset((SCREEN_WIDTH/2-70)/2);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"新建文件";
    label1.textColor =TintColor;
    label1.font =[UIFont systemFontOfSize:12];
    [popView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(createFileBtn);
        make.top.mas_equalTo(createFileBtn.mas_bottom).mas_offset(5);
    }];
    
    UIButton *createMDFileBtn = [[UIButton alloc] init];
    createMDFileBtn.tag = 200;
    [createMDFileBtn  setImage:[[UIImage imageNamed:@"文件夹"] changeColor:TintColor] forState:UIControlStateNormal];
    [createMDFileBtn addTarget:self action:@selector(createClick:) forControlEvents:UIControlEventTouchUpInside];
    [popView addSubview:createMDFileBtn];
    [createMDFileBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(popView);
        make.right.mas_equalTo(popView.mas_right).offset(-((SCREEN_WIDTH/2-70)/2));
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"新建文件夹";
    label2.textColor =TintColor;
    label2.font =[UIFont systemFontOfSize:12];
    [popView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(createMDFileBtn);
        make.top.mas_equalTo(createMDFileBtn.mas_bottom).mas_offset(5);
    }];
    
    popView.gk_size = CGSizeMake(SCREEN_WIDTH, 200);
    [GKCover coverFrom:self.view contentView:popView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleBottom showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleBottom notClick:NO showBlock:^{
        
    } hideBlock:^{
        
    }];
}
-(void)createClick:(UIButton *)btn
{
    [GKCover hide];
    NewfileView *view = [NewfileView init];
    if (btn.tag == 100) {
        view.TitleLbal.text = @"新建文件";
        view.Type = @"1";
        
    } else {
        view.TitleLbal.text = @"新建文件夹";
        view.Type = @"2";
    }
    view.FilePath = @"";
    WeakBlock(self, weak_self);
    view.reloadBlock = ^{
        [weak_self getMDList];
    };
    [GKCover coverFrom:self.view contentView:view style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleCenter hideAnimStyle:GKCoverHideAnimStyleCenter notClick:NO];
}
#pragma mark  - ------  getter  ------
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewLeftAlignedLayout *leftLayout = [[UICollectionViewLeftAlignedLayout alloc] init];
        CGFloat width = (SCREEN_WIDTH-45)/2;
        leftLayout.itemSize = CGSizeMake(width, width*1.2);
        leftLayout.minimumLineSpacing = 15;
        leftLayout.minimumInteritemSpacing = 15;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15,NavigationBar_Height, SCREEN_WIDTH-30, SCREEN_HEIGHT- NavigationBar_Height) collectionViewLayout:leftLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[SuiXiangCollectionViewCell class] forCellWithReuseIdentifier:@"SuiXiangCollectionViewCell"];
        _collectionView.backgroundColor = rgba(240, 240, 240, 1);
        [self.view addSubview:_collectionView];
        
        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
        layout.sectionInset =UIEdgeInsetsMake(0,0, 0, 0);
        layout.headerReferenceSize =CGSizeMake(SCREEN_WIDTH,15);//头视图大小
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    return _collectionView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SuiXiangCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SuiXiangCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MDModel *model = self.dataArray[indexPath.row];
    if ([model.Type isEqualToString:@"1"]) {
        MDEditViewController *vc = [[MDEditViewController alloc] init];
        vc.titlestr = model.Title;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        DocumentViewController *vc = [[DocumentViewController alloc] init];
        vc.DocumentTitle = model.Title;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"forIndexPath:indexPath];
    header.backgroundColor = rgba(240, 240, 240, 1);
    return header;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 15);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 15);
}
-(void)getMDList
{
    FMDatabase *db = [MDMethods openOrCreateDBWithDBName:FMDBMainName Success:^{} Fail:^{
        return ;
    }];
    NSString *createTableSqlString = @"CREATE TABLE IF NOT EXISTS MDList (MDID integer PRIMARY KEY AUTOINCREMENT, Title text NOT NULL, Type text NOT NULL, FilePath text, StoragePath text, CreateTime text NOT NULL, UpdateTime text NOT NULL, CurrentTime integer NOT NULL)";
    [db executeUpdate:createTableSqlString];
    NSString *sql = @"select  MDID,Title,Type,FilePath,StoragePath,CreateTime,UpdateTime,currentTime FROM MDList Where FilePath == ''";
    FMResultSet *rs = [db executeQuery:sql];
    _dataArray = [NSMutableArray array];
    while ([rs next]) {
        MDModel *model = [[MDModel alloc] init];
        model.MDID = [rs intForColumn:@"MDID"];
        model.Title = [rs stringForColumn:@"Title"];
        model.Type = [rs stringForColumn:@"Type"];
        model.FilePath = [rs stringForColumn:@"FilePath"];
        model.StoragePath = [rs stringForColumn:@"StoragePath"];
        model.CreateTime = [rs stringForColumn:@"CreateTime"];
        model.UpdateTime = [rs stringForColumn:@"UpdateTime"];
        model.currentTime = [rs stringForColumn:@"currentTime"];
        [self.dataArray addObject:model];
    }
    [self.collectionView reloadData];
    self.emptyView.hidden = self.dataArray.count != 0;
}
- (UIImageView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"暂无数据"]];
        [self.collectionView addSubview:_emptyView];
        [_emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*0.3, SCREEN_WIDTH*0.3));
        }];
    }
    return _emptyView;
}
@end
