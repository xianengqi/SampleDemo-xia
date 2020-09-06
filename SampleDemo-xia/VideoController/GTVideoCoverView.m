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
    }
    return self;
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
    AVPlayerItem *videoItem = [AVPlayerItem playerItemWithAsset:asset];
    AVPlayer *avPlayer = [AVPlayer playerWithPlayerItem:videoItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
    // 调整大小
    playerLayer.frame = _coverView.bounds;
    // 然后将它粘贴到_coverView上
    [_coverView.layer addSublayer:playerLayer];
    // 最后呢调用一下播放
    [avPlayer play];
    NSLog(@"");
}

@end
