//
//  CommenWebViewController.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "CommenWebViewController.h"
#import "BookDetailViewController.h"

#import "AYWebView.h"

#import "BookListModel.h"

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

- (void)customActionHandler:(NSURL *)url {
    NSString *host = [url host];
    if ([host isEqualToString:@"detail.book"]) {
        NSArray *tempArr1 = [[url query] componentsSeparatedByString:@"&"];
        NSArray *tempArr2 = [[tempArr1 firstObject] componentsSeparatedByString:@"="];
        NSString *bookCode = tempArr2.lastObject;
        BookListModel *bookListModel = [[BookListModel alloc] init];
        bookListModel.bookCode = bookCode;
        BookDetailViewController *detailVC = [[BookDetailViewController alloc] init];
        detailVC.bookListModel = bookListModel;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
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

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *url = navigationAction.request.URL;
    NSString *scheme = [url scheme];
    if ([scheme isEqualToString:@"ellabook2"]) {
        [self customActionHandler:url];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
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
