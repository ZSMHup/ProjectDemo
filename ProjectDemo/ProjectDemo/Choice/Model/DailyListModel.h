//
//  DailyListModel.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "NetworkRequestModel.h"

@interface DailyListModel : NetworkRequestModel

@property (nonatomic, copy) NSString *dailyCode;
/**标题*/
@property (nonatomic, copy) NSString *dailyTitle;
/**封面图*/
@property (nonatomic, copy) NSString *dailyImg;
/**H5详情页面*/
@property (nonatomic, copy) NSString *targetPage;

@end
