//
//  AddPlanNameView.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/16.
//  Copyright © 2020 mac. All rights reserved.
//

#import "AddPlanNameView.h"
#import "AddPlanView.h"

@implementation AddPlanNameView

+ (instancetype)init {
    AddPlanNameView *view = [AddPlanNameView loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH-70, 165)];
    [view initUI];
    return view;
}
- (void)initUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    self.Noticelabel.hidden = YES;
    [self.Noticelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top);
        make.height.mas_equalTo(25);
    }];
    
    [self.TitleField becomeFirstResponder];
    self.TitleField.delegate = self;
    self.TitleField.font = [UIFont fontWithName:@"PingFang SC" size:15];
    [self.TitleField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
    [self.TitleField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.top.mas_equalTo(self.mas_top).offset(25);
        make.height.mas_equalTo(30);
    }];
    self.fieldLine.alpha = 0.5;
    self.fieldLine.hidden = YES;
    self.fieldLine.centerX = self.centerX;
    self.fieldLine.size = CGSizeMake(5, 1);
    self.fieldLine.y = 55;
    
    self.HeighBtn.layer.cornerRadius = 35/2;
    self.HeighBtn.layer.masksToBounds = YES;
    self.HeighBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.HeighBtn.layer.borderWidth = 1;
    [self.HeighBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.top.mas_equalTo(self.fieldLine.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake((self.width-45)/3, 35));
    }];
    self.MidBtn.layer.cornerRadius = 35/2;
    self.MidBtn.layer.masksToBounds = YES;
    self.MidBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    self.MidBtn.layer.borderWidth = 1;
    [self.MidBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.fieldLine.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake((self.width-45)/3, 35));
    }];
    self.LowBtn.layer.cornerRadius = 35/2;
    self.LowBtn.layer.masksToBounds = YES;
    self.LowBtn.layer.borderColor = [UIColor hexStringToColor:@"3A87FB"].CGColor;
    self.LowBtn.layer.borderWidth = 1;
    [self.LowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.top.mas_equalTo(self.fieldLine.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake((self.width-45)/3, 35));
    }];
    
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.width/2, 50));
    }];
    
    
    self.line.layer.cornerRadius = 0.5;
    self.line.layer.masksToBounds = YES;
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(1, 30));
        make.bottom.mas_equalTo(self.bottom).offset(-10);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.width/2, 50));
    }];
}
-(void)changeText:(UITextField *)sender
{
    CGRect rect = [sender.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 30) options:NSStringDrawingTruncatesLastVisibleLine|   NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size:15]} context:nil];
    self.fieldLine.hidden = NO;
    self.fieldLine.centerX = self.TitleField.centerX;
    self.fieldLine.width = rect.size.width+5;
}


- (IBAction)highAction:(id)sender {
    [self selectWithTag:3];
}
- (IBAction)midAction:(id)sender {
    [self selectWithTag:2];
}
- (IBAction)lowAction:(id)sender {
    [self selectWithTag:1];
}

-(void)selectWithTag:(int)tag{
    self.model.priority = tag;
    [self.HeighBtn setBackgroundColor:[UIColor whiteColor]];
    [self.MidBtn setBackgroundColor:[UIColor whiteColor]];
    [self.LowBtn setBackgroundColor:[UIColor whiteColor]];
    [self.HeighBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.MidBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.LowBtn setTitleColor:[UIColor hexStringToColor:@"3A87FB"] forState:UIControlStateNormal];
    switch (tag) {
        case 1:
            [self.LowBtn setBackgroundColor:[UIColor hexStringToColor:@"3A87FB"]];
            [self.LowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 2:
            [self.MidBtn setBackgroundColor:[UIColor orangeColor]];
            [self.MidBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 3:
            [self.HeighBtn setBackgroundColor:[UIColor redColor]];
            [self.HeighBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}
- (IBAction)cancelAction:(id)sender {
    [GKCover hideCover];
}
- (IBAction)nextAction:(id)sender {
    if (self.model.priority == 0) {
        self.Noticelabel.hidden = NO;
        [self.Noticelabel setTitle:@"优先级不能为空!" forState:UIControlStateNormal];
    }else if ([NSString isEmptyOfString:self.TitleField.text]){
        self.Noticelabel.hidden = NO;
        [self.Noticelabel setTitle:@"名称不能为空!" forState:UIControlStateNormal];
    }else{
        self.model.PlanTitle = self.TitleField.text;
        
        NSDate *currentDate = [NSDate date];//获取当前时间，日期
           NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
           [dateFormatter setDateFormat:@"yyyy-MM-dd"];//设定时间格式,这里可以设置成自己需要的格式
            self.model.PlanDayDate = [dateFormatter stringFromDate:currentDate];//将时间转化成字符串
           self.model.PlanItemBeginDate = 0;
           self.model.PlanItemEndDate = 288 * 5;
        [GKCover hideCover];
        AddPlanView *view = [AddPlanView init];
        view.model = self.model;
        [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:view style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleCenter hideAnimStyle:GKCoverHideAnimStyleCenter notClick:YES];
    }
}

- (PlanModel *)model
{
    if (!_model) {
        _model = [[PlanModel alloc] init];
    }
    return _model;
}
@end
