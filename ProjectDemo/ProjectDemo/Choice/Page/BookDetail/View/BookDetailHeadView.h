//
//  BookDetailHeadView.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookDetailModel.h"

@interface BookDetailHeadView : UIView

@property (nonatomic, strong) BookDetailModel *bookDetailModel;

- (instancetype)initWithFrame:(CGRect)frame bookDetailModel:(BookDetailModel *)bookDetailModel;

@end
