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

// 判断三种机型
#define IS_IPHONE_X_XR_MAX (IS_IPHONE_X || IS_IPHONE_XR || IS_IPHONE_XMAX)
// 定义是否是iphone x
#define IS_IPHONE_X (SCREEN_WIDTH == [GTScreen sizeFor58Inch].width && SCREEN_HEIGHT == [GTScreen sizeFor58Inch].height)
// 判断一下iphone xr的像素密度
#define IS_IPHONE_XR (SCREEN_WIDTH == [GTScreen sizeFor61Inch].width && SCREEN_HEIGHT == [GTScreen sizeFor61Inch].height && [UIScreen mainScreen].scale == 2)
// 判断一下iphone xmax的像素密度
#define IS_IPHONE_XMAX (SCREEN_WIDTH == [GTScreen sizeFor65Inch].width && SCREEN_HEIGHT == [GTScreen sizeFor65Inch].height && [UIScreen mainScreen].scale == 3)

// 定义一个statusbar的height, 如果是流海屏，就返回44
#define STATUSBARHEIGHT (IS_IPHONE_X_XR_MAX ? 44 : 20 )


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

// iphone xs max
+ (CGSize) sizeFor65Inch;
// iphone xr
+ (CGSize) sizeFor61Inch;
// iphone x
+ (CGSize) sizeFor58Inch;

@end

NS_ASSUME_NONNULL_END
