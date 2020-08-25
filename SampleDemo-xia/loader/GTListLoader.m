//
//  GTListLoader.m
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/8/25.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTListLoader.h"

@implementation GTListLoader

- (void)loadListData{
   
    NSString *urlString = @"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e";
    NSURL *listURL = [NSURL URLWithString:urlString];
    
    __unused NSURLRequest *listRequest = [NSURLRequest requestWithURL:listURL];
    
    NSLog(@"");
}

@end
