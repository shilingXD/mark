//
//  SuiXiangViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/3/31.
//  Copyright © 2020 mac. All rights reserved.
//

#import "SuiXiangViewController.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "SuiXiangCollectionViewCell.h"

@interface SuiXiangViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;///<<#注释#>
@end

@implementation SuiXiangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgba(240, 240, 240, 1);
    [self.navigationView setTitle:@"随想"];
    self.navigationView.backgroundView.image = nil ;
    self.navigationView.backgroundView.backgroundColor = TintColor;
    self.navigationView.lineView.backgroundColor = TintColor;
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
        leftLayout.estimatedItemSize = CGSizeMake(width, width*1.26);
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
    
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"forIndexPath:indexPath];;
    header.backgroundColor = rgba(240, 240, 240, 1);
//    if (indexPath.section ==0) {
//        labelOne.text =@"热门检查";
//        labelOne.font = [UIFontsystemFontOfSize:14.0f];
//        labelOne.textColor =MainRGB;
//        [header addSubview:labelOne];
//    }else{
//        labelTwo.text =@"疾病信息";
//        labelTwo.font = [UIFontsystemFontOfSize:14.0f];
//        labelTwo.textColor =MainRGB;
//        [header addSubview:labelTwo];
//    }
    return header;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 15);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, 15);
}
@end
