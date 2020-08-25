//
//  GTListItem.m
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/8/26.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTListItem.h"

@implementation GTListItem

- (void)configWithDictionary:(NSDictionary *)dictionary {
    // 解析对应到每个属性当中
    // 需要进行判断，是否有object类型
#warning 类型是否匹配
    self.category = [dictionary objectForKey:@"category"];
    self.picUrl = [dictionary objectForKey:@"thumbnail_pic_s"];
    self.uniquekey = [dictionary objectForKey:@"uniquekey"];
    self.title = [dictionary objectForKey:@"title"];
    self.data = [dictionary objectForKey:@"date"];
    self.authorName = [dictionary objectForKey:@"author_name"];
    self.picUrl03 = [dictionary objectForKey:@"thumbnail_pic_s03"];
    self.picUrl02 = [dictionary objectForKey:@"thumbnail_pic_s02"];
    self.articleUrl = [dictionary objectForKey:@"url"];
}

@end
