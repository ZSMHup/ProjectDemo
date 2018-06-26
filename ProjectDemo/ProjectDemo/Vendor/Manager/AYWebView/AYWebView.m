//
//  AYWebView.m
//  AYCommon
//
//  Created by 张书孟 on 2018/5/16.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "AYWebView.h"

#define kAYNavigationBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height + 44.f)

@interface AYWebView () <WKNavigationDelegate, WKUIDelegate>

// 进度条
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation AYWebView

static CGFloat const progressViewHeight = 2;

/// dealloc
- (void)dealloc
{
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:nil];
        [self addProgressView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration
{
    self = [super initWithFrame:frame configuration:configuration];
    if (self) {
        [self addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:nil];
        [self addProgressView];
    }
    return self;
}

#pragma mark - private
// 9.0以下将文件夹copy到tmp目录
- (NSURL *)fileURLForBuggyWKWebView:(NSURL *)fileURL
{
    NSError *error = nil;
    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error]) { //file URL 指向的文件资源是否可获取
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *temDirURL = [NSURL fileURLWithPath:NSTemporaryDirectory()];
    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
    
    [fileManager removeItemAtURL:dstURL error:&error];
    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
    
    return dstURL;
}

#pragma mark Public
// 加载 web
- (void)loadRequestWithUrlString:(NSString *)urlString
{
    NSString *encodedString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:encodedString]]];
}

// 加载本地资源
- (void)loadFileName:(NSString *)fileName
{
    NSString *fileURL = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSString *readAccessToURL = [fileURL stringByDeletingLastPathComponent]; // 获取上一级路径
    if (@available(iOS 9.0, *)) {
        [self loadFileURL:[NSURL fileURLWithPath:fileURL] allowingReadAccessToURL:[NSURL fileURLWithPath:readAccessToURL]];
    } else { // 9.0以下
        NSURL *fileUrl = [NSURL fileURLWithPath:fileURL];
        // 把文件夹转到tmp目录
        fileUrl = [self fileURLForBuggyWKWebView:fileUrl];
        if (fileURL) {
            NSURL *realUrl = [NSURL fileURLWithPath:fileUrl.path];
            NSURLRequest *request = [NSURLRequest requestWithURL:realUrl];
            [self loadRequest:request];
        }
    }
}

// 加载本地资源
- (void)loadFileWithFilePath:(NSString *)filePath
{
    NSString *readAccessToURL = [filePath stringByDeletingLastPathComponent]; // 获取上一级路径
    
    if (@available(iOS 9.0, *)) {
        [self loadFileURL:[NSURL fileURLWithPath:filePath] allowingReadAccessToURL:[NSURL fileURLWithPath:readAccessToURL]];
    } else { // 9.0以下
        if(filePath) {
            NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
            // 把文件夹转到tmp目录
            fileUrl = [self fileURLForBuggyWKWebView:fileUrl];
            if (fileUrl) {
                NSURL *realUrl = [NSURL fileURLWithPath:fileUrl.path];
                NSURLRequest *request = [NSURLRequest requestWithURL:realUrl];
                [self loadRequest:request];
            }
        }
    }
}

// 刷新数据
- (void)reloadData
{
    [self reload];
}

// 返回
- (void)goBack
{
    if ([self canGoBack]) {
        [self goBack];
    }
}

// 前进
- (void)goForward
{
    if ([self canGoForward]) {
        [self goForward];
    }
}

// 清除缓存
- (void)removeAllCached:(void(^)(void))completion
{
    if (@available(iOS 9.0, *)) {
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            if (completion) {
                completion();
            }
        }];
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark KVO
// KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self) {
        self.progressView.alpha = 1.0;
        BOOL animated = self.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.estimatedProgress animated:animated];
        if (self.estimatedProgress >= 0.97) {
            [UIView animateWithDuration:0.1 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.progressView.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0 animated:NO];
            }];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark  加载的状态回调（WKNavigationDelegate）

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.progressView.alpha = 0.0;
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    self.progressView.alpha = 0.0;
}

// 在js端调用alert函数时，会触发此方法
// js端调用alert时所传的数据可以通过message拿到
// 在原生得到结果后，需要回调js，是通过completionHandler回调
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{

}
//
// 在js端调用Confirm函数时，会触发此方法
// 通过message可以拿到js端所传的数据
// 在iOS端显示原生alert得到YES／NO
// 在原生得到结果后，需要回调js，是通过completionHandler回调
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{

}

// 在js端调用Prompt函数时，会触发此方法
// 要求输入一段文本
// 在原生输入得到内容后，通过completionHandler回调给js
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler
{

}

#pragma mark getter
- (void)addProgressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.trackTintColor = [UIColor clearColor];
        // 高度默认有导航栏且有穿透效果
        _progressView.frame = CGRectMake(0, kAYNavigationBarHeight, self.frame.size.width, progressViewHeight);
        // 设置进度条颜色
        _progressView.tintColor = [UIColor greenColor];
        [self addSubview:_progressView];
    }
}

#pragma mark  setter

- (void)setProgressViewColor:(UIColor *)progressViewColor
{
    _progressViewColor = progressViewColor;
    
    if (progressViewColor) {
        _progressView.tintColor = progressViewColor;
    }
}

- (void)setIsNavigationBarOrTranslucent:(BOOL)isNavigationBarOrTranslucent
{
    _isNavigationBarOrTranslucent = isNavigationBarOrTranslucent;
    if (isNavigationBarOrTranslucent == YES) { // 导航栏存在且有穿透效果
        _progressView.frame = CGRectMake(0, kAYNavigationBarHeight, self.frame.size.width, progressViewHeight);
    } else { // 导航栏不存在或者没有有穿透效果
        _progressView.frame = CGRectMake(0, 0, self.frame.size.width, progressViewHeight);
    }
}

@end
