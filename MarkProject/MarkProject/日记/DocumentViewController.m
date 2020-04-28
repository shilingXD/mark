//
//  DocumentViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import "DocumentViewController.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "SuiXiangCollectionViewCell.h"
#import "MDModel.h"
#import "MDEditViewController.h"

@interface DocumentViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;///<<#注释#>
@property (nonatomic, strong) NSMutableArray *dataArray;///<<#注释#>
@property (nonatomic, strong) UIImageView *emptyView;///<无数据暂未图

@end

@implementation DocumentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgba(240, 240, 240, 1);
    [self setupNav];
    [self setupView];
    [self getMDList];
}

-(void)setupNav
{
    [self.navigationView setTitle:_DocumentTitle];
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
    FMDatabase *db = [MDMethods openOrCreateDBWithDBName:@"MarkProject.sqlite" Success:^{} Fail:^{
        return ;
    }];
    NSString *sql = [NSString stringWithFormat:@"select  MDID,Title,Type,FilePath,StoragePath,CreateTime,UpdateTime,currentTime FROM MDList Where FilePath == %@",self.DocumentTitle];
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
