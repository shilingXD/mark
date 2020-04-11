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

@interface MDEditViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *wkWebView;///<<#注释#>
@end

@implementation MDEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)setupWebView
{
    
    
    _wkWebView = [[WKWebView alloc] init];
    _wkWebView.UIDelegate = self;
    //        _teacherIntroductionContentWebView.userInteractionEnabled = NO;
    _wkWebView.navigationDelegate = self;
    _wkWebView.scrollView.scrollEnabled = NO;
    _wkWebView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_wkWebView];
    NSString *markdown   = @"# Example\nWhat a library!";
    NSString *htmlString = [MMMarkdown HTMLStringWithMarkdown:markdown extensions:MMMarkdownExtensionsGitHubFlavored error:NULL];
    NSLog(@"%@",htmlString);
    NSString *htmlstr = [@"<meta name='viewport' content='width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no' />" stringByAppendingString:htmlString];
    [self.wkWebView loadHTMLString:htmlstr baseURL:nil];
}


@end
