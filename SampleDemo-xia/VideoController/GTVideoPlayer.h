//
//  GTVideoPlayer.h
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/9/7.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTVideoPlayer : NSObject

// 单例模式
+ (GTVideoPlayer *)Player;

- (void)playVideoWithUrl:(NSString *)videoUrl attachView:(UIView *) attachView;


@end

NS_ASSUME_NONNULL_END
