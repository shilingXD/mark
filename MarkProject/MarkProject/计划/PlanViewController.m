//
//  PlanViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "PlanViewController.h"
#import "PlanTableViewCell.h"
#import "AddPlanView.h"
#import "WMDragView.h"
@interface PlanViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableview;
@end

@implementation PlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    [self AddButton];
}
-(void)setNav
{
    [self.navigationView setTitle:@"计划"];
    self.view.backgroundColor = rgba(240, 240, 240, 1);
    self.navigationView.backgroundView.image = nil ;
    self.navigationView.backgroundView.backgroundColor = TintColor;
    self.navigationView.lineView.backgroundColor = TintColor;
    
    
}
-(void)AddButton
{
    WMDragView *dragView = [[WMDragView alloc] init];
    dragView.backgroundColor = rgba(85, 85, 85, 1);
    dragView.layer.masksToBounds = YES;
    dragView.layer.cornerRadius = 25;
    WeakBlock(self, weak_self);
    dragView.clickDragViewBlock = ^(WMDragView *dragView) {
        AddPlanView *view = [AddPlanView init];
        [GKCover coverFrom:self.view contentView:view style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleCenter hideAnimStyle:GKCoverHideAnimStyleCenter notClick:YES];
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = TintColor;
//    UIBezierPath *fieldPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5 , 5)];
//    CAShapeLayer *fieldLayer = [[CAShapeLayer alloc] init];
//    fieldLayer.frame = view.bounds;
//    fieldLayer.path = fieldPath.CGPath;
//    view.layer.mask = fieldLayer;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"2020年\n4月";
    timeLabel.numberOfLines = 2;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont fontWithName:@"PingFangSC-Thin" size: 14];
    timeLabel.textColor = [UIColor whiteColor];
    [view addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left);
        make.top.bottom.mas_equalTo(view);
        make.width.mas_equalTo(60);
    }];
    
    UIView *timeView = [[UIView alloc] init];
    [view addSubview:timeView];
    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(timeLabel.mas_right);
        make.right.mas_equalTo(view.mas_right);
        make.top.bottom.mas_equalTo(view);
    }];
    CGFloat width = (SCREEN_WIDTH-60)/24;
    for (int i = 0; i<24; i++) {
        UIView *line = [[UIView alloc] init];
        if (i%2 == 0) {
            line.frame = CGRectMake((width*i), 40, width, 10);
        } else {
            line.frame = CGRectMake((width*i), 30, width, 20);
        }
        
//        line.backgroundColor = RandomColor;
        [timeView addSubview:line];
        
        UIView *timeline = [[UIView alloc] init];
        timeline.backgroundColor = [UIColor whiteColor];
        [line addSubview:timeline];
        [timeline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(line);
            make.centerX.mas_equalTo(line);
            make.width.mas_equalTo(1);
        }];
        
        UILabel *hourLabel = [[UILabel alloc] init];
        hourLabel.text = [NSString stringWithFormat:@"%d\n时",i];
        hourLabel.numberOfLines = 2;
        hourLabel.textAlignment = NSTextAlignmentCenter;
        hourLabel.font = [UIFont fontWithName:@"PingFangSC-Thin" size: 9];
        hourLabel.textColor = [UIColor whiteColor];
        [timeView addSubview:hourLabel];
        [hourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(line.mas_top);
            make.centerX.mas_equalTo(line);
        }];

    }
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlanTableViewCell *cell = [PlanTableViewCell cellForTableview:tableView];
    cell.backgroundColor = RandomColor;
    cell.model.array = [NSMutableArray arrayWithArray:@[@[@"12:32",@"13:33"],@[@"8:00",@"9:30"],@[@"17:30",@"18:33"]]];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.rowHeight = UITableViewAutomaticDimension;
        _tableview.estimatedRowHeight = 100;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.sectionHeaderHeight = 50;
        [self.view addSubview:_tableview];
    }
    return _tableview;
}

@end
