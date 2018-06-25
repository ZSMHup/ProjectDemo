//
//  TabBarController.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "TabBarController.h"
#import "HomeChoiceViewController.h"
#import "MyStudyViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self foundTabBarControllers];
}

- (void)foundTabBarControllers {
    [self addChildViewController:[[HomeChoiceViewController alloc] init] image:@"tab_community_nor" seletedImage:@"tab_community_press" title:nil];
    [self addChildViewController:[[MyStudyViewController alloc] init] image:@"tab_me_nor"  seletedImage:@"tab_me_press"  title:nil];
}

- (void)addChildViewController:(UIViewController *)childController image:(NSString *)image seletedImage:(NSString *)selectedImage title:(NSString *)title {
    childController.title = title;
    childController.navigationItem.backBarButtonItem = nil;
    [childController.tabBarItem setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [childController.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    /*
     调整tabbar 文字位置
     */
    //[childController.tabBarItem setTitlePositionAdjustment:(UIOffset){0,100}];
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad || ([[UIDevice currentDevice].systemVersion floatValue] <= 11 &&  [[UIDevice currentDevice].systemVersion floatValue] <= 11)){
        [childController.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
    }
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}

@end
