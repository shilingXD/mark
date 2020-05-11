//
//  BaseViewController.h
//  MarkProject
//
//  Created by 孙冬 on 2020/4/28.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController


- (void)viewWillAppear:(BOOL)animated;
-(void)setNav;
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
@end

NS_ASSUME_NONNULL_END
/*
 名称：你的笔记本
 核心功能 1.0 版本 账单 记录（md） 2.0 版本 制定计划（倒数日、养成习惯） 便签 时间轴
 */
