//
//  NewfileView.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import "NewfileView.h"
#import "MDEditViewController.h"

@implementation NewfileView

+ (instancetype)init {
    NewfileView *view = [NewfileView loadFirstNib:CGRectMake(0, 0, 300, 165)];
    [view initUI];
    view.layer.cornerRadius = 5;
    return view;
}
- (void)initUI
{
//    self.backgroundColor = [UIColor orangeColor];
    [self.TitleLbal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top).offset(25);
    }];
    
    [self.Inputfield becomeFirstResponder];
    self.Inputfield.delegate = self;
    self.Inputfield.font = [UIFont fontWithName:@"PingFang SC" size:15];
    [self.Inputfield addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
    [self.Inputfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.TitleLbal.mas_bottom).offset(20);
        make.width.mas_equalTo(self.width-30);
        make.height.mas_equalTo(30);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.width/2, 50));
    }];
    self.FieldLine.alpha = 0.5;
    self.FieldLine.centerX = self.centerX;
    self.FieldLine.size = CGSizeMake(5, 1);
    self.FieldLine.y = 95;
    
    self.lineview.layer.cornerRadius = 0.5;
    self.lineview.layer.masksToBounds = YES;
    [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(1, 30));
        make.bottom.mas_equalTo(self.bottom).offset(-10);
    }];
    
    [self.SureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.width/2, 50));
    }];
}
- (IBAction)cancelClick:(id)sender {
    [GKCover hideCover];
}
- (IBAction)sureClick:(id)sender {
    [GKCover hideCover];
    [self newFile];
}
-(void)changeText:(UITextField *)sender
{
    CGRect rect = [sender.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 30) options:NSStringDrawingTruncatesLastVisibleLine|   NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size:15]} context:nil];
    self.FieldLine.hidden = NO;
    self.FieldLine.centerX = self.Inputfield.centerX;
    self.FieldLine.width = rect.size.width+5;
}
-(void)newFile
{
    FMDatabase *db = [MDMethods openOrCreateDBWithDBName:@"MarkProject.sqlite" Success:^{} Fail:^{return ;}];
    BOOL result = [db executeUpdateWithFormat:@"insert into MDList (Title,Type,FilePath,StoragePath,CreateTime,UpdateTime,currentTime) values (%@,%@,%@,%@,%@,%@,%@)",self.Inputfield.text,self.Type,self.FilePath,self.Inputfield.text,[MDMethods currentDateStr],[MDMethods currentDateStr],[MDMethods currentTimeStr]];
    
    if (result) {
        NSLog(@"插入成功");
        self.reloadBlock();
        if ([self.Type isEqualToString:@"1"]) {
            MDEditViewController *vc = [[MDEditViewController alloc] init];
            vc.title = self.Inputfield.text;
            [[MDMethods getCurrentViewController].navigationController pushViewController:vc animated:YES];
        }
    } else {
        NSLog(@"插入失败");
        return;
    }
}
/*
 @property (nonatomic, assign) int MDID;///<随笔ID
 @property (nonatomic, copy) NSString *Title;///<标题
 @property (nonatomic, copy) NSString *Type;///<1文件2文件夹
 @property (nonatomic, copy) NSString *FilePath;///<所属文件夹 如果没有所属文件夹首页展示
 @property (nonatomic, copy) NSString *StoragePath;///<存储路径
 @property (nonatomic, copy) NSString *CreateTime;///<创建时间
 @property (nonatomic, copy) NSString *UpdateTime;///<修改时间
 @property (nonatomic, copy) NSString *currentTime;///<时间戳
 */
@end
