//
//  MDEditViewController.m
//  MarkProject
//
//  Created by 孙冬 on 2020/4/1.
//  Copyright © 2020 mac. All rights reserved.
//

#import "MDEditViewController.h"
#import <WebKit/WebKit.h>
#import <MMMarkdown/MMMarkdown.h>
#import "GNEditShortcutKeyBar.h"
#import <YYText/YYText.h>
#import "YYCategories.h"
#import "WMDragView.h"
#import "PreWebViewController.h"

@interface MDEditViewController ()<YYTextViewDelegate>
@property (nonatomic, strong) YYTextView *editView;///<编辑框
@property (nonatomic, strong) GNEditShortcutKeyBar *shortcutKeyView;
@property (nonatomic, assign) BOOL isShowPreview;//预览
@property (nonatomic, strong) PreWebViewController *previewVC;
@property (nonatomic, strong) UILabel *switchLabel;
@end

@implementation MDEditViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSData *data = [self.editView.text dataUsingEncoding:NSUTF8StringEncoding];
    NSString *filePath = [DocumentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.md", self.titlestr]];
    //写入文件
    [data writeToFile:filePath atomically:YES];
    NSLog(@"md成功保存，地址%@", filePath);
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self.view addSubview:self.editView];
    [self.editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(NavigationBar_Height);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    [self.view addSubview:self.self.previewVC.view];
    [self.previewVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavigationBar_Height);
        make.left.right.bottom.equalTo(self.view);
    }];
    self.previewVC.view.hidden = YES;
    self.isShowPreview = NO;
    self.shortcutKeyView.hidden = YES;
    [self.view addSubview:self.shortcutKeyView];
    [self addAnimationShow];
    [self Switch];
    [self.editView becomeFirstResponder];
}
- (void)addAnimationShow
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardWillHideNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)dealloc
{
    _editView.delegate = nil;
//    [_previewVC.view removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)setNav
{
    [self.navigationView setTitle:self.titlestr];
    self.navigationView.backgroundView.image = nil ;
    self.navigationView.backgroundView.backgroundColor = [MDInstance sharedInstance].themeColor;
    self.navigationView.lineView.backgroundColor = [MDInstance sharedInstance].themeColor;
    
}
#pragma mark  - ------  事件响应  ------
-(void)Switch
{
    WMDragView *dragView = [[WMDragView alloc] init];
    dragView.backgroundColor = rgba(85, 85, 85, 1);
    dragView.layer.masksToBounds = YES;
    dragView.layer.cornerRadius = 25;
    WeakBlock(self, weak_self);
    dragView.clickDragViewBlock = ^(WMDragView *dragView) {
        [weak_self switchPreviewOrEditView];
    };
    [self.view addSubview:dragView];
    [dragView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.right.mas_equalTo(self.view).offset(-25);
        make.bottom.mas_equalTo(self.editView).offset(-25);
    }];
    
    UILabel *switchLabel = [[UILabel alloc] init];
    self.switchLabel = switchLabel;
    switchLabel.text = @"预览";
    switchLabel.textColor = [UIColor whiteColor];
    switchLabel.font = [UIFont fontWithName:@"PingFangSC-Ultralight" size:20];
    [dragView addSubview:switchLabel];
    [switchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(dragView);
    }];
    
}
//预览模式切换
- (void)switchPreviewOrEditView
{
    self.previewVC.view.hidden = self.isShowPreview;
    self.isShowPreview = self.isShowPreview ? NO : YES;
    self.switchLabel.text = self.isShowPreview ? @"编辑":@"预览";
    if (self.isShowPreview) {
        [self.previewVC refreshMarkdown:self.editView.text];
        [self.editView resignFirstResponder];
    } else {
        [self.editView becomeFirstResponder];
    }
}
#pragma mark  - ------  懒加载  ------
- (YYTextView *)editView
{
    if (!_editView) {
        YYTextSimpleMarkdownParser *parser = [YYTextSimpleMarkdownParser new];
        [parser setColorWithBrightTheme];
        
        YYTextView *textView = [YYTextView new];
        YYTextLinePositionSimpleModifier *modifier = [YYTextLinePositionSimpleModifier new];
        modifier.fixedLineHeight = 24;
        textView.linePositionModifier = modifier;
        textView.font = [UIFont systemFontOfSize:14];
        textView.textParser = parser;
        textView.size = self.view.size;
        textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        textView.delegate = self;
        if (kiOS7Later) {
            textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        }
//        textView.backgroundColor = [UIColor colorWithWhite:0.134 alpha:1.000];
        textView.backgroundColor = GrayWhiteColor;
//        textView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
//        textView.scrollIndicatorInsets = textView.contentInset;
        //        textView.selectedRange = NSMakeRange(text.length, 0);
        [self.view addSubview:textView];
        self.editView = textView;
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *filePath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.md", self.titlestr]];
        NSString *markdown = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
        self.editView.text = markdown;
    }
    return _editView;
}
- (GNEditShortcutKeyBar *)shortcutKeyView
{
    if (!_shortcutKeyView) {
        __weak typeof(self) weakSelf = self;
        _shortcutKeyView = [[GNEditShortcutKeyBar alloc]initWithFrame:CGRectMake(0, self.view.bottom, self.view.width, 40)];
        [_shortcutKeyView setClickEditShortcutKeyBlock:^(GNEditShortcutKeyType itemType) {
            [weakSelf.shortcutKeyView clickEditShortKeyWithType:itemType inTextView:weakSelf.editView];
        }];
    }
    return _shortcutKeyView;
}
- (PreWebViewController *)previewVC
{
    if (!_previewVC) {
        _previewVC = [[PreWebViewController alloc]init];
    }
    return _previewVC;
}
#pragma mark -- YYTextViewDelegate

- (BOOL)textViewShouldBeginEditing:(YYTextView *)textView
{
    self.shortcutKeyView.hidden = NO;
    return YES;
}

- (void)textViewDidEndEditing:(YYTextView *)textView;
{
    self.shortcutKeyView.hidden = YES;
}

#pragma mark -- keyboard KVO

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    if (![notification.name isEqualToString:UIKeyboardWillChangeFrameNotification]) return;
    NSDictionary *userInfo = notification.userInfo;
    if (!userInfo) return;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];//键盘顶部起始位置⌨️
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    __weak typeof(self) weakSelf = self;
    void(^animations)(void) = ^{
        CGFloat topY = MAX(endFrame.origin.y - weakSelf.shortcutKeyView.height,0);
        if (topY != weakSelf.shortcutKeyView.top) {
            weakSelf.shortcutKeyView.top = topY;
        }
            //更新textView高度 start
        BOOL  isKeyboardOpen = endFrame.origin.y < weakSelf.view.bottom;//键盘打开
        CGFloat padding = isKeyboardOpen ? weakSelf.view.bottom - weakSelf.shortcutKeyView.top : 0 + TabbarSafeBottomMargin;
        [weakSelf.editView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.view).offset(- padding);
        }];
        [weakSelf.view updateConstraintsIfNeeded];
        [weakSelf.view layoutIfNeeded];
            //end
    };
    
    
    void(^completion)(BOOL) = ^(BOOL finished){
    };
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionLayoutSubviews animations:animations completion:completion];
}

    //  键盘弹出触发该方法
- (void)keyboardDidShow
{
    NSLog(@"键盘弹出");
}
    //  键盘隐藏触发该方法
- (void)keyboardDidHide
{
    NSLog(@"键盘收起");
    self.shortcutKeyView.top = self.view.bottom;
}




@end
/*
  NSData *data = [self.textView.text dataUsingEncoding:NSUTF8StringEncoding];
  NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
  NSString *filePath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.md", self.titleTextField.text]];
  //写入文件
  [data writeToFile:filePath atomically:YES];
  NSLog(@"md成功保存，地址%@", filePath);
 */
