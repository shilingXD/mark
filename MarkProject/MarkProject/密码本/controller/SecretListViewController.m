//
//  SecretListViewController.m
//  MarkProject
//
//  Created by MAC on 2019/12/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SecretListViewController.h"
#import "NSString+PinYin.h"

#import "IndexView.h"
#import "TableViewHeaderView.h"
#import "TableViewSearchHeaderView.h"
#import "SecretListTableViewCell.h"
#import "SecretModel.h"
#import "WMDragView.h"
#import "AddSecretViewController.h"
#import "ListDetailViewController.h"


static NSString *TableViewHeaderViewIdentifier = @"TableViewHeaderViewIdentifier";
static NSString *TableViewCellIdentifier = @"TableViewCellIdentifier";
static NSString *TableViewSearchHeaderViewIdentifier = @"TableViewSearchHeaderViewIdentifier";

@interface SecretListViewController ()<UITableViewDelegate, UITableViewDataSource, IndexViewDelegate, IndexViewDataSource>

@property (nonatomic, strong) UITableView *TableView;
@property (nonatomic, strong) IndexView *indexView;

@property (nonatomic, copy) NSArray *TempArray;///<说明使用数组
@property (nonatomic, strong) NSMutableArray *SectionArray;
@property (nonatomic, strong) NSMutableArray<SecretModel *> *dataArray;
@property (nonatomic, assign) BOOL isSearchMode;                                /**< 是否有搜索栏  */
@property (nonatomic, assign) FMDatabase *db;
@end

@implementation SecretListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self openDataBase];
    [self createBar];
    //添加视图
    [self.view addSubview:self.TableView];
    [self.view addSubview:self.indexView];
    [self reloadData];
    [self AddButton];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [_db close];
}
- (void)dealloc
{
    NSLog(@"SecretListViewController    移除");
}

-(void)createBar
{
    [self.navigationView setTitle:@"密码本"];
    
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
        AddSecretViewController *vc = [[AddSecretViewController alloc] init];
        
        vc.dismissBlock = ^{
            [weak_self reloadData];
        };
        [weak_self presentViewController:vc animated:YES completion:^{
            
        }];
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
/// 引导数据
- (void)setupTempData{
    self.TempArray = @[@"百年灵", @"宝齐莱", @"瑞宝", @"沛纳海", @"宇舶", @"真力时", @"万国", @"欧米茄", @"劳力士", @"朗格"];
    //解析数据
    NSMutableArray *tempBrandArray = [NSMutableArray array];
    for (NSString *brandName in self.TempArray) {
        [tempBrandArray addObject:brandName];
    }
    //获取拼音首字母
    NSArray *indexArray= [tempBrandArray arrayWithPinYinFirstLetterFormat];
    self.SectionArray = [NSMutableArray arrayWithArray:indexArray];
    
    //添加搜索视图
    self.isSearchMode = YES;
    NSMutableDictionary *searchDic = [NSMutableDictionary dictionary];
    [searchDic setObject:[NSMutableArray array] forKey:@"content"];
    [self.SectionArray insertObject:searchDic atIndex:0];
    
    [self.TableView reloadData];
    [self.indexView reload];
}

#pragma mark - 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.SectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dict = self.SectionArray[section];
    NSMutableArray *array = dict[@"content"];
    return [array count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //搜索头视图
    if (section == 0) {
        return 40;
    }
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //搜索头视图
    if (section == 0) {
        TableViewSearchHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:TableViewSearchHeaderViewIdentifier];
        return headerView;
    }
    
    TableViewHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:TableViewHeaderViewIdentifier];
    headerView.letter = self.SectionArray[section][@"firstLetter"];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecretListTableViewCell *cell = [SecretListTableViewCell cellForTableview:tableView];
    NSDictionary *dict = self.SectionArray[indexPath.section];
    NSMutableArray *array = dict[@"content"];
    //品牌
    NSString *brandInfo = array[indexPath.row];
    for (SecretModel *model in self.dataArray) {
        if ([model.Name isEqualToString:brandInfo]) {
            cell.model = model;
        }
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == array.count - 1) {
        cell.lineView.hidden = YES;
    } else {
        cell.lineView.hidden = NO;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecretListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ListDetailViewController *vc = [[ListDetailViewController alloc] init];
    vc.model = cell.model;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    [self.indexView tableView:tableView willDisplayHeaderView:view forSection:section];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    [self.indexView tableView:tableView didEndDisplayingHeaderView:view forSection:section];
}
#pragma mark - 左滑删除

//tableView自带的左滑删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *dict = self.SectionArray[indexPath.section];
           NSMutableArray *array = dict[@"content"];
           //品牌
           NSString *brandInfo = array[indexPath.row];
           for (SecretModel *model in self.dataArray) {
               if ([model.Name isEqualToString:brandInfo]) {
                   [self delete:@[model]];
               }
           }
        
    }
}
// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.indexView scrollViewDidScroll:scrollView];
    NSLog(@"%f",scrollView.contentOffset.y);
}

#pragma mark - IndexView
- (NSArray<NSString *> *)sectionIndexTitles {
    //搜索符号  [NSMutableArray arrayWithObject:UITableViewIndexSearch]; [NSMutableArray array];
    NSMutableArray *resultArray = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
    for (NSDictionary *dict in self.SectionArray) {
        NSString *title = dict[@"firstLetter"];
        if (title) {
            [resultArray addObject:title];
        }
    }
    return resultArray;
}

//当前选中组
- (void)selectedSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    if (self.isSearchMode && (index == 0)) {
        //搜索视图头视图(这里不能使用scrollToRowAtIndexPath，因为搜索组没有cell)
        [self.TableView setContentOffset:CGPointZero animated:NO];
        return;
    }
    [self.TableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

//将指示器视图添加到当前视图上
- (void)addIndicatorView:(UIView *)view {
    [self.view addSubview:view];
}

#pragma mark - getter
- (UITableView *)TableView {
    if (!_TableView) {
        _TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationBar_Height, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_Height) style:(UITableViewStylePlain)];
        _TableView.delegate = self;
        _TableView.dataSource = self;
        _TableView.showsVerticalScrollIndicator = NO;
        _TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _TableView.rowHeight = 50;
        [_TableView registerClass:[TableViewHeaderView class] forHeaderFooterViewReuseIdentifier:TableViewHeaderViewIdentifier];
        [_TableView registerClass:[TableViewSearchHeaderView class] forHeaderFooterViewReuseIdentifier:TableViewSearchHeaderViewIdentifier];
    }
    return _TableView;
}

- (IndexView *)indexView {
    if (!_indexView) {
        _indexView = [[IndexView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 30, 0, 30, SCREEN_HEIGHT)];
        _indexView.delegate = self;
        _indexView.dataSource = self;
    }
    return _indexView;
}


- (NSMutableArray<SecretModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  - ------  FMDB操作  ------
-(void)openDataBase
{
    FMDatabase *db = [MDMethods openOrCreateDBWithDBName:@"SecretList.sqlite" Success:^{
        
    } Fail:^{
        return ;
    }];
    NSString *createTableSqlString = @"CREATE TABLE IF NOT EXISTS SecretList (id integer PRIMARY KEY AUTOINCREMENT, Name text NOT NULL, NameURL text, Account text NOT NULL, PassWord text NOT NULL, Note text, CreateTime text NOT NULL, UpdateTime text NOT NULL, CurrentTime integer NOT NULL)";
    [db executeUpdate:createTableSqlString];
    [db close];
    
    
    
    
}
-(void)reloadData
{
    FMDatabase *db = [MDMethods openOrCreateDBWithDBName:@"SecretList.sqlite" Success:^{
        
    } Fail:^{
        return ;
    }];
    NSString *sql = @"select  id,Name,NameURL,Account,PassWord,Note,CreateTime,UpdateTime,currentTime FROM SecretList";
    FMResultSet *rs = [db executeQuery:sql];
    [self.dataArray removeAllObjects];
    while ([rs next]) {
        SecretModel *model = [[SecretModel alloc] init];
        model.secretID = [rs intForColumn:@"id"];
        model.Name = [rs stringForColumn:@"Name"];
        model.NameURL = [rs stringForColumn:@"NameURL"];
        model.Account = [rs stringForColumn:@"Account"];
        model.PassWord = [rs stringForColumn:@"PassWord"];
        model.Note = [rs stringForColumn:@"Note"];
        model.CreateTime = [rs stringForColumn:@"CreateTime"];
        model.UpdateTime = [rs stringForColumn:@"UpdateTime"];
        model.currentTime = [rs stringForColumn:@"currentTime"];
        [self.dataArray addObject:model];
    }
    [self.SectionArray removeAllObjects];
    //解析数据
    NSMutableArray *tempBrandArray = [NSMutableArray array];
    for (SecretModel *model in self.dataArray) {
        [tempBrandArray addObject:model.Name];
    }
    //获取拼音首字母
    NSArray *indexArray= [tempBrandArray arrayWithPinYinFirstLetterFormat];
    self.SectionArray = [NSMutableArray arrayWithArray:indexArray];
    
    //添加搜索视图
    self.isSearchMode = YES;
    NSMutableDictionary *searchDic = [NSMutableDictionary dictionary];
    [searchDic setObject:[NSMutableArray array] forKey:@"content"];
    [self.SectionArray insertObject:searchDic atIndex:0];
    
    
    //默认设置第一组
    [self.indexView setSelectionIndex:0];
    [self.TableView reloadData];
    [self.indexView reload];
    [db close];
}
- (void)delete:(NSArray *)delStudents {
    FMDatabase *db = [MDMethods openOrCreateDBWithDBName:@"SecretList.sqlite" Success:^{
        
    } Fail:^{
        return ;
    }];
    NSString *sql = @"delete from SecretList where id = ?";
    SecretModel *model = delStudents[0];
    BOOL result = [db executeUpdate:sql, @(model.secretID)];
    if (!result) {
//        self.resultLbe.text = @"删除数据失败";
         //只显示文字

               
        return;
    }
    [self showTextMessage:@"删除成功"];
 
    NSArray *newDelStudents = delStudents.copy;
    // 将已经在数据库中被删除的对象从内存中移除
    [newDelStudents enumerateObjectsUsingBlock:^(SecretModel *obj, NSUInteger idx, BOOL *stop) {
        [self.dataArray removeObject:obj];
    }];
    [db close];
    [self reloadData];
}

- (void)showTextMessage:(NSString *)message
{
    UIView *view =[UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.mode = MBProgressHUDModeText;
    hud.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:0.7];
}
@end

