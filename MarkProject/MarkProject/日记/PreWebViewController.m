//
//  PreWebViewController.m
//  MarkProject
//
//  Created by MAC on 2020/4/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import "PreWebViewController.h"
#import <WebKit/WebKit.h>
#import <MMMarkdown/MMMarkdown.h>

@interface PreWebViewController ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) WKWebView *WebView;
@end

@implementation PreWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.WebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
- (void)refreshMarkdown:(NSString *)markdown WithCss:(NSString *)cssString
{
    if ([cssString isEqualToString:@""]) {
        cssString = @"markdown";
    }
    NSString *css = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:cssString ofType:@"css"] encoding:NSUTF8StringEncoding error:nil];
    NSString *headHtmlStr = [NSString stringWithFormat:@"<head><style>%@</style><style>img{max-width:%fpx !important;}</style></head><meta name='viewport' content='width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no' />",css,SCREEN_WIDTH*0.8-40];
    NSString *htmlString = [MMMarkdown HTMLStringWithMarkdown:markdown extensions:MMMarkdownExtensionsGitHubFlavored error:NULL];
    htmlString = [headHtmlStr stringByAppendingString:htmlString];
    [self.WebView loadHTMLString:htmlString baseURL:nil];
}
#pragma mark  - ------  懒加载  ------
- (WKWebView *)WebView
{
    if (!_WebView) {
        _WebView = [[WKWebView alloc] init];
        _WebView.backgroundColor = GrayWhiteColor;
        _WebView.UIDelegate = self;
        _WebView.navigationDelegate = self;
        _WebView.scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_WebView];
    }
    return _WebView;
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSString *bodyStyle = @"document.getElementsByTagName('body')[0].style.padding = '20px';";
//    [self.webView stringByEvaluatingJavaScriptFromString:bodyStyle];
    [webView evaluateJavaScript:bodyStyle completionHandler:nil];
}
@end
