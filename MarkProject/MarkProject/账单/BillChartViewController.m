//
//  BillChartViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/5/6.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BillChartViewController.h"
#import <AAChartKit.h>

@interface BillChartViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;///<<#注释#>
@property (nonatomic, strong) UIView *headView;///<<#注释#>
@property (nonatomic, strong) UILabel *allMoney;///<<#注释#>
@property (nonatomic, strong) UILabel *inComeLabel;///<注释
@property (nonatomic, strong) UILabel *costLabel;///<注释
@property (nonatomic, strong) UILabel *sumLabel;///<<#注释#>
@property (nonatomic, strong) UILabel *dayAvgLabel;///<<#注释#>

@property (nonatomic, strong) UIView *contentView;///<<#注释#>

@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (nonatomic, strong) AAChartView  *aaChartView;
@property (nonatomic, strong) NSDate *date;///<<#注释#>
@property (nonatomic, strong) NSArray *costArray;///<<#注释#>
@property (nonatomic, strong) NSArray *inComeArray;///<<#注释#>

@end

@implementation BillChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = GrayWhiteColor;
    [self setScrollView];
    [self reloadDataBase];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.view layoutIfNeeded];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.headView.height+self.contentView.height+50);
}
- (void)setNav
{
    [super setNav];
    [self.navigationView setTitle:@""];
    UIButton * _monthSelectBtn = [[UIButton alloc] init];
    _monthSelectBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC" size:15];
    [_monthSelectBtn setTitle:[NSString stringWithFormat:@"%zd年%zd月",self.date.year,self.date.month] forState:UIControlStateNormal];
    _monthSelectBtn.titleLabel.textColor = [UIColor whiteColor];
    [_monthSelectBtn addTarget:self action:@selector(selectMonth) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:_monthSelectBtn];
    [_monthSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.navigationView.titleLabel);
    }];
    UILabel *right = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    right.text = @"添加资产";
    right.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    right.textColor = [UIColor whiteColor];
    [self.navigationView addRightView:right callback:^(UIView *view) {
        [self setPopUpView];
    }];
}
-(void)setScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavigationBar_Height, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_Height)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollEnabled = YES;
    _scrollView.userInteractionEnabled = YES;
    [self.view addSubview:_scrollView];
    [self setHeadView];
}
-(void)setHeadView
{
    UIView *headView = [[UIView alloc] init];
    self.headView = headView;
    headView.layer.cornerRadius = 5;
    headView.layer.masksToBounds = YES;
    headView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView.mas_bottom).offset(15);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
    }];
    
    UILabel *allMoney = [[UILabel alloc] init];
    self.allMoney = allMoney;
    allMoney.textAlignment = NSTextAlignmentCenter;
    allMoney.numberOfLines = 2;
    allMoney.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    allMoney.textColor = [UIColor blackColor];
    allMoney.attributedText = [MDMethods ChangeNSMutabelAttributedString:@"总资产\n20202元" TargetFonts:[UIFont fontWithName:@"PingFangSC-Light" size:13] TargetColors:[UIColor lightGrayColor] AndTargetString:@"总资产"];
    [headView addSubview:allMoney];
    [allMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headView);
        make.top.mas_equalTo(headView.mas_top).offset(5);
    }];
    
    UILabel *inComeLabel = [[UILabel alloc] init];
    inComeLabel.numberOfLines = 2;
    self.inComeLabel = inComeLabel;
    inComeLabel.textAlignment = NSTextAlignmentCenter;
    inComeLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    inComeLabel.textColor = [UIColor blackColor];
    inComeLabel.attributedText = [MDMethods ChangeNSMutabelAttributedString:@"月收入\n20202元" TargetFonts:[UIFont fontWithName:@"PingFangSC-Light" size:13] TargetColors:[UIColor lightGrayColor] AndTargetString:@"月收入"];
    [headView addSubview:inComeLabel];
    [inComeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView.mas_left);
        make.width.mas_equalTo((SCREEN_WIDTH-30)/2);
        make.top.mas_equalTo(allMoney.mas_bottom).offset(5);
    }];
    UILabel *costLabel = [[UILabel alloc] init];
    self.costLabel = costLabel;
    costLabel.numberOfLines = 2;
    costLabel.textAlignment = NSTextAlignmentCenter;
    costLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    costLabel.textColor = [UIColor blackColor];
    costLabel.attributedText = [MDMethods ChangeNSMutabelAttributedString:@"月支出\n2020元" TargetFonts:[UIFont fontWithName:@"PingFangSC-Light" size:13] TargetColors:[UIColor lightGrayColor] AndTargetString:@"月支出"];
    [headView addSubview:costLabel];
    [costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headView.mas_right);
        make.width.mas_equalTo((SCREEN_WIDTH-30)/2);
        make.top.mas_equalTo(allMoney.mas_bottom).offset(5);
    }];
    UILabel *sumLabel = [[UILabel alloc] init];
    self.sumLabel = sumLabel;
    sumLabel.numberOfLines = 2;
    sumLabel.textAlignment = NSTextAlignmentCenter;
    sumLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    sumLabel.textColor = [UIColor blackColor];
    sumLabel.attributedText = [MDMethods ChangeNSMutabelAttributedString:@"月结余\n2102元" TargetFonts:[UIFont fontWithName:@"PingFangSC-Light" size:13] TargetColors:[UIColor lightGrayColor] AndTargetString:@"月结余"];
    [headView addSubview:sumLabel];
    [sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView.mas_left);
        make.width.mas_equalTo((SCREEN_WIDTH-30)/2);
        make.top.mas_equalTo(inComeLabel.mas_bottom).offset(5);
    }];
    UILabel *dayAvgLabel = [[UILabel alloc] init];
    self.dayAvgLabel = dayAvgLabel;
    dayAvgLabel.numberOfLines = 2;
    dayAvgLabel.textAlignment = NSTextAlignmentCenter;
    dayAvgLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    dayAvgLabel.textColor = [UIColor blackColor];
    dayAvgLabel.attributedText = [MDMethods ChangeNSMutabelAttributedString:@"日平均支出\n2102元" TargetFonts:[UIFont fontWithName:@"PingFangSC-Light" size:13] TargetColors:[UIColor lightGrayColor] AndTargetString:@"日平均支出"];
    [headView addSubview:dayAvgLabel];
    [dayAvgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headView.mas_right);
        make.width.mas_equalTo((SCREEN_WIDTH-30)/2);
        make.top.mas_equalTo(inComeLabel.mas_bottom).offset(5);
        make.bottom.mas_equalTo(headView.mas_bottom).offset(-5);
    }];
    [self setContentView];
}
-(void)setContentView
{
    UIView *contentView = [[UIView alloc] init];
    self.contentView = contentView;
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 5;
    contentView.layer.masksToBounds = YES;
    [self.scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headView.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
    }];
    
    
    self.aaChartView = [[AAChartView alloc]init];
    self.aaChartView.scrollEnabled = NO;
    [contentView addSubview:self.aaChartView];
    
    [self.aaChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(contentView);
        make.height.mas_equalTo(450);
        make.bottom.mas_equalTo(contentView.mas_bottom).offset(-15);
    }];
    UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:@[@"支出",@"收入"]];
    control.selectedSegmentIndex = 0;
    control.frame = CGRectMake((SCREEN_WIDTH-30)/2-50, 15, 100, 30);
    [control addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
    [contentView addSubview:control];
}
-(void)segmentAction:(UISegmentedControl *)seg
{
    self.aaChartModel = [self configurePieChartWithDataArray:seg.selectedSegmentIndex == 0?self.costArray:self.inComeArray Type:seg.selectedSegmentIndex];
    
    [self.aaChartView aa_drawChartWithChartModel:_aaChartModel];
}
- (AAChartModel *)configurePieChartWithDataArray:(NSArray *)dataArray Type:(NSInteger)type {
    
    
    AASeriesElement *element = AASeriesElement.new
    .nameSet(@"金额")
    .innerSizeSet(@"20%")//内部圆环半径大小占比
    .sizeSet(@150)//尺寸大小
    .borderWidthSet(@0)//描边的宽度
    .allowPointSelectSet(true)//是否允许在点击数据点标记(扇形图点击选中的块发生位移)
    .statesSet(AAStates.new
               .hoverSet(AAHover.new
                         .enabledSet(false)//禁用点击区块之后出现的半透明遮罩层
                         ))
    .dataSet(dataArray);
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<dataArray.count; i++) {
        [array addObject:[NSString stringWithFormat:@"#%@",RandomColor.hexString]];
    }
    return AAChartModel.new
    .chartTypeSet(AAChartTypePie)
    .colorsThemeSet(array)
    .titleSet(@"")
    .subtitleSet(@"")
    .dataLabelsEnabledSet(true)//是否直接显示扇形图数据
    .seriesSet(@[element])
    ;
}

-(void)reloadDataBase
{
    NSString *selectDate = [self.date cx_stringWithFormat:@"yyyy-MM"];;
    FMDatabase *db = [MDMethods openOrCreateDBWithDBName:FMDBMainName Success:^{} Fail:^{return ;}];
    NSString *sql = [NSString stringWithFormat:@"select * FROM BillList where currentDateStr like '%@' order by currentDate desc",[selectDate stringByAppendingString:@"%"]];
    FMResultSet *rs = [db executeQuery:sql];
    self.dataArray = [NSMutableArray array];
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
        
    }
    NSMutableArray<BillModel *> *costArray = [NSMutableArray array];
    NSMutableArray<BillModel *> *inComeArray = [NSMutableArray array];
    for (BillModel *model in self.dataArray) {
        if (model.type == 0) {
            [costArray addObject:model];
        }else{
            [inComeArray addObject:model];
        }
    }
    self.costArray = [self sloveArraywithArray:@[@"三餐",@"服饰",@"捐赠",@"交通",@"其它",@"旅游",@"酒水",@"加油",@"娱乐",@"房租",@"兴趣爱好",@"购物",@"美妆",@"医疗",@"数码产品",@"教育"] Andtargearray:costArray];
    self.inComeArray = [self sloveArraywithArray:@[@"工资",@"奖金",@"股票基金",@"其它"] Andtargearray:inComeArray];
    self.aaChartModel = [self configurePieChartWithDataArray:self.costArray Type:1];
   
   [self.aaChartView aa_drawChartWithChartModel:_aaChartModel];
   NSString *costStr = [NSString stringWithFormat:@"%@",[costArray valueForKeyPath:@"@sum.money"]];
   NSString *inComeStr = [NSString stringWithFormat:@"%@",[inComeArray valueForKeyPath:@"@sum.money"]];
    self.allMoney.attributedText = [MDMethods ChangeNSMutabelAttributedString:[NSString stringWithFormat:@"总资产\n¥%0.2f",[[NSUserDefaults standardUserDefaults] floatForKey:BillAsset]] TargetFonts:[UIFont fontWithName:@"PingFangSC-Light" size:13] TargetColors:[UIColor lightGrayColor] AndTargetString:@"总资产"];
   self.costLabel.attributedText = [MDMethods ChangeNSMutabelAttributedString:[NSString stringWithFormat:@"月收入\n¥%@",inComeStr] TargetFonts:[UIFont fontWithName:@"PingFangSC-Light" size:13] TargetColors:[UIColor lightGrayColor] AndTargetString:@"月收入"];
   self.inComeLabel.attributedText = [MDMethods ChangeNSMutabelAttributedString:[NSString stringWithFormat:@"月支出\n¥%@",costStr] TargetFonts:[UIFont fontWithName:@"PingFangSC-Light" size:13] TargetColors:[UIColor lightGrayColor] AndTargetString:@"月支出"];
   self.sumLabel.attributedText = [MDMethods ChangeNSMutabelAttributedString:[NSString stringWithFormat:@"月结余\n¥%0.2f",[inComeStr floatValue]-[costStr floatValue]] TargetFonts:[UIFont fontWithName:@"PingFangSC-Light" size:13] TargetColors:[UIColor lightGrayColor] AndTargetString:@"月结余"];
   self.dayAvgLabel.attributedText = [MDMethods ChangeNSMutabelAttributedString:[NSString stringWithFormat:@"日平均支出\n¥%0.2f",[costStr floatValue]/self.date.daysInMonth] TargetFonts:[UIFont fontWithName:@"PingFangSC-Light" size:13] TargetColors:[UIColor lightGrayColor] AndTargetString:@"日平均支出"];
}
-(NSArray *)sloveArraywithArray:(NSArray *)array Andtargearray:(NSMutableArray<BillModel *> *)billArray
{
    NSMutableArray *big = [NSMutableArray array];
       for (int i = 0; i<array.count; i++) {
           CGFloat money = 0.0;
           for (BillModel *model in billArray) {
               if ([model.name isEqualToString:array[i]]) {
                   money += [model.money floatValue];
               }
           }
           if (money != 0.0) {
               [big addObject:@[array[i], [NSNumber numberWithFloat:money]]];
           }
       }
    return big;
}
-(void)selectMonth
{
    WeakBlock(self, weak_self);
    CXDatePickerView *datepicker = [[CXDatePickerView alloc] initWithDateStyle:CXDateYearMonth completeBlock:^(NSDate *selectDate) {
        weak_self.date = selectDate;
        [weak_self reloadDataBase];
    }];
    datepicker.datePickerFont = [UIFont fontWithName:@"PingFangSC-Light" size:17];
    datepicker.dateLabelColor = TintColor;//年-月-日-时-分 颜色
    datepicker.datePickerColor = TintColor;//滚轮日期颜色
    datepicker.doneButtonColor = TintColor;//确定按钮的颜色
    datepicker.cancelButtonColor = datepicker.doneButtonColor;
    [datepicker show];
    
}
- (NSDate *)date
{
    if (!_date) {
        _date = [NSDate date];
    }
    return _date;
}
- (void)setPopUpView{
    //创建一个弹框
    UIAlertController *addAlertVC = [UIAlertController alertControllerWithTitle:@"添加资产" message:@"" preferredStyle:UIAlertControllerStyleAlert];

    //创建两个textFiled输入框
    [addAlertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入金额";
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.tag = 120;
    }];

    //创建取消事件(按钮)
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    //添加 取消事件 到 弹窗界面
    [addAlertVC addAction:cancelAction];


    //创建 确认按钮(事件) 并添加到弹窗界面

    UIAlertAction *confirmAction =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        UITextField *field = [addAlertVC.view viewWithTag:120];
        CGFloat money = [[NSUserDefaults standardUserDefaults] floatForKey:BillAsset];
        money = money + [field.text floatValue];
        [[NSUserDefaults standardUserDefaults] setFloat:money forKey:BillAsset];

    }];
    [addAlertVC addAction:confirmAction];


    [self presentViewController:addAlertVC animated:YES completion:nil];
}

@end
