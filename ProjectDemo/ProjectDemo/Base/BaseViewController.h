//
//  BaseViewController.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)setNavTransparent:(BOOL)isTransparent;
- (void)setNavBlackLine:(BOOL)showLine;

/**
 导航栏背景渐变

 @param alpha 透明度
 */
- (void)setNavBarAlpha:(CGFloat)alpha;

@end
