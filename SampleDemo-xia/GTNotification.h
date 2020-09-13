//
//  GTNotification.h
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/9/13.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 APP 推送管理
 */
@interface GTNotification : NSObject

// 推送，它是一个单例
+ (GTNotification *)notificationManager;

// 提供一个校验权限的方法
- (void)checkNotificationAuthorization;

@end

NS_ASSUME_NONNULL_END
