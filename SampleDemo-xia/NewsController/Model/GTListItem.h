//
//  GTListItem.h
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/8/26.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 列表结构化数据
@interface GTListItem : NSObject

@property(nonatomic, copy, readwrite) NSString *category;
@property(nonatomic, copy, readwrite) NSString *picUrl;
@property(nonatomic, copy, readwrite) NSString *uniquekey;
@property(nonatomic, copy, readwrite) NSString *title;
@property(nonatomic, copy, readwrite) NSString *data;
@property(nonatomic, copy, readwrite) NSString *authorName;
@property(nonatomic, copy, readwrite) NSString *picUrl03;
@property(nonatomic, copy, readwrite) NSString *picUrl02;
@property(nonatomic, copy, readwrite) NSString *articleUrl;

// 需要将list数组转换成list item，所以添加一个构造函数
- (void)configWithDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
