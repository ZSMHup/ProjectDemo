//
//  HomeSectionView.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeListModel;
@interface HomeSectionView : UICollectionReusableView

@property (nonatomic, strong) HomeListModel *model;

@property (nonatomic, strong) void(^sectionViewClick)(void);

@end
