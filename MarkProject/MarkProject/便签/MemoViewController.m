//
//  MemoViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MemoViewController.h"
#import "WMDragView.h"
#import "MemoCell.h"
#import "MemoModel.h"

#define kCloseCellHeight    110.f
#define kOpenCellHeight     310.f

@interface MemoViewController () < UITableViewDelegate, UITableViewDataSource >

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<NSNumber *> *cellHeights;

@property (nonatomic, assign) NSInteger selectRow;///<<#注释#>

@property (nonatomic, strong) NSMutableArray<MemoModel *> *dataArray;
@end

@implementation MemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    
    
//    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.tableView.backgroundColor = GrayWhiteColor;
    [self reloadDataBase];
    [self AddButton];
}
-(void)AddButton
{
    WMDragView *dragView = [[WMDragView alloc] init];
    dragView.backgroundColor = rgba(85, 85, 85, 1);
    dragView.layer.masksToBounds = YES;
    dragView.layer.cornerRadius = 25;
    WeakBlock(self, weak_self);
    dragView.clickDragViewBlock = ^(WMDragView *dragView) {
        [weak_self insertDataBase];
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
- (void)setNav
{
    [super setNav];
    [self.navigationView setTitle:@"便签"];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    image.contentMode = UIViewContentModeScaleAspectFit;
    image.image = [UIImage imageNamed:@"排序"];
    image.center = rightView.center;
    [rightView addSubview:image];
    [self.navigationView addRightView:rightView callback:^(UIView *view) {
        
    }];
    
}
- (void)createCellHeightsArray
{
    for (int i = 0; i < self.dataArray.count; i ++) {
        [self.cellHeights addObject:@(kCloseCellHeight)];
    }
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(MemoCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![cell isKindOfClass:[MemoCell class]]) return;
    
    cell.backgroundColor = [UIColor clearColor];
    
    CGFloat cellHeight = self.cellHeights[indexPath.row].floatValue;
    if (cellHeight == kCloseCellHeight) {
        [cell selectedAnimationByIsSelected:NO animated:NO completion:nil];
    }else
    {
        [cell selectedAnimationByIsSelected:YES animated:NO completion:nil];
    }
    
    [cell setNumber:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemoCell" forIndexPath:indexPath];
    WeakBlock(self, weak_self);
    cell.callSelectRowBlock = ^(NSInteger row) {
        weak_self.selectRow = row;
    };
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeights[indexPath.row].floatValue;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (![cell isKindOfClass:[MemoCell class]]) return;
    
    if (cell.isAnimating) return;
    
    NSTimeInterval duration = 0.f;
    
    CGFloat cellHeight = self.cellHeights[indexPath.row].floatValue;
    
    if (cellHeight == kCloseCellHeight) {
        self.cellHeights[indexPath.row] = @(kOpenCellHeight);
        [cell selectedAnimationByIsSelected:YES animated:YES completion:nil];
        duration = 1.f;
    }else
    {
        self.cellHeights[indexPath.row] = @(kCloseCellHeight);
        [cell selectedAnimationByIsSelected:NO animated:YES completion:nil];
        duration = 1.f;
    }
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [tableView beginUpdates];
        [tableView endUpdates];
    } completion:nil];
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakBlock(self, weak_self);
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击了删除");
        [MDMethods showAlertWithTitle:@"确定删除这条记录？" SureTitle:@"确定" SureBlock:^{
            [BaseModel deleteWithTableName:@"MemoList" deleteID:weak_self.dataArray[indexPath.row].ID];
            [weak_self reloadDataBase];
        } CancelTitle:@"取消" CancelBlock:^{
            
        }];
        
    }];
    return @[deleteAction];
}
#pragma mark - Getter && Setter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationBar_Height, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_Height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView registerNib:[UINib nibWithNibName:@"MemoCell" bundle:nil] forCellReuseIdentifier:@"MemoCell"];
    }
    return _tableView;
}

- (NSMutableArray<NSNumber *> *)cellHeights
{
    if (!_cellHeights) {
        _cellHeights = [NSMutableArray array];
    }
    return _cellHeights;
}

#pragma mark  - ------  键盘  ------
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_selectRow inSection:0];

    CGRect rectInTable = [_tableView rectForRowAtIndexPath:indexPath];

    CGRect rectInSelfview = [_tableView convertRect:rectInTable toView:self.view];

    CGFloat cellBottomY = rectInSelfview.origin.y + rectInSelfview.size.height;

    if (cellBottomY > keyboardFrame.origin.y ) { //键盘是否会挡住点击cell的判断

        CGFloat delta = _tableView.frame.origin.y - (cellBottomY - keyboardFrame.origin.y);
        delta = delta<_tableView.y-keyboardFrame.size.height?_tableView.y-keyboardFrame.size.height:delta;

        _tableView.frame =CGRectMake(0, delta,SCREEN_WIDTH,_tableView.frame.size.height);

    }
    
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    _tableView.frame =CGRectMake(0, NavigationBar_Height,SCREEN_WIDTH,_tableView.frame.size.height);
}
#pragma mark  - ------  数据库  ------
-(void)reloadDataBase
{
    FMDatabase *_db = [MDMethods openOrCreateDBWithDBName:FMDBMainName Success:^{} Fail:^{return;}];
   [_db open];
    if (![_db isOpen]) {
        return;
    }
    FMResultSet *rs = [_db executeQuery:@"select * from MemoList order by createdAt desc"];
    self.dataArray = [NSMutableArray array];
    while ([rs next]) {
        MemoModel *model = [[MemoModel alloc] init];
        model.ID = [rs intForColumn:@"ID"];
        model.memoTitle = [rs stringForColumn:@"memoTitle"];
        model.memoContent = [rs stringForColumn:@"memoContent"];
        model.memoColorHex = [rs stringForColumn:@"memoColorHex"];
        model.createdAt = [rs longLongIntForColumn:@"createdAt"];
        model.updatedAt = [rs longLongIntForColumn:@"updatedAt"];
        [self.dataArray addObject:model];
    }
    [_db close];
    [self createCellHeightsArray];
    [self.tableView reloadData];
}
-(void)updateDataBase
{
    
}
-(void)insertDataBase
{
    FMDatabase *_db = [MDMethods openOrCreateDBWithDBName:FMDBMainName Success:^{} Fail:^{return;}];
    [_db open];
    if (![_db isOpen]) {
        return;
    }
    
    BOOL result = [_db executeUpdate:@"insert into MemoList (memoTitle,memoContent,memoColorHex,createdAt,updatedAt) values (?,?,?,?,?)",@"新建便签",@"",@"5D4A99",@([[MDMethods currentTimeStr]  integerValue]),@([[MDMethods currentTimeStr]  integerValue])];
    if (result) {
    }else{
        
    }
    [self reloadDataBase];
}

- (void)handleTransaction:(UIButton *)sender {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [documentPath stringByAppendingPathComponent:@"test1.db"];
    FMDatabase *db = [[FMDatabase alloc]initWithPath:dbPath];
    [db open];
    if (![db isOpen]) {
        return;
    }
    BOOL result = [db executeUpdate:@"create table if not exists text1 (name text,age,integer,ID integer)"];
    if (result) {
        NSLog(@"create table success");
    }
    //1.开启事务
    [db beginTransaction];
    NSDate *begin = [NSDate date];
    BOOL rollBack = NO;
    @try {
       //2.在事务中执行任务
        for (int i = 0; i< 500; i++) {
            NSString *name = [NSString stringWithFormat:@"text_%d",i];
            NSInteger age = i;
            NSInteger ID = i *1000;
            
            BOOL result = [db executeUpdate:@"insert into text1(name,age,ID) values(:name,:age,:ID)" withParameterDictionary:@{@"name":name,@"age":[NSNumber numberWithInteger:age],@"ID":@(ID)}];
            if (result) {
                NSLog(@"在事务中insert success");
            }
        }
    }
    @catch(NSException *exception) {
        //3.在事务中执行任务失败，退回开启事务之前的状态
        rollBack = YES;
        [db rollback];
    }
    @finally {
        //4. 在事务中执行任务成功之后
        rollBack = NO;
        [db commit];
    }
    NSDate *end = [NSDate date];
    NSTimeInterval time = [end timeIntervalSinceDate:begin];
    NSLog(@"在事务中执行插入任务 所需要的时间 = %f",time);
    
}
- (void)handleNotransaction:(UIButton *)sender {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [documentPath stringByAppendingPathComponent:@"test1.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    [db open];
    if (![db isOpen]) {
        return;
    }
    BOOL result = [db executeUpdate:@"create table if not exists text2('ID' INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,age INTRGER)"];
    if (!result) {
        [db close];
    }
    NSDate *begin = [NSDate date];
    for (int i = 0; i< 500; i++) {
        NSString *name = [NSString stringWithFormat:@"text_%d",i];
        NSInteger age = i;
        NSInteger ID = i *1000;
        
        BOOL result = [db executeUpdate:@"insert into text2(name,age,ID) values(:name,:age,:ID)" withParameterDictionary:@{@"name":name,@"age":[NSNumber numberWithInteger:age],@"ID":@(ID)}];
        if (result) {
            NSLog(@"不在事务中insert success");
        }
    }
    NSDate *end = [NSDate date];
    NSTimeInterval time = [end timeIntervalSinceDate:begin];
    NSLog(@"不在事务中执行插入任务 所需要的时间 = %f",time);
}
@end
