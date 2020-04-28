//
//  CustomSettingViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/28.
//  Copyright © 2020 mac. All rights reserved.
//

#import "CustomSettingViewController.h"
#import "SettingTableViewCell.h"

@interface CustomSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *ItemsArray;
@end

@implementation CustomSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setArray];
    [self setupTableView];
}
-(void)setArray
{
    if ([_NavTitle isEqualToString:@"主题"]) {
        _ItemsArray = @[@[@"默认黑",TintColor],@[@"中国红",rgba(210, 55, 59, 1)],@[@"基佬紫",rgba(108, 22, 199, 1)],@[@"清新蓝",rgba(2, 145, 212, 1)],@[@"原谅绿",rgba(1, 189, 122, 1)]];
    } else {
        
    }
}
-(void)setNav
{
    [super setNav];
    [self.navigationView setTitle:_NavTitle];
    
}
-(void)setupTableView
{
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 50;
    _tableView.bounces = NO;
    _tableView.backgroundColor = rgba(240, 240, 240, 1);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"SettingTableViewCell" bundle:nil] forCellReuseIdentifier:@"SettingTableViewCell"];
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom);
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = rgba(240, 240, 240, 1);
    cell.titleLabel.text = [NSString stringWithFormat:@"   %@",_ItemsArray[indexPath.row][0]];
    cell.iconImage.image = [UIImage imageWithColor:_ItemsArray[indexPath.row][1]];
    cell.iconImage.layer.cornerRadius = 10;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.stateSwitch.hidden = YES;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_NavTitle isEqualToString:@"主题"]) {
        [self setThemeWithIndexPath:indexPath];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ItemsArray.count;
}
-(void)setThemeWithIndexPath:(NSIndexPath *)indexPath
{
    [MDInstance sharedInstance].themeColor = _ItemsArray[indexPath.row][1];
    self.navigationView.backgroundView.backgroundColor = [MDInstance sharedInstance].themeColor;
    self.navigationView.lineView.backgroundColor = [MDInstance sharedInstance].themeColor;
}
@end
