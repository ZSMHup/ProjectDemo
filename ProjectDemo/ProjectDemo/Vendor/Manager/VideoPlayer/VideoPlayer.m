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

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) UIView *playerFatherView;
@property (nonatomic, strong) ZFPlayerView *videoPlayer;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (nonatomic, strong) ZFPlayerControlView *defaultControlView;

@end

@implementation VideoPlayer

- (void)dealloc {
    NSLog(@"VideoPlayer - dealloc");
}

// 视频播放
+ (void)showPlayerWithURL:(NSString *)url coveUrl:(NSString *)coveUrl {
    VideoPlayer *player = [[VideoPlayer alloc] initWithFrame:[UIScreen mainScreen].bounds];
    player.backgroundColor = [UIColor blackColor];
    player.url = url;
    player.coveUrl = coveUrl;
    [player addSubViews];
    player.window = [UIApplication sharedApplication].keyWindow;
    player.window.windowLevel = UIWindowLevelAlert;
    [player.window addSubview:player];
    [player show:player];
}

- (void)addSubViews {
    
    [self addSubview:self.playerFatherView];
    [self.playerFatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.videoPlayer autoPlayTheVideo];
    [self addCloseBtn];
}

- (void)show:(VideoPlayer *)videoPlayer {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.25;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeBackwards;
    animation.values = @[
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 1.0)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]
                         ];
    [videoPlayer.layer addAnimation:animation forKey:nil];
}

- (void)hidden {
    
    self.window.windowLevel = UIWindowLevelNormal;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

- (void)closeBtnClick {
    
    [self hidden];
    [self.videoPlayer pause];
    self.videoPlayer = nil;
}

#pragma mark - getter
- (void)addCloseBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setTitle:@"关闭" forState:(UIControlStateNormal)];
        [_closeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_closeBtn];
        [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.top.equalTo(self.mas_top).offset(20);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    }
}

- (UIView *)playerFatherView {
    if (!_playerFatherView) {
        _playerFatherView = [[UIView alloc] init];
        _playerFatherView.backgroundColor = [UIColor whiteColor];
    }
    return _playerFatherView;
}

- (ZFPlayerControlView *)defaultControlView {
    if (!_defaultControlView) {
        _defaultControlView = [[ZFPlayerControlView alloc] init];
    }
    return _defaultControlView;
}

- (ZFPlayerModel *)playerModel {
    if (!_playerModel) {
        _playerModel = [[ZFPlayerModel alloc] init];
        _playerModel.videoURL = [NSURL URLWithString:self.url];
        _playerModel.placeholderImageURLString = self.coveUrl;
        _playerModel.fatherView = self.playerFatherView;
    }
    return _playerModel;
}

- (ZFPlayerView *)videoPlayer {
    if (!_videoPlayer) {
        _videoPlayer = [[ZFPlayerView alloc] init];
        [_videoPlayer playerControlView:self.defaultControlView playerModel:self.playerModel];
        _videoPlayer.hasPreviewView = YES;
    }
    return _videoPlayer;
}

@end
