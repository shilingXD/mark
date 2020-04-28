//
//  BillViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BillViewController.h"

@interface BillViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *monthSelectBtn;///<月份选择按钮
@property (nonatomic, strong) UILabel *incomeLabel;///<月收入
@property (nonatomic, strong) UILabel *costLabel;///<月支出
@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setupTableView];
}
-(void)setNav
{
    [self.navigationView setTitle:@"账单"];
    self.view.backgroundColor = rgba(240, 240, 240, 1);
    self.navigationView.backgroundView.image = nil ;
    self.navigationView.backgroundView.backgroundColor = [TintColor colorWithAlphaComponent:0];
    self.navigationView.lineView.backgroundColor = [UIColor clearColor];
}
-(void)setupTableView
{
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 50;
    _tableView.backgroundColor = GrayWhiteColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top);
    }];
    [self setupHeadView];
}

-(void)setupHeadView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    
    headView.backgroundColor = [MDInstance sharedInstance].themeColor;
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(headView.frame.size.width, 0)];
//    [path addLineToPoint:CGPointMake(0, 0)];
//    [path addLineToPoint:CGPointMake(0, headView.frame.size.height)];
//    [path addQuadCurveToPoint:CGPointMake(headView.frame.size.width, headView.frame.size.height*0.6) controlPoint:CGPointMake(headView.frame.size.width*0.7, headView.frame.size.height)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
//    maskLayer.frame=headView.bounds;
//    maskLayer.path= path.CGPath;
//    headView.layer.mask= maskLayer;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -(NavigationBar_Height-44), SCREEN_WIDTH, headView.height+(NavigationBar_Height-44))];
    imageView.backgroundColor = [UIColor orangeColor];
    [headView addSubview:imageView];
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
    return 25;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat rate = scrollView.contentOffset.y/100.0;
    self.navigationView.backgroundColor = [TintColor colorWithAlphaComponent:rate];
}
@end
