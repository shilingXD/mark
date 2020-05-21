//
//  SuiXiangCollectionViewCell.m
//  MarkProject
//
//  Created by 孙冬 on 2020/3/31.
//  Copyright © 2020 mac. All rights reserved.
//

#import "SuiXiangCollectionViewCell.h"
#import "MoreActionView.h"

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
    
    _Titlelabel = [[UILabel alloc] init];
    _Titlelabel.text = @"标题";
    _Datelabel.font = [UIFont fontWithName:@"PingFang SC" size: 17];
    _Datelabel.textColor = [UIColor blackColor];
    [self addSubview:_Titlelabel];
    [self.Titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.right.mas_equalTo(self.right).offset(-10);
    }];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.image = [UIImage imageNamed:@"文件"];
    [self addSubview:_imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    _Datelabel = [[UILabel alloc] init];
    _Datelabel.text = @"1月22日 20:32";
    _Datelabel.font = [UIFont fontWithName:@"PingFang SC" size: 12];
    _Datelabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_Datelabel];
    [_Datelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];
    
    _morebtn = [[UIButton alloc] init];
    [_morebtn setTitle:@"..." forState:UIControlStateNormal];
    _morebtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [_morebtn setTitleColor:TintColor forState:UIControlStateNormal];
    [_morebtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_morebtn];
    [_morebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(55, 50));
    }];
}
- (void)setModel:(MDModel *)model
{
    _model = model;
    _imageView.image = [model.Type isEqualToString:@"1"]?[UIImage imageNamed:@"文件"]:[UIImage imageNamed:@"文件夹"];
    _Titlelabel.text = model.Title;
    _Datelabel.text = [MDMethods changeTimeDate:model.CreateTime];
}
-(void)moreBtnClick:(UIButton *)sender
{
    MoreActionView *view = [[MoreActionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    view.gk_size = CGSizeMake(SCREEN_WIDTH, 200);
    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:view style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleBottom showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleBottom notClick:NO];
}
@end
