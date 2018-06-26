//
//  AYWebView.h
//  AYCommon
//
//  Created by 张书孟 on 2018/5/16.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface AYWebView : WKWebView

/** 进度条颜色(默认蓝色) */
@property (nonatomic, strong) UIColor *progressViewColor;
/** 导航栏存在且有穿透效果(默认导航栏存在且有穿透效果) */
@property (nonatomic, assign) BOOL isNavigationBarOrTranslucent;


/**
 加载 web
 
 @param urlString 地址
 */
- (void)loadRequestWithUrlString:(NSString *)urlString;

/**
 加载本地资源
 
 @param fileName 该资源的名称（一定要加后缀）
 */
- (void)loadFileName:(NSString *)fileName;

/**
 加载本地资源
 
 @param filePath 本地资源路径
 */
- (void)loadFileWithFilePath:(NSString *)filePath;

/**
 刷新数据
 */
- (void)reloadData;

/**
 返回上一页
 */
- (void)goBack;

/**
 进入下一页
 */
- (void)goForward;

/**
 清除WKWebView的所有缓存（只能 iOS9 以后使用）
 
 @param completion 清除成功之后的回调
 */
- (void)removeAllCached:(void(^)(void))completion;

@end
