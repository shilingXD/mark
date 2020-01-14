//
//  SecretListViewController.m
//  MarkProject
//
//  Created by MAC on 2019/12/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SecretListViewController.h"
#import "SecretListTableViewCell.h"

@interface SecretListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;///<<#注释#>
@end

@implementation SecretListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"密码本";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createLayout];
}

-(void)createLayout
{
    _tableview  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_Height) style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.rowHeight = 120;
    [self.view addSubview:_tableview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecretListTableViewCell *cell = [SecretListTableViewCell cellForTableview:tableView];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
