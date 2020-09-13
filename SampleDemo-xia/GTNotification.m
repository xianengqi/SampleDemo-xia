//
//  GTNotification.m
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/9/13.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTNotification.h"
// 引入头文件 系统统一的所有的推送服务
#import <UserNotifications/UserNotifications.h>

@interface GTNotification ()

@end

@implementation GTNotification


// 推送，它是一个单例
+ (GTNotification *)notificationManager{
    static GTNotification *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GTNotification alloc] init];
    });
    return manager;
}

// 提供一个校验权限的方法
- (void)checkNotificationAuthorization{
    // 要验证权限，权限获取的函数
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
        // `completionHandler`用户是否允许推送的回调
        NSLog(@"");
    }];
}
 
@end
