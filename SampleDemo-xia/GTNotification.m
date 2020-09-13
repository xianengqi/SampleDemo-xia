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

@interface GTNotification ()<UNUserNotificationCenterDelegate>

@end

@implementation GTNotification

// 推送，它是一个单例
+ (GTNotification *)notificationManager {
    static GTNotification *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GTNotification alloc] init];
    });
    return manager;
}

// 提供一个校验权限的方法
- (void)checkNotificationAuthorization {
    
    // delegate
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    // 要验证权限，权限获取的函数
    [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError *_Nullable error) {
        // `completionHandler`用户是否允许推送的回调
        // 请求权限成功之后,在这里触发一次推送
        if (granted) {
            [self _pushLocalNotification];
        }
    }];
}

#pragma mark -
// 本地推送的
- (void)_pushLocalNotification {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.badge = @(1);
    content.title = @"极客时间";
    content.body = @"从零开发一款iOS APP";

    // 时间间隔实现一个本地推送
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10.f repeats:NO];

    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"_pushLocalNotification" content:content trigger:trigger];

    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error) {
        NSLog(@"");
    }];
}

#pragma mark -
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    completionHandler(UNNotificationPresentationOptionAlert);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    
    // 点击交互的时候, 处理业务逻辑
    completionHandler();
}

@end
