//
//  BillViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BillViewController.h"
#import "WMDragView.h"
#import "BillTableViewCell.h"
#import "SetBillViewController.h"
#import "BillChartViewController.h"
#import "BillModel.h"
#import "BillDetailView.h"

@interface BillViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *selectDate;///<当前选择时间
@property (nonatomic, strong) UIButton *monthSelectBtn;///<月份选择按钮
@property (nonatomic, strong) UILabel *incomeLabel;///<月收入
@property (nonatomic, strong) UILabel *costLabel;///<月支出

@property (nonatomic, strong) NSMutableArray<BillModel *> *dataArray;///<数据数组
@property (nonatomic, strong) NSMutableArray<BillDayModel *> *dataDayArray;///<<#注释#>
@property (nonatomic, copy) NSDate *Date;///<选择的日期
@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setupTableView];
    [self AddButton];
}
-(void)setNav
{
    [self.navigationView setTitle:@"账单"];
    self.view.backgroundColor = rgba(240, 240, 240, 1);
    self.navigationView.backgroundView.image = nil ;
    self.navigationView.backgroundView.backgroundColor = [[MDInstance sharedInstance].themeColor colorWithAlphaComponent:0];
    self.navigationView.lineView.backgroundColor = [UIColor clearColor];
    self.Date = [NSDate date];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"统计"]];
    imageview.size = CGSizeMake(22, 22);
    imageview.center = rightView.center;
    [rightView addSubview:imageview];
    WeakBlock(self, weak_self);
    [self.navigationView addRightView:rightView clickCallback:^(UIView *view) {
        BillChartViewController *vc = [[BillChartViewController alloc] init];
        [weak_self.navigationController pushViewController:vc animated:YES];
    }];
}
-(void)setupTableView
{
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 60;
    _tableView.sectionHeaderHeight = 50;
    _tableView.backgroundColor = GrayWhiteColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    [_tableView registerNib:[UINib nibWithNibName:@"BillTableViewCell" bundle:nil] forCellReuseIdentifier:@"BillTableViewCell"];
    [self.view addSubview:_tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top);
    }];
    [self setupHeadView];
    [self reloadDataBase];
}
-(void)AddButton
{
    WMDragView *dragView = [[WMDragView alloc] init];
    dragView.backgroundColor = rgba(85, 85, 85, 1);
    dragView.layer.masksToBounds = YES;
    dragView.layer.cornerRadius = 25;
    dragView.clickDragViewBlock = ^(WMDragView *dragView) {
        [self newBillWithModel:nil];
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
-(void)setupHeadView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    
    headView.backgroundColor = [MDInstance sharedInstance].themeColor;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -(NavigationBar_Height-44), SCREEN_WIDTH, headView.height+(NavigationBar_Height-44))];
    imageView.backgroundColor = [MDInstance sharedInstance].themeColor;
    [headView addSubview:imageView];
    
    _monthSelectBtn = [[UIButton alloc] init];
    _monthSelectBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Thin" size:15];
    _monthSelectBtn.titleLabel.numberOfLines = 2;
    _monthSelectBtn.titleLabel.textColor = [UIColor whiteColor];
    [_monthSelectBtn addTarget:self action:@selector(selectMonth) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_monthSelectBtn];
    [_monthSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView.mas_left).mas_offset(30);
        make.bottom.mas_equalTo(headView.mas_bottom);
    }];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"三角形"]];
    [headView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.monthSelectBtn.mas_right);
        make.centerY.mas_equalTo(self.monthSelectBtn).offset(15);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    _incomeLabel = [[UILabel alloc] init];
    _incomeLabel.numberOfLines = 2;
    _incomeLabel.font = [UIFont fontWithName:@"PingFangSC-Thin" size:15];
    _incomeLabel.textColor = [UIColor whiteColor];
    [headView addSubview:_incomeLabel];
    [_incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.monthSelectBtn.mas_right).mas_offset(30);
        make.centerY.mas_equalTo(self.monthSelectBtn);
    }];
    _costLabel = [[UILabel alloc] init];
    _costLabel.numberOfLines = 2;
    _costLabel.font = [UIFont fontWithName:@"PingFangSC-Thin" size:15];
    _costLabel.textColor = [UIColor whiteColor];
    [headView addSubview:_costLabel];
    [_costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.incomeLabel.mas_right).mas_offset(20);
        make.centerY.mas_equalTo(self.monthSelectBtn);
    }];
    self.tableView.tableHeaderView = headView;
}
#pragma mark  - ------  代理  ------
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-30, 35)];
    UIBezierPath *fieldPath = [UIBezierPath bezierPathWithRoundedRect:sectionView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *fieldLayer = [[CAShapeLayer alloc] init];
    fieldLayer.frame = sectionView.bounds;
    fieldLayer.path = fieldPath.CGPath;
    sectionView.layer.mask = fieldLayer;
    sectionView.backgroundColor = [UIColor whiteColor];
    [sectionBackView addSubview:sectionView];
    UILabel *datelabel = [[UILabel alloc] init];
    datelabel.text = [MDMethods changeBillTimeDate:self.dataDayArray[section].dataString];
    datelabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:13];
    datelabel.textColor = [UIColor blackColor];
    [sectionView addSubview:datelabel];
    [datelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sectionView.mas_left).offset(15);
        make.centerY.mas_equalTo(sectionView);
    }];
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.text = [NSString stringWithFormat:@"收入：%@ 支出：%@",self.dataDayArray[section].income,self.dataDayArray[section].cost];
    detailLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:13];
    detailLabel.textColor = [UIColor blackColor];
    [sectionView addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(sectionView.mas_right).offset(-15);
        make.centerY.mas_equalTo(sectionView);
    }];
    return sectionBackView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BillTableViewCell"];
    cell.contentView.backgroundColor = GrayWhiteColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataDayArray[indexPath.section].dataArray[indexPath.row];
    cell.MyContentView.frame = CGRectMake(15, 0, SCREEN_WIDTH-30, 60);
    if (self.dataDayArray[indexPath.section].dataArray.count-1 == indexPath.row) {
       UIBezierPath *maskBezierPath = [UIBezierPath bezierPathWithRoundedRect:cell.MyContentView.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskShapeLayer = [[CAShapeLayer alloc]init];
        maskShapeLayer.frame = cell.MyContentView.bounds;
        maskShapeLayer.path = maskBezierPath.CGPath;
        cell.MyContentView.layer.mask = maskShapeLayer;
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataDayArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataDayArray[section].dataArray.count;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
 
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakBlock(self, weak_self);
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击了删除");
        [MDMethods showAlertWithTitle:@"确定删除这条记录？" SureTitle:@"确定" SureBlock:^{
            [weak_self deleteRow:weak_self.dataDayArray[indexPath.section].dataArray[indexPath.row]];
        } CancelTitle:@"取消" CancelBlock:^{
            
        }];
        
    }];
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击了编辑");
        [weak_self newBillWithModel:weak_self.dataDayArray[indexPath.section].dataArray[indexPath.row]];
    }];
    editAction.backgroundColor = rgba(53, 195, 126, 1);
    return @[deleteAction, editAction];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat rate = scrollView.contentOffset.y/100.0;
    self.navigationView.backgroundColor = [[MDInstance sharedInstance].themeColor colorWithAlphaComponent:rate];
}
#pragma mark  - ------  响应事件  ------
-(void)newBillWithModel:(BillModel *)model
{
    SetBillViewController *vc = [[SetBillViewController alloc] init];
    WeakBlock(self, weak_self);
    vc.SetBillBackBlock = ^{
        [weak_self reloadDataBase];
    };
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)selectMonth
{
    WeakBlock(self, weak_self);
    CXDatePickerView *datepicker = [[CXDatePickerView alloc] initWithDateStyle:CXDateYearMonth completeBlock:^(NSDate *selectDate) {
        weak_self.Date = selectDate;
        [weak_self reloadDataBase];
    }];
    datepicker.datePickerFont = [UIFont fontWithName:@"PingFangSC-Light" size:17];
    datepicker.dateLabelColor = TintColor;//年-月-日-时-分 颜色
    datepicker.datePickerColor = TintColor;//滚轮日期颜色
    datepicker.doneButtonColor = TintColor;//确定按钮的颜色
    datepicker.cancelButtonColor = datepicker.doneButtonColor;
    [datepicker show];
    
}
#pragma mark  - ------  FMDB操作  ------
-(void)reloadDataBase
{
    self.selectDate = [self.Date cx_stringWithFormat:@"yyyy-MM"];;
    FMDatabase *db = [MDMethods openOrCreateDBWithDBName:FMDBMainName Success:^{} Fail:^{return ;}];
    NSString *sql = [NSString stringWithFormat:@"select * FROM BillList where currentDateStr like '%@' order by currentDate desc",[self.selectDate stringByAppendingString:@"%"]];
    FMResultSet *rs = [db executeQuery:sql];
    self.dataArray = [NSMutableArray array];
    self.dataDayArray = [NSMutableArray array];
    while ([rs next]) {
        BillModel *model = [[BillModel alloc] init];
        model.BillID = [rs intForColumn:@"BillID"];
        model.type = [rs intForColumn:@"type"];
        model.money = [rs stringForColumn:@"money"];
        model.currentDateStr = [rs stringForColumn:@"currentDateStr"];
        model.mark = [rs stringForColumn:@"mark"];
        model.name = [rs stringForColumn:@"name"];
        model.currentDate = [rs stringForColumn:@"currentDate"];
        [self.dataArray addObject:model];
        
        BillDayModel *dayModel = [[BillDayModel alloc] init];
        dayModel.dataString = [rs stringForColumn:@"currentDateStr"];
        [self.dataDayArray addObject:dayModel];
    }
  //去重
    for (int i = 0; i < self.dataDayArray.count; i++) {
        for (int j = i+1; j < self.dataDayArray.count; j++) {
            if ([[self.dataDayArray[i] dataString] isEqualToString:[self.dataDayArray[j] dataString]]) {
                [self.dataDayArray removeObject:self.dataDayArray[j]];
            }
        }
    }
    for (int i = 0; i < self.dataDayArray.count; i++) {
        for (int j = i+1; j < self.dataDayArray.count; j++) {
            if ([[self.dataDayArray[i] dataString] isEqualToString:[self.dataDayArray[j] dataString]]) {
                [self.dataDayArray removeObject:self.dataDayArray[j]];
            }
        }
    }
    //导入每天的数据
    for (BillDayModel *dayModel in self.dataDayArray) {
        for (BillModel *model in self.dataArray) {
            if ([dayModel.dataString containsString:model.currentDateStr]) {
                if (model.type == 1) {
                    dayModel.income = [dayModel.income decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:model.money]];
                } else {
                    dayModel.cost = [dayModel.cost decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:model.money]];
                }
                [dayModel.dataArray addObject:model];
            }
        }
    }
    
    [self.tableView reloadData];
    NSString *month = [NSString stringWithFormat:@"%zd",self.Date.month];
    NSString *year = [NSString stringWithFormat:@"%zd",self.Date.year];
    NSString *monthCost = [NSString stringWithFormat:@"%@",[self.dataDayArray valueForKeyPath:@"@sum.cost"]];
    NSString *monthIncome = [NSString stringWithFormat:@"%@",[self.dataDayArray valueForKeyPath:@"@sum.income"]];
    
    
    _incomeLabel.attributedText = [MDMethods ChangeNSMutabelAttributedString:[NSString stringWithFormat:@"收入\n%@",monthIncome] WithTargetValue:[UIFont fontWithName:@"PingFangSC-Thin" size:30] AndTargetString:monthIncome];
    _costLabel.attributedText = [MDMethods ChangeNSMutabelAttributedString:[NSString stringWithFormat:@"支出\n%@",monthCost] WithTargetValue:[UIFont fontWithName:@"PingFangSC-Thin" size:30] AndTargetString:monthCost];
    [_monthSelectBtn setAttributedTitle:[MDMethods ChangeNSMutabelAttributedString:[NSString stringWithFormat:@"%@年\n%@月",year,month] WithTargetValue:[UIFont fontWithName:@"PingFangSC-Thin" size:30] AndTargetString:month] forState:UIControlStateNormal];
}
- (void)deleteRow:(BillModel *)delobject {
    FMDatabase *db = [MDMethods openOrCreateDBWithDBName:FMDBMainName Success:^{} Fail:^{
        return ;
    }];
    NSString *sql = @"delete from BillList where BillID = ?";
    BillModel *model = delobject;
    BOOL result = [db executeUpdate:sql, @(model.BillID)];
    if (!result) {
        [MDMethods showTextMessage:@"删除失败"];
        return;
    }
    [db close];
    [self reloadDataBase];
}
@end
