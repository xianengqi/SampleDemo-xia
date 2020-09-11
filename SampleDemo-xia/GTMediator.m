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

@end
