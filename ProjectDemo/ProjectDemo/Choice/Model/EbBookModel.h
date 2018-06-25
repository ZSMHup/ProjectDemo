//
//  EbBookModel.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "NetworkRequestModel.h"

@interface EbBookModel : NetworkRequestModel

@property (nonatomic, copy) NSString *bookCode; //
@property (nonatomic, copy) NSString *resourceType; // 模式类型 BOOK_COVER:图书封面,BOOK_TRY_READ:试读
@property (nonatomic, copy) NSString *resource; // 设备型号 normal
@property (nonatomic, copy) NSString *ossUrl; // 资源地址
@property (nonatomic, copy) NSString *statu; // 可用状态 EXCEPTION:不可用 ,NORMAL:可用
@property (nonatomic, copy) NSString *isDefault; // 是否默认资源 DEFAULT_NO:否 ,DEFAULT_YES:是
@property (nonatomic, copy) NSString *resourceVersion; // 资源版本

@end
