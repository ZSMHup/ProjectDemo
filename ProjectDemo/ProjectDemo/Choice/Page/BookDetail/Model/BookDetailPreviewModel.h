//
//  BookDetailPreviewModel.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "NetworkRequestModel.h"

@interface BookDetailPreviewModel : NetworkRequestModel

@property (nonatomic, copy) NSString *bookCode;
@property (nonatomic, copy) NSString *resourceType; // PREVIEW_VIDEO PREVIEW_IMG
@property (nonatomic, copy) NSString *ossUrl;
@property (nonatomic, copy) NSString *coverUrl;

@end
