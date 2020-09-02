//
//  GTListItem.m
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/8/26.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTListItem.h"

@implementation GTListItem

#pragma mark - NSSecureCoding

// 实现反序列化方法
- (nullable instancetype)initWithCoder:(NSCoder *)coder{
    self = [super init];
    if (self) {
        self.category = [coder decodeObjectForKey:@"category"];
        self.picUrl = [coder decodeObjectForKey:@"thumbnail_pic_s"];
        self.uniquekey = [coder decodeObjectForKey:@"uniquekey"];
        self.title = [coder decodeObjectForKey:@"title"];
        self.date = [coder decodeObjectForKey:@"date"];
        self.authorName = [coder decodeObjectForKey:@"author_name"];
        self.picUrl03 = [coder decodeObjectForKey:@"thumbnail_pic_s03"];
        self.picUrl02 = [coder decodeObjectForKey:@"thumbnail_pic_s02"];
        self.articleUrl = [coder decodeObjectForKey:@"url"];
    }
    return self;
}
// 实现序列化方法
- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.category forKey:@"category"];
    [coder encodeObject:self.picUrl forKey:@"thumbnail_pic_s"];
    [coder encodeObject:self.uniquekey forKey:@"uniquekey"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.date forKey:@"date"];
    [coder encodeObject:self.authorName forKey:@"authorName"];
    [coder encodeObject:self.picUrl03 forKey:@"thumbnail_pic_s03"];
    [coder encodeObject:self.picUrl02 forKey:@"thumbnail_pic_s02"];
    [coder encodeObject:self.articleUrl forKey:@"url"];
}

+ (BOOL)supportsSecureCoding{
    return YES;
}

#pragma mark - public method

- (void)configWithDictionary:(NSDictionary *)dictionary {
    // 解析对应到每个属性当中
    // 需要进行判断，是否有object类型
#warning 类型是否匹配
    self.category = [dictionary objectForKey:@"category"];
    self.picUrl = [dictionary objectForKey:@"thumbnail_pic_s"];
    self.uniquekey = [dictionary objectForKey:@"uniquekey"];
    self.title = [dictionary objectForKey:@"title"];
    self.date = [dictionary objectForKey:@"date"];
    self.authorName = [dictionary objectForKey:@"author_name"];
    self.picUrl03 = [dictionary objectForKey:@"thumbnail_pic_s03"];
    self.picUrl02 = [dictionary objectForKey:@"thumbnail_pic_s02"];
    self.articleUrl = [dictionary objectForKey:@"url"];
}

@end
