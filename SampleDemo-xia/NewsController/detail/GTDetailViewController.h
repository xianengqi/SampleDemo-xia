//
//  GTDetailViewController.h
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/8/23.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTMediator.h"

NS_ASSUME_NONNULL_BEGIN

/// 文章底层页面
@interface GTDetailViewController : UIViewController<GTDetailViewControllerProtocol>

- (instancetype)initWithUrlString:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
