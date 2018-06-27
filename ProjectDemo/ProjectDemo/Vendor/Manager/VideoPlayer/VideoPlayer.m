//
//  VideoPlayer.m
//  ProjectDemo
//
//  Created by zhangshumeng on 2018/6/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "VideoPlayer.h"

#import <ZFPlayer/ZFPlayer.h>

@interface VideoPlayer ()

@property (nonatomic, strong) ZFPlayerView *videoPlayer;
@property (nonatomic, strong) ZFPlayerModel *playerModel;

@end

@implementation VideoPlayer

- (ZFPlayerModel *)playerModel {
    if (!_playerModel) {
        _playerModel = [[ZFPlayerModel alloc] init];
        _playerModel.title = @"这里设置视频标题";
        _playerModel.videoURL = [NSURL URLWithString:self.url];
        _playerModel.placeholderImage = [UIImage imageNamed:@"loading_bgView1"];
//        _playerModel.fatherView = self.playerFatherView;
    }
    return _playerModel;
}

- (ZFPlayerView *)videoPlayer {
    if (!_videoPlayer) {
        _videoPlayer = [[ZFPlayerView alloc] init];
        [_videoPlayer playerModel:self.playerModel];
        
    }
    return _videoPlayer;
}

@end
