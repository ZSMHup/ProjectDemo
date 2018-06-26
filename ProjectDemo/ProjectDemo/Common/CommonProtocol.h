//
//  CommonProtocol.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DidSelectItemDelegate <NSObject>
@optional

- (void)view:(UICollectionViewCell *)view didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end
