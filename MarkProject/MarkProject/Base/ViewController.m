//
//  ViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2019/11/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"
#import "BaseNavigationController.h"
@interface ViewController ()
@property (nonatomic, strong) UIView *launchView;///<启动页
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf showHomeVC];
    });
}
- (void)initUI
{
    [self.view setBackgroundColor:TintColor];
//    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [self.view addSubview:self.launchView];
}
- (void)showHomeVC
{
    MainViewController *vc = [[MainViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:nav animated:YES completion:nil];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.launchView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.launchView removeFromSuperview];
    }];
}
- (UIView *)launchView
{
    if (!_launchView) {
        _launchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-98*1.5, SCREEN_HEIGHT*0.25, 98*3, 19*3)];
        
        imageView.image = [UIImage imageNamed:@"闪屏"];
        [_launchView addSubview:imageView];
//        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.2, SCREEN_WIDTH, 100)];
//        title.textAlignment = NSTextAlignmentCenter;
//        title.text = @"让记录更便捷";
//        title.font = [UIFont systemFontOfSize:30];
//        title.textColor = [UIColor whiteColor];
//        [_launchView addSubview:title];
    }
    return _launchView;
};
@end
