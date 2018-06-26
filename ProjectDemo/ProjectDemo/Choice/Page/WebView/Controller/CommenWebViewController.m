//
//  CommenWebViewController.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "CommenWebViewController.h"

#import "AYWebView.h"

@interface CommenWebViewController () <WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) AYWebView *wkWebView;
@property (nonatomic, strong) WKWebViewConfiguration *configuration;

@end

@implementation CommenWebViewController

- (void)dealloc {
    [self.configuration.userContentController removeAllUserScripts];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubViews];
}

- (void)addSubViews {
    [self.view addSubview:self.wkWebView];
}

- (WKWebViewConfiguration *)config {
    self.configuration = [[WKWebViewConfiguration alloc] init];
    self.configuration.userContentController = [[WKUserContentController alloc] init];
    [self.configuration.userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"PushToBookDetails"];
    return self.configuration;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.navigationItem.title = webView.title;

    NSString *str = @"document.getElementsByClassName('btn_share_Wrap')[0].remove();";
    [webView evaluateJavaScript:str completionHandler:nil];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"PushToBookDetails"]) {
        NSLog(@"PushToBookDetails");
    }
}

- (AYWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[AYWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) configuration:[self config]];
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        _wkWebView.isNavigationBarOrTranslucent = NO;
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        [_wkWebView loadRequestWithUrlString:self.webUrl];
    }
    return _wkWebView;
}

@end

@implementation WeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}

@end
