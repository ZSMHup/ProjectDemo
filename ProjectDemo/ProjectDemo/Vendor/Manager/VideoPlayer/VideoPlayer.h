//
//  VideoPlayer.h
//  ProjectDemo
//
//  Created by zhangshumeng on 2018/6/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPlayer : UIView

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *coveUrl;

+ (void)showPlayerWithURL:(NSString *)url coveUrl:(NSString *)coveUrl;

@end
