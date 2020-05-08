//
//  PlanViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "PlanViewController.h"
#import "PlanTableViewCell.h"
#import "AddPlanNameView.h"
#import "WMDragView.h"
#import "PlanModel.h"
#import "PlanSortModel.h"
@interface PlanViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray<PlanModel *> *dataArray;///<<#注释#>
@property (nonatomic, strong) NSMutableArray<PlanSortModel *> *sortArray;///<<#注释#>
@property (nonatomic, strong) NSMutableArray *MonthArray;///<月数组
@property (nonatomic, strong) NSMutableArray *MonthIndexArray;///<月索引数组
@property (nonatomic, strong) NSMutableDictionary *DayDic;///<日数组
@property (nonatomic, strong) NSMutableArray *DayIndexArray;///<日索引数组
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
    [self getPlanList];
}
-(void)setNav
{
    [self.navigationView setTitle:@"计划"];
    self.view.backgroundColor = rgba(240, 240, 240, 1);
    self.navigationView.backgroundView.image = nil ;
    self.navigationView.backgroundView.backgroundColor = [MDInstance sharedInstance].themeColor;
    self.navigationView.lineView.backgroundColor = [MDInstance sharedInstance].themeColor;
    
    
}
-(void)AddButton
{
    WMDragView *dragView = [[WMDragView alloc] init];
    dragView.backgroundColor = rgba(85, 85, 85, 1);
    dragView.layer.masksToBounds = YES;
    dragView.layer.cornerRadius = 25;
    WeakBlock(self, weak_self);
    dragView.clickDragViewBlock = ^(WMDragView *dragView) {
        AddPlanNameView *view = [AddPlanNameView init];
        [GKCover coverFrom:weak_self.view contentView:view style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleCenter hideAnimStyle:GKCoverHideAnimStyleCenter notClick:YES];
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
    view.backgroundColor = [MDInstance sharedInstance].themeColor;
//    UIBezierPath *fieldPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5 , 5)];
//    CAShapeLayer *fieldLayer = [[CAShapeLayer alloc] init];
//    fieldLayer.frame = view.bounds;
//    fieldLayer.path = fieldPath.CGPath;
//    view.layer.mask = fieldLayer;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    NSString *monthstr = self.MonthIndexArray[section];
    timeLabel.text = [NSString stringWithFormat:@"%@年\n%@月",[monthstr substringToIndex:4],[monthstr substringWithRange:NSMakeRange(5,2)]];
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
    NSMutableArray *array = self.DayIndexArray[indexPath.section];
    NSString *dayStr = [NSString stringWithFormat:@"%@",array[indexPath.row]];
    cell.daylabel.text = [NSString stringWithFormat:@"%@日",[dayStr substringWithRange:NSMakeRange(8, 2)]];
//    cell.planTimeArray = self.DayDic[[NSString stringWithFormat:@"%ld-%ld",indexPath.section,indexPath.row]];
    [cell getArray:self.DayDic[[NSString stringWithFormat:@"%ld-%ld",indexPath.section,indexPath.row]]];
      
    if (indexPath.row%2 == 0) {
        cell.backgroundColor = [UIColor hexStringToColor:@"617FDE" andAlpha:1];
    } else {
        cell.backgroundColor = [UIColor hexStringToColor:@"617FDE" andAlpha:0.5];
    }
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.MonthIndexArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *array = self.DayIndexArray[section];
    return array.count;
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
-(void)getPlanList
{
    FMDatabase *db = [MDMethods openOrCreateDBWithDBName:FMDBMainName Success:^{} Fail:^{
        return ;
    }];
    NSString *sql = @"select  PlanID,PlanTitle,PlanDayDate,PlanItemBeginDate,priority,PlanItemEndDate,currentTime FROM PlanList";
    FMResultSet *rs = [db executeQuery:sql];
    _dataArray = [NSMutableArray array];
    _sortArray = [NSMutableArray array];
    _MonthArray = [NSMutableArray array];
    _MonthIndexArray = [NSMutableArray array];
    _DayIndexArray = [NSMutableArray array];
    _DayDic = [NSMutableDictionary dictionary];
    while ([rs next]) {
        PlanModel *model = [[PlanModel alloc] init];
        model.PlanID = [rs intForColumn:@"PlanID"];
        model.priority = [rs intForColumn:@"priority"];
        model.PlanTitle = [rs stringForColumn:@"PlanTitle"];
        model.PlanDayDate = [rs stringForColumn:@"PlanDayDate"];
        model.PlanItemBeginDate = [rs intForColumn:@"PlanItemBeginDate"];
        model.PlanItemEndDate = [rs intForColumn:@"PlanItemEndDate"];
        model.currentTime = [rs stringForColumn:@"currentTime"];
        [self.dataArray addObject:model];
    }
    self.MonthIndexArray = [self gatMonthArray:self.dataArray];
    for (int i = 0; i<self.MonthIndexArray.count; i++) {
        NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *indexarray = [NSMutableArray array];
        for (int j = 0; j<self.dataArray.count; j++) {
            PlanModel *model = self.dataArray[j];
            if ([model.PlanDayDate containsString:self.MonthIndexArray[i]]) {
                [array addObject:model];
                [indexarray addObject:model.PlanDayDate];
            }
        }
        [self.MonthArray addObject:array];
        NSOrderedSet *orderSet = [NSOrderedSet orderedSetWithArray:indexarray];
               NSArray *newindexarray = [orderSet array];
        [self.DayIndexArray addObject:[NSMutableArray arrayWithArray:newindexarray]];
    }
    self.DayDic  = [self setDayDicWithArray:self.DayIndexArray];
    [self.tableview reloadData];
    NSLog(@"sda");
}
- (NSMutableArray<PlanModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray<PlanSortModel *> *)sortArray
{
    if (!_sortArray) {
        _sortArray = [NSMutableArray array];
    }
    return _sortArray;
}
- (NSMutableArray *)MonthArray
{
    if (!_MonthArray) {
        _MonthArray = [NSMutableArray array];
    }
    return _MonthArray;
}
- (NSMutableArray *)MonthIndexArray
{
    if (!_MonthIndexArray) {
        _MonthIndexArray = [NSMutableArray array];
    }
    return _MonthIndexArray;
}
- (NSMutableArray *)DayIndexArray
{
    if (!_DayIndexArray) {
        _DayIndexArray = [NSMutableArray array];
    }
    return _DayIndexArray;
}
- (NSMutableDictionary *)DayDic
{
    if (!_DayDic) {
        _DayDic = [NSMutableDictionary dictionary];
    }
    return _DayDic;
}
//获取有序不重复月索引数组
- (NSMutableArray *)gatMonthArray:(NSMutableArray<PlanModel *> *)dataArr{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<dataArr.count; i++) {
        PlanModel *model = dataArr[i];
        [array addObject:[model.PlanDayDate substringToIndex:7]];
        
    }
    NSOrderedSet *orderSet = [NSOrderedSet orderedSetWithArray:array];
        NSArray *newArray = [orderSet array];
        NSLog(@"%@", newArray);

    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"self"
                                                               ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [newArray sortedArrayUsingDescriptors:descriptors];
    
  return [NSMutableArray arrayWithArray:reverseOrder];
}
//获取有序不重复日索引数组
- (NSMutableDictionary *)setDayDicWithArray:(NSMutableArray *)dataArr{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
   for (int i = 0; i<dataArr.count; i++) {
       NSArray *array = dataArr[i];
       for (int j = 0; j<array.count; j++) {
           NSMutableArray *mutaArray = [NSMutableArray array];
           for (int x = 0; x<self.dataArray.count; x++) {
               if ([array[j] isEqual:[self.dataArray[x] PlanDayDate]]) {
                   [mutaArray addObject:self.dataArray[x]];
               }
           }
           [dic setValue:mutaArray forKey:[NSString stringWithFormat:@"%d-%d",i,j]];
       }
   }
    return dic;
}

@end
