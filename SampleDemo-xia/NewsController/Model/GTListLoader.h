//
//  GTListLoader.h
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/8/25.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GTListItem;
NS_ASSUME_NONNULL_BEGIN

// 定义一个block
typedef void(^GTListLoaderFinishBlock)(BOOL success, NSArray<GTListItem *> *dataArray);

/// 列表请求的loading...
@interface GTListLoader : NSObject

- (void)loadListDataWithFinishBlock:(GTListLoaderFinishBlock)finishBlock;

@end

NS_ASSUME_NONNULL_END
