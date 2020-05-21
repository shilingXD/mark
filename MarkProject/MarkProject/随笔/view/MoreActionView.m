//
//  MoreActionView.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MoreActionView.h"

@implementation MoreActionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}
- (void)initUI
{
    self.dataArray = [NSArray arrayWithObjects:@"重命名",@"移动",@"删除", nil];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self setTableHeadView];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
        _tableView.rowHeight = 50;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        [self addSubview:_tableView];
    }
    return _tableView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-light" size:14];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self setPopUpView];
            break;
        case 1:
            
            break;
        case 2:
            
            break;
            
        default:
            break;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(void)setTableHeadView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"操作：";
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-light" size:15];
    titleLabel.textColor = [UIColor blackColor];
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).offset(10);
        make.centerY.mas_equalTo(view);
    }];
    self.tableView.tableHeaderView = view;
}

- (void)setPopUpView{
    //创建一个弹框
    [GKCover hideCover];
    UIAlertController *addAlertVC = [UIAlertController alertControllerWithTitle:@"重命名" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    //创建两个textFiled输入框
    [addAlertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入新名称";
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
        //        CGFloat money = [[NSUserDefaults standardUserDefaults] floatForKey:BillAsset];
        //        money = money + [field.text floatValue];
        //        [[NSUserDefaults standardUserDefaults] setFloat:money forKey:BillAsset];
        
    }];
    [addAlertVC addAction:confirmAction];
    
    
    [[MDMethods getCurrentViewController] presentViewController:addAlertVC animated:YES completion:nil];
}
@end
