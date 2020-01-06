//
//  BaseNavigationController.m
//  MarkProject
//
//  Created by 孙冬 on 2019/12/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = TintColor;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:15]};
    [self.navigationBar setShadowImage:[UIImage new]];
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
