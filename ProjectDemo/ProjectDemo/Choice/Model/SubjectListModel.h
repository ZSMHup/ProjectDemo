//
//  SubjectListModel.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "NetworkRequestModel.h"

@interface SubjectListModel : NetworkRequestModel

@property (nonatomic, copy) NSString *subjectCode; // 专题编号
@property (nonatomic, copy) NSString *subjectTitle; // 专题标题
@property (nonatomic, copy) NSString *bgImageUrl; //  背景图片地址
@property (nonatomic, copy) NSString *bgImageUpUrl; // 背景图片图标地址
@property (nonatomic, copy) NSString *targetType; // 跳转的目标类型 BOOK_DETAIL:图书详情 ,H5:H5页面,SYSTEM_INTERFACE:系统界面 ,BOOK_LIST:图书列表页
@property (nonatomic, copy) NSString *targetPage; // 跳转内容
@property (nonatomic, copy) NSString *idx; // idx

@end
