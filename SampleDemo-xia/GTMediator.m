//
//  GTMediator.m
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/9/11.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTMediator.h"
//#import "GTDetailViewController.h"

@implementation GTMediator

+ (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl{
    
    // 反射到这个类，使完全抽离出来,解耦
    Class detailCls = NSClassFromString(@"GTDetailViewController");
     
    // 反射
    UIViewController *controller = [[detailCls alloc] performSelector:NSSelectorFromString(@"initWithUrlString:") withObject:detailUrl];
    return controller;
}

#pragma mark -

+ (NSMutableDictionary *)mediatorCache{
    static NSMutableDictionary *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = @{}.mutableCopy;
    });
    return cache;
}

+ (void)registerScheme:(NSString *)scheme processBlock:(GTMediatorProcessBlock)processBlock{
    if (scheme && processBlock) {
        [[[self class] mediatorCache] setObject:processBlock forKey:scheme];
    }
}

+ (void)openUrl:(NSString *)url params:(NSDictionary *)params{
    GTMediatorProcessBlock block = [[[self class] mediatorCache] objectForKey:url];
    if (block) {
        block(params);
    }
}

#pragma mark -

+ (void) registerProtol:(Protocol *)proto class:(Class)cls{
    if (proto && cls) {
        [[[self class] mediatorCache] setObject:cls forKey:NSStringFromProtocol(proto)];
    }
}

+ (Class) classForProtol:(Protocol *)proto{
    return [[[self class] mediatorCache] objectForKey:NSStringFromProtocol(proto)];
}

@end
