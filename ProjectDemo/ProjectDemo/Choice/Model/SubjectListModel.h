//
//  SubjectListModel.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "NetworkRequestModel.h"

@interface SubjectListModel : NetworkRequestModel

/**标题*/
@property (nonatomic, copy) NSString *subjectTitle;
/**ID*/
@property (nonatomic, copy) NSString *idx;
@property (nonatomic, copy) NSString *categoryId;
/***/
@property (nonatomic, copy) NSString *subjectCode;
/**封面图*/
@property (nonatomic, copy) NSString *bgImageUrl;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *targetType;
@property (nonatomic, copy) NSString *targetPage;
@property (nonatomic, copy) NSString *bgImageUpUrl;

@end
