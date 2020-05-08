//
//  BaseViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/28.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNav];
}
-(void)setNav
{
    self.navigationView.backgroundView.image = nil ;
    self.navigationView.backgroundView.backgroundColor = [MDInstance sharedInstance].themeColor;
    self.navigationView.lineView.backgroundColor = [MDInstance sharedInstance].themeColor;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

}
@end
