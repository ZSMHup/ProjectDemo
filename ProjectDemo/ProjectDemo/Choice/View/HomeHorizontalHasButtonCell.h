//
//  HomeHorizontalHasButtonCell.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BookListModel;
@interface HomeHorizontalHasButtonCell : UICollectionViewCell

@property (nonatomic, strong) NSArray <BookListModel *>*dataSource;

@end
