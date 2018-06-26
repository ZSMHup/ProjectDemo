//
//  BaseViewController.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)dealloc {
    NSLog(@"dealloc: %@", [self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setNavTransparent:(BOOL)isTransparent {
    if (isTransparent) {
        [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    } else {
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor orangeColor]] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)setNavBlackLine:(BOOL)showLine {
    self.navigationController.navigationBar.shadowImage = showLine ? [[UIImage alloc] init] : nil;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color bounds:CGRectMake(0, 0, 1, 1)];
}

- (UIImage *)imageWithColor:(UIColor *)color bounds:(CGRect)bounds {
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, bounds);
    UIImage *outImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outImg;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    ///这里设置白色
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

@end
