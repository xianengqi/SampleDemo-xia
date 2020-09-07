//
//  GTVideoCoverView.m
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/9/6.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTVideoCoverView.h"
// 引入AVFoundation.h ，用来展示视频
#import <AVFoundation/AVFoundation.h>

@interface GTVideoCoverView()

@property(nonatomic, strong, readwrite) AVPlayerItem *videoItem;
@property(nonatomic, strong, readwrite) AVPlayer *avPlayer;
@property(nonatomic, strong, readwrite) AVPlayerLayer *playerLayer;

@property(nonatomic, strong, readwrite) UIImageView *coverView;
// 加入一个播放按钮
@property(nonatomic, strong, readwrite) UIImageView *playButton;
// 视屏url
@property(nonatomic, copy, readwrite) NSString *videoUrl;

@end

@implementation GTVideoCoverView

// 在初始化的时候，加入
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            // 创建
            _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            _coverView;
        })];
        [_coverView addSubview:({
            // 创建播放按钮
            // 播放按钮居中显示
            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width -50) / 2, (frame.size.height -50) / 2, 50, 50)];
            _playButton.image = [UIImage imageNamed:@"icon.bundle/video@2x.png"];
            _playButton;
        })];
        // 为了响应整个点击事件, 加上手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tapGesture];
        
        // 中心化管理，监听一个事件, 它是一个单例
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handlePlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        
    }
    return self;
}

// 中心化管理是走的整个app生命周期，生命周期走完后记得把单例移除
- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_videoItem removeObserver:self forKeyPath:@"status"];
    [_videoItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

#pragma mark - public method

- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl{
    _coverView.image = [UIImage imageNamed:videoCoverUrl];
    
    _videoUrl = videoUrl;
}

#pragma mark - private method
// 预留一个函数，来响应点击
- (void) _tapToPlay {
    NSURL *videoURL = [NSURL URLWithString:_videoUrl];
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
    _playerLayer.frame = _coverView.bounds;
    // 然后将它粘贴到_coverView上
    [_coverView.layer addSublayer:_playerLayer];
    // 最后呢调用一下播放
//    [_avPlayer play];
    NSLog(@"");
}

- (void) _handlePlayEnd {
//    // 播放结束时，移除掉
//    [_playerLayer removeFromSuperlayer];
//    // 销毁整个的播放器
//    _videoItem = nil;
//    _avPlayer = nil;
    
    // 视频播放结束后重复播放的操作
    [_avPlayer seekToTime:CMTimeMake(0, 1)];
    [_avPlayer play];
}

#pragma mark - KVO
// 变化时候的操作
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
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
