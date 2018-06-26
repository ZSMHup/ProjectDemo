//
//  HomeHorizontalCell.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonProtocol.h"

@class BookListModel;
@interface HomeHorizontalCell : UICollectionViewCell

@property (nonatomic, strong) NSArray <BookListModel *>*dataSource;

@property (nonatomic, weak) id <DidSelectItemDelegate> delegate;

@end
