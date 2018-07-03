//
//  AudioPlayerManager.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/29.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "AudioPlayerManager.h"
#import "AYFileDownloadManager.h"

#define AudioPlayerFileName @"AudioPlayerFileName"

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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)playerWithURL:(NSString *)url {
//    AudioPlayerManager *manager = [[AudioPlayerManager alloc] init];
    
    if ([[AYFileDownloadManager sharedInstance] isExistence:url fileName:AudioPlayerFileName] && [[AYFileDownloadManager sharedInstance] isCompletion:url fileName:AudioPlayerFileName]) {
        
        NSURL *playerUrl = [NSURL fileURLWithPath:[[AYFileDownloadManager sharedInstance] getFileWithURL:url fileName:AudioPlayerFileName]];
        self.currentPlayerItem = [AVPlayerItem playerItemWithURL:playerUrl];
        self.audioPlayer = [[AVPlayer alloc] initWithPlayerItem:self.currentPlayerItem];
        [self.audioPlayer play];
    } else {
        __weak typeof(self) weakManager = self;
        [[AYFileDownloadManager sharedInstance] downloadWithURL:url attribute:nil fileName:AudioPlayerFileName progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
            NSLog(@"progress: %f", progress);
        } state:^(DownloadState state) {
            NSLog(@"state: %u", state);
            if (state == DownloadStateCompleted) {
                NSURL *playerUrl = [NSURL fileURLWithPath:[[AYFileDownloadManager sharedInstance] getFileWithURL:url fileName:AudioPlayerFileName]];
                weakManager.currentPlayerItem = [AVPlayerItem playerItemWithURL:playerUrl];
                weakManager.audioPlayer = [[AVPlayer alloc] initWithPlayerItem:weakManager.currentPlayerItem];
                [weakManager.audioPlayer play];
            }
        }];
    }
    
    [self addObserver];
}

- (void)addObserver {
    AVPlayerItem * songItem = self.currentPlayerItem;
    //播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished) name:AVPlayerItemDidPlayToEndTimeNotification object:songItem];
}

- (void)playbackFinished {
    NSLog(@"播放完成");
    
}

- (void)player {
    if (self.audioPlayer.status == AVPlayerStatusReadyToPlay) {
        [self.audioPlayer pause];
    }
}

- (void)pause {
    if (self.audioPlayer.status == AVPlayerStatusReadyToPlay) {
        [self.audioPlayer pause];
    }
}


@end
