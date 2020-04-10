//
//  SuiXiangCollectionViewCell.m
//  MarkProject
//
//  Created by 孙冬 on 2020/3/31.
//  Copyright © 2020 mac. All rights reserved.
//

#import "SuiXiangCollectionViewCell.h"

@implementation SuiXiangCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initMyview];
    }
    return self;
}
-(void)initMyview
{
    self.backgroundColor = [UIColor whiteColor];
}
@end
