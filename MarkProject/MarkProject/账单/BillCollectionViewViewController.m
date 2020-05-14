//
//  BillCollectionViewViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/5/6.
//  Copyright © 2020 mac. All rights reserved.
//

#import "SetBillCollectionViewCell.h"
#import "BillCollectionViewViewController.h"

@interface BillCollectionViewViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation BillCollectionViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/5, SCREEN_WIDTH/5 + 30);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH) collectionViewLayout:layout];
        _collectionView.backgroundColor = GrayWhiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"SetBillCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SetBillCollectionViewCell"];
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SetBillCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SetBillCollectionViewCell" forIndexPath:indexPath];
    cell.tipImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
    cell.tipImageView.backgroundColor = [UIColor orangeColor];
    cell.tiplabel.text = self.dataArray[indexPath.row];
    if ([self.selectItemTitle isEqualToString:self.dataArray[indexPath.row]]) {
        cell.tiplabel.textColor = _type == income?rgba(53, 195, 126, 1):rgba(255, 115, 115, 1);
    } else {
        cell.tiplabel.textColor = [UIColor grayColor];
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectItemTitle = self.dataArray[indexPath.row];
    self.BillClickBlock(self.selectItemTitle);
    [self.collectionView reloadData];
}
@end
