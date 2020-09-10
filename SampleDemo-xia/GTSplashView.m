//
//  GTSplashView.m
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/9/10.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTSplashView.h"
#import "GTScreen.h"

// 在整个的闪屏图片上增加一个按钮, 来让用户手动的点击来消失
@interface GTSplashView()

@property(nonatomic, strong, readwrite)UIButton *button;

@end

@implementation GTSplashView

// 启动图（延长闪屏图片）显示时间
- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"icon.bundle/splash.png"];
        [self addSubview:({
            _button = [[UIButton alloc] initWithFrame:UIRect(330, 100, 60, 40)];
            _button.backgroundColor = [UIColor lightGrayColor];
            [_button setTitle:@"跳过" forState:UIControlStateNormal];
            // 增加点击事件
            [_button addTarget:self action:@selector(_removeSplashView) forControlEvents:UIControlEventTouchUpInside];
            _button;
        })];
        // 设置允许它点击
        self.userInteractionEnabled = YES;
    }
    return self;
}

#pragma mark -

- (void)_removeSplashView{
    // 点击的时候直接remove掉就可以
    [self removeFromSuperview];
}

@end
