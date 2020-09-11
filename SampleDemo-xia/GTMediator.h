//
//  GTMediator.h
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/9/11.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 实现一个组件化
@interface GTMediator : NSObject

+ (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl;

@end

NS_ASSUME_NONNULL_END
