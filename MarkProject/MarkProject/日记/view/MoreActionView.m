//
//  MoreActionView.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MoreActionView.h"

@implementation MoreActionView

+ (instancetype)init {
    MoreActionView *view = [MoreActionView loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    [view initUI];
    return view;
}
- (void)initUI
{
}
@end
