//
//  GTVideoCoverView.m
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/9/6.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTVideoCoverView.h"
#import "GTVideoPlayer.h"
#import "GTVideoToolBar.h"

@interface GTVideoCoverView ()

@property (nonatomic, strong, readwrite) UIImageView *coverView;
// 加入一个播放按钮
@property (nonatomic, strong, readwrite) UIImageView *playButton;
// 视屏url
@property (nonatomic, copy, readwrite) NSString *videoUrl;
// 展示自适应布局
@property(nonatomic, strong, readwrite)GTVideoToolBar *toolBar;

@end

@implementation GTVideoCoverView

// 在初始化的时候，加入
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            // 创建
            _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - GTVideoToolBarHeight)];
            _coverView;
        })];
        [_coverView addSubview:({
            // 创建播放按钮
            // 播放按钮居中显示
            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - GTVideoToolBarHeight - 50) / 2, (frame.size.height - 50) / 2, 50, 50)];
            _playButton.image = [UIImage imageNamed:@"icon.bundle/video@2x.png"];
            _playButton;
        })];
        // 这里粘贴上toolBar
        [self addSubview:({
            _toolBar = [[GTVideoToolBar alloc] initWithFrame:CGRectMake(0, _coverView.bounds.size.height, frame.size.width, GTVideoToolBarHeight)];
            _toolBar;
        })];
        // 为了响应整个点击事件, 加上手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

// 中心化管理是走的整个app生命周期，生命周期走完后记得把单例移除
- (void)dealloc {
}

#pragma mark - public method

- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl {
    _coverView.image = [UIImage imageNamed:videoCoverUrl];
    _videoUrl = videoUrl;
    [_toolBar layoutWithModel:nil];
}

#pragma mark - private method
// 预留一个函数，来响应点击
- (void)_tapToPlay {
    // 每当点击需要播放的时候
    [[GTVideoPlayer Player] playVideoWithUrl:_videoUrl attachView:_coverView];
}

@end
