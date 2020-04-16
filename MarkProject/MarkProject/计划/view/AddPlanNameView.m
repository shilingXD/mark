//
//  AddPlanNameView.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/16.
//  Copyright © 2020 mac. All rights reserved.
//

#import "AddPlanNameView.h"

@implementation AddPlanNameView

+ (instancetype)init {
    AddPlanNameView *view = [AddPlanNameView loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH-50, 470)];
    //    [view setHidden:YES];
    [view initUI];
    return view;
}
- (void)initUI
{
    
}
@end
