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

@protocol GTDetailViewControllerProtocol <NSObject>
- (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl;
@end

// 实现一个组件化
@interface GTMediator : NSObject

// target action
+ (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl;

// urlScheme
typedef void(^GTMediatorProcessBlock)(NSDictionary *params);
+ (void)registerScheme:(NSString *)scheme processBlock:(GTMediatorProcessBlock)processBlock;
+ (void)openUrl:(NSString *)url params:(NSDictionary *)params;

//protocol calss
+ (void) registerProtol:(Protocol *)proto class:(Class)cls;
+ (Class) classForProtol:(Protocol *)proto;

@end

NS_ASSUME_NONNULL_END
