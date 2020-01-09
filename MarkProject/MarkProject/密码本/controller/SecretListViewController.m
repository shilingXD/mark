//
//  SecretListViewController.m
//  MarkProject
//
//  Created by MAC on 2019/12/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SecretListViewController.h"

@interface SecretListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;///<<#注释#>
@end

@implementation SecretListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"密码本";
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)createLayout
{
    
}

@end
