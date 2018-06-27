//
//  UIColor+Custom.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Custom)

/**
 默认主色调 蓝色
 */
+ (UIColor *)mainColor;

/**
 页面背景色 淡灰
 */
+ (UIColor *)backgroundColor;

/**
 白色 带alpha

 @param alpha 透明度
 */
+ (UIColor *)whiteColor:(CGFloat)alpha;

/**
 黑色 带alpha
 
 @param alpha 透明度
 */
+ (UIColor *)blackColor:(CGFloat)alpha;

@end
