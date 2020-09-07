//
//  GTVideoPlayer.m
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/9/7.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTVideoPlayer.h"

// 引入AVFoundation.h ，用来展示视频
#import <AVFoundation/AVFoundation.h>

@interface GTVideoPlayer ()

@property (nonatomic, strong, readwrite) AVPlayerItem *videoItem;
@property (nonatomic, strong, readwrite) AVPlayer *avPlayer;
@property (nonatomic, strong, readwrite) AVPlayerLayer *playerLayer;

@end

@implementation GTVideoPlayer

+ (GTVideoPlayer *)Player {
    // 实现单例模式
    static GTVideoPlayer *player;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[GTVideoPlayer alloc] init];
    });
    return player;
}

- (void)playVideoWithUrl:(NSString *)videoUrl attachView:(UIView *)attachView {
    // 为了保证全局只有一个播放器, 需要将原来的播放器销毁掉
    [self _stopPlay];
    
    NSURL *videoURL = [NSURL URLWithString:videoUrl];
    AVAsset *asset = [AVAsset assetWithURL:videoURL];
    _videoItem = [AVPlayerItem playerItemWithAsset:asset];
    // 使用kvo监听状态
    [_videoItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    // 缓冲状态
    [_videoItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];

    // 获取视频相关的时长
    CMTime duration = _videoItem.duration;
    // 转换成方便理解的时长
    CGFloat videoDuration = CMTimeGetSeconds(duration);

    _avPlayer = [AVPlayer playerWithPlayerItem:_videoItem];
    // 播放状态获取
    [_avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        NSLog(@"播放进度: %@", @(CMTimeGetSeconds(time)));
    }];

    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    // 调整大小
    _playerLayer.frame = attachView.bounds;
    // 然后将它粘贴到_coverView上
    [attachView.layer addSublayer:_playerLayer];
    // 最后呢调用一下播放
    //    [_avPlayer play];

    // 中心化管理，监听一个事件, 它是一个单例
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handlePlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    NSLog(@"");
}

// 预留一个函数，来响应点击
- (void)_stopPlay {
    // 播放结束时，移除掉
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [_playerLayer removeFromSuperlayer];

    [_videoItem removeObserver:self forKeyPath:@"status"];
    [_videoItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    // 销毁整个的播放器
    _videoItem = nil;
    _avPlayer = nil;
}

- (void)_handlePlayEnd {
    // 视频播放结束后重复播放的操作
    [_avPlayer seekToTime:CMTimeMake(0, 1)];
    [_avPlayer play];
}

#pragma mark - KVO
// 变化时候的操作
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context {
    // 首先先判断keyPath监听是否为status
    // 判断网络请求状态，status  fail
    if ([keyPath isEqualToString:@"status"]) {
        if (((NSNumber *)[change objectForKey:NSKeyValueChangeNewKey]).integerValue == AVPlayerItemStatusReadyToPlay
            ) {
            [_avPlayer play];
        } else {
            NSLog(@"");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {  // 如果有缓冲，就展示下面的逻辑
        NSLog(@"缓冲：%@", [change objectForKey:NSKeyValueChangeNewKey]);
    }
}

@end
