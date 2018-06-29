//
//  AudioPlayerManager.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/29.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "AudioPlayerManager.h"

@interface AudioPlayerManager ()

@property (nonatomic, strong) AVPlayer *audioPlayer;
@property (nonatomic, strong) AVPlayerItem *currentPlayerItem;

@end

@implementation AudioPlayerManager

static AudioPlayerManager *_audioPlayer;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _audioPlayer = [super allocWithZone:zone];
    });
    
    return _audioPlayer;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return _audioPlayer;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _audioPlayer = [[self alloc] init];
    });
    return _audioPlayer;
}

- (void)playerWithURL:(NSString *)url {
    NSLog(@"url: %@", url);
    NSURL *playerUrl = [NSURL URLWithString:url];
    _currentPlayerItem = [AVPlayerItem playerItemWithURL:playerUrl];
    self.audioPlayer = [[AVPlayer alloc] initWithPlayerItem:_currentPlayerItem];
//    [self addMusicTimeMake]; //监听时间变化
//    _isPlay = YES;
//    [_player play];  //需要注意的是初始化完player之后不一定会马上开始播放，需要等待player的状态变为ReadyToPlay才会进行播放。
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:_currentPlayerItem];  //播放完后进行回调。播放完后一般都会进行播放下一首的操作。
    [self.audioPlayer play];
}

//- (AVPlayer *)audioPlayer {
//    if (!_audioPlayer) {
//        _audioPlayer = [[AVPlayer alloc] init];
//    }
//    return _audioPlayer;
//}

@end
