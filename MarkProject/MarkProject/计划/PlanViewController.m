//
//  PlanViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "PlanViewController.h"

@interface PlanViewController ()

@end

@implementation PlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    
    CALayer *vo = [CALayer layer];
    vo.frame = CGRectMake(20, 20, 201, 20);
    vo.backgroundColor = [UIColor redColor].CGColor;
    
}
-(void)setNav
{
    [self.navigationView setTitle:@"备忘录"];
    self.view.backgroundColor = rgba(240, 240, 240, 1);
    self.navigationView.backgroundView.image = nil ;
    self.navigationView.backgroundView.backgroundColor = TintColor;
    self.navigationView.lineView.backgroundColor = TintColor;
}

@end
