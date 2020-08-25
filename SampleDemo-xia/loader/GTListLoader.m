//
//  GTListLoader.m
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/8/25.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTListLoader.h"
#import <AFNetworking.h>

@implementation GTListLoader

- (void)loadListData{
   

    // 使用第三方库封装的网络请求
//    [[AFHTTPSessionManager manager] GET:@"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e" parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"");
//    }];
    
//    __unused NSURLRequest *listRequest = [NSURLRequest requestWithURL:listURL];
    
    // 自己用系统内部的方法封装的网络请求
    NSString *urlString = @"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e";
    NSURL *listURL = [NSURL URLWithString:urlString];

    // 将request封装成task进行操作
    NSURLSession * session = [NSURLSession sharedSession];
    // 封装最基础的dataTask
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *jsonError;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        NSLog(@"");
    }];

    [dataTask resume];

    NSLog(@"");
}

@end
