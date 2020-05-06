//
//  SetBillViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/5/6.
//  Copyright © 2020 mac. All rights reserved.
//

#import "SetBillViewController.h"
#import "BKCKeyboard.h"
#import "BillCollectionViewViewController.h"
#define colorRed rgba(255, 115, 115, 1)

@interface SetBillViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) BKCKeyboard *keyboard;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *CostArray;
@property (nonatomic, strong) NSArray *IncomeArray;
@property (nonatomic, strong) UILabel *costlabel;///<收入
@property (nonatomic, strong) UILabel *incomeLabel;///<支出
@property (nonatomic, strong) UIView  *lineView;
@end

@implementation SetBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = GrayWhiteColor;
    [self setKeyBoard];
    [self setData];
    
    self.costlabel.hidden = NO;
    self.incomeLabel.hidden = NO;
    [self.view layoutIfNeeded];
    self.lineView.centerX = self.costlabel.centerX;
}
- (void)setNav
{
    [super setNav];
    [self.navigationView setTitle:@""];
    
}
-(void)setData
{
    _CostArray = @[@"三餐",@"服饰",@"捐赠",@"交通",@"其它",@"旅游",@"酒水",@"加油",@"娱乐",@"房租",@"兴趣爱好",@"购物",@"美妆",@"医疗",@"数码产品",@"教育"];
    _IncomeArray = @[@"工资",@"奖金",@"股票基金",@"其它"];
    
    BillCollectionViewViewController *vc = [[BillCollectionViewViewController alloc] init];
    vc.dataArray = _CostArray;
    vc.type = cost;
    [self addChildViewController:vc];
    [self.scrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.scrollView.height);
    
    BillCollectionViewViewController *vc2 = [[BillCollectionViewViewController alloc] init];
    vc2.dataArray = _IncomeArray;
    vc.type = income;
    [self addChildViewController:vc2];
    [self.scrollView addSubview:vc2.view];
    vc2.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollView.height);
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, SCREEN_HEIGHT-(SCREEN_WIDTH / 5 * 4 + TabbarSafeBottomMargin)-NavigationBar_Height);
}
-(void)setKeyBoard
{
    [self.keyboard show];
}
- (BKCKeyboard *)keyboard {
    if (!_keyboard) {
        _keyboard = [BKCKeyboard init];
        [_keyboard setComplete:^(NSString *price, NSString *mark, NSDate *date) {
//            [self createBookRequest:price mark:mark date:date];
        }];
        [self.view addSubview:_keyboard];
    }
    return _keyboard;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavigationBar_Height, SCREEN_WIDTH, SCREEN_HEIGHT-(SCREEN_WIDTH / 5 * 4 + TabbarSafeBottomMargin)-NavigationBar_Height)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}
- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = rgba(255, 115, 115, 1);
        _lineView.size = CGSizeMake(8, 5);
        _lineView.layer.cornerRadius = 2.5;
        _lineView.bottom = self.navigationView.bottom -2;
        [self.navigationView addSubview:_lineView];
    }
    return _lineView;
}
- (UILabel *)costlabel
{
    if (!_costlabel) {
        _costlabel = [[UILabel alloc] init];
        _costlabel.textColor = rgba(255, 115, 115, 1);
        _costlabel.textAlignment = NSTextAlignmentCenter;
        _costlabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
        _costlabel.text = @"支出";
        WeakBlock(self, weak_self);
        [self.navigationView addSubview:_costlabel callback:^(UIView *view) {
            [weak_self scrollWithFloat:0];
            [weak_self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }];
        [_costlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.navigationView).offset(-30);
            make.bottom.mas_equalTo(self.navigationView.mas_bottom).offset(-8);
            make.width.mas_equalTo(80);
        }];
    }
    return _costlabel;
}
- (UILabel *)incomeLabel
{
    if (!_incomeLabel) {
        _incomeLabel = [[UILabel alloc] init];
        _incomeLabel.textColor = [UIColor whiteColor];
        _incomeLabel.textAlignment = NSTextAlignmentCenter;
        _incomeLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
        _incomeLabel.text = @"收入";
        WeakBlock(self, weak_self);
        [self.navigationView addSubview:_incomeLabel callback:^(UIView *view) {
            [weak_self scrollWithFloat:1];
            [weak_self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
        }];
        [_incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.navigationView).offset(30);
            make.bottom.mas_equalTo(self.navigationView.mas_bottom).offset(-8);
            make.width.mas_equalTo(80);
        }];
    }
    return _incomeLabel;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetX = scrollView.contentOffset.x/SCREEN_WIDTH;
    [self scrollWithFloat:contentOffsetX];
}
-(void)scrollWithFloat:(float)sender
{
    self.incomeLabel.textColor = [UIColor whiteColor];
    self.costlabel.textColor = [UIColor whiteColor];
    if (sender >= 1) {
        self.lineView.centerX = self.incomeLabel.centerX;
        self.lineView.backgroundColor = rgba(255, 115, 115, 1);
        self.incomeLabel.textColor = rgba(255, 115, 115, 1);
    }else if (sender<=0){
        self.lineView.centerX = self.costlabel.centerX;
        self.lineView.backgroundColor = colorRed;
        self.costlabel.textColor = colorRed;
    }
}
@end
