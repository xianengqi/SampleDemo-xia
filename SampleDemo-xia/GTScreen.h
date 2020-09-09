//
//  GTScreen.h
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/9/9.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 获取屏幕的逻辑尺寸
*/
// 是否为横屏的宏`UIInterfaceOrientationIsLandscape`
#define IS_LANDSCAPE  (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
// 再使用一个宏， 定义一下屏幕的宽度, 先确认一下当前的屏幕是否为横屏
#define SCREEN_WIDTH  (IS_LANDSCAPE ? [[UIScreen mainScreen ] bounds].size.height : [[UIScreen mainScreen ] bounds].size.width)

// 再使用一个宏，定义一下屏幕的高度
#define SCREEN_HEIGHT (IS_LANDSCAPE ? [[UIScreen mainScreen ] bounds].size.width : [[UIScreen mainScreen ] bounds].size.height)

#define UI(x) UIAdapter(x)
#define UIRect(x, y, width, height) UIRectAdapter(x, y, width, height)

// 写一个内联函数作为宏，来按照屏幕尺寸扩大和缩小
static inline NSInteger UIAdapter(float x)
{
    // 1 - 分机型，特定的比例

    // 2 - 屏幕宽度按比例适配
    CGFloat scale = 414 / SCREEN_WIDTH;
    return (NSInteger)x / scale;
}

static inline CGRect UIRectAdapter(x, y, width, height)
{
    return CGRectMake(UIAdapter(x), UIAdapter(y), UIAdapter(width), UIAdapter(height));
}

@interface GTScreen : NSObject

@end

NS_ASSUME_NONNULL_END
