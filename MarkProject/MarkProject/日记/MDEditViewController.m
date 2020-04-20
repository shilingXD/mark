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

@interface MDEditViewController ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate,YYTextViewDelegate>
@property (nonatomic, strong) YYTextView *editView;///<编辑框
@property (nonatomic, strong) GNEditShortcutKeyBar *shortcutKeyView;
@property (nonatomic, assign) BOOL isShowPreview;//预览
@end

@implementation MDEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self.view addSubview:self.editView];
    [self.editView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).offset(NavigationBar_Height);
        make.left.right.bottom.top.mas_equalTo(self.view);
    }];
}
-(void)setNav
{
    [self.navigationView setTitle:self.title];
    self.view.backgroundColor = TintColor;
    self.navigationView.backgroundView.image = nil ;
    self.navigationView.backgroundView.backgroundColor = TintColor;
    self.navigationView.lineView.backgroundColor = TintColor;
    
}
- (YYTextView *)editView
{
    if (!_editView) {
        YYTextSimpleMarkdownParser *parser = [YYTextSimpleMarkdownParser new];
        [parser setColorWithDarkTheme];
        
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
        textView.backgroundColor = [UIColor colorWithWhite:0.134 alpha:1.000];
        textView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        textView.scrollIndicatorInsets = textView.contentInset;
        //        textView.selectedRange = NSMakeRange(text.length, 0);
        [self.view addSubview:textView];
        self.editView = textView;
    }
    return _editView;
}
@end
