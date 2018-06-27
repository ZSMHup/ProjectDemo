//
//  BookPriceModel.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "NetworkRequestModel.h"

@interface BookPriceModel : NetworkRequestModel

@property (nonatomic, copy) NSString *goodsMarketprice;
@property (nonatomic, copy) NSString *goodsSrcPrice;
@property (nonatomic, copy) NSString *goodsPrice;

@end
