//
//  MemoViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MemoViewController.h"
#import "TipTableViewCell.h"

@interface MemoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;///<<#注释#>
@end

@implementation MemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setContentView];
}
-(void)setNav
{
    [self.navigationView setTitle:@"便签"];
    self.view.backgroundColor = rgba(240, 240, 240, 1);
    self.navigationView.backgroundView.image = nil ;
    self.navigationView.backgroundView.backgroundColor = [MDInstance sharedInstance].themeColor;
    self.navigationView.lineView.backgroundColor = [MDInstance sharedInstance].themeColor;
}
-(void)setContentView
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationBar_Height, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_Height) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = GrayWhiteColor;
    _tableview.rowHeight = 80;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.showsVerticalScrollIndicator = NO;
    [_tableview registerNib:[UINib nibWithNibName:@"TipTableViewCell" bundle:nil] forCellReuseIdentifier:@"TipTableViewCell"];
    [self.view addSubview:_tableview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TipTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TipTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.topLine.hidden = NO;
    cell.bottomLine.hidden = NO;
    if (indexPath.row == 0) {
        cell.topLine.hidden = YES;
//        if (<#condition#>) {
//            cell.bottomLine.hidden = YES;
//        }
    }else if (indexPath.row == 9){
        cell.bottomLine.hidden = YES;
    }
    cell.dateLabel.text = @"2017年4月7号\n23:30";
    return cell;
}
@end
