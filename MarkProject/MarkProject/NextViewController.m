//
//  NextViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2019/12/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "NextViewController.h"
#import "FIREditPageVC.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    btn.center = self.view.center;
    [btn setTitle:@"点击进入markdown 编辑模式" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toEditPageAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)toEditPageAction:(id)sender
{
    [UIApplication sharedApplication].statusBarStyle = UIBarStyleDefault;
    FIREditPageVC *vc = [[FIREditPageVC alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
