//
//  HomeSubjectCell.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonProtocol.h"

@interface HomeSubjectCell : UICollectionViewCell
@property (nonatomic, weak) id <DidSelectItemDelegate> delegate;

@end
