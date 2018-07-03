//
//  AudioPlayerManager.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/29.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface AudioPlayerManager : NSObject

@property (nonatomic, copy) void(^playToEnd)(void);
+ (instancetype)sharedInstance;
- (void)playerWithURL:(NSString *)url;

@end
