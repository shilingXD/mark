//
//  ListDetailViewController.m
//  MarkProject
//
//  Created by MAC on 2020/4/13.
//  Copyright © 2020 mac. All rights reserved.
//

#import "ListDetailViewController.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
}

-(void)setNav
{
    [self.navigationView setTitle:@""];
    self.view.backgroundColor = rgba(240, 240, 240, 1);
    self.navigationView.backgroundView.image = nil ;
    self.navigationView.backgroundView.backgroundColor = TintColor;
    self.navigationView.lineView.backgroundColor = TintColor;
}

@end
