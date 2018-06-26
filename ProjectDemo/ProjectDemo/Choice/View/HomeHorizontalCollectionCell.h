//
//  HomeHorizontalCollectionCell.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BookListModel;

@interface HomeHorizontalCollectionCell : UICollectionViewCell

@property (nonatomic, strong) BookListModel *bookListModel;
@property (nonatomic, strong) BookListModel *bookModel;

@end
