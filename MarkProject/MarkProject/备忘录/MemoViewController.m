//
//  MemoViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MemoViewController.h"

@interface MemoViewController ()

@end

@implementation MemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
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
