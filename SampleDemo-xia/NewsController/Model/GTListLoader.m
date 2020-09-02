//
//  GTListLoader.m
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/8/25.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTListLoader.h"
#import <AFNetworking.h>
#import "GTListItem.h"

@implementation GTListLoader

- (void)loadListDataWithFinishBlock:(GTListLoaderFinishBlock)finishBlock {
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
//     NSString *urlString = @"https://static001.geekbang.org/univer/classes/ios_dev/lession/45/toutiao.json";
    NSURL *listURL = [NSURL URLWithString:urlString];

    // 将request封装成task进行操作
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 为了能循环引用self
    __weak typeof(self) weakSelf = self;
    
    // 封装最基础的dataTask
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listURL completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        // 循环引用self
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        NSError *jsonError;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

#warning 类型的检查 暂时没做类型的检查
        // 1.先把数据拿出来，用于给下面的解析
        NSArray *dataArray = [((NSDictionary *)[((NSDictionary *)jsonObj) objectForKey:@"result"]) objectForKey:@"data"];
        // 3.通过数据对应付值item属性
        // `mutableCopy`是创建了一个新的对象。
        NSMutableArray *listItemArray = @[].mutableCopy;
        // 2.解析GTListItem.m的相应逻辑
        for (NSDictionary *info in dataArray) {
            // 遍历这个数组
            //请求，解析，回调
            GTListItem *listItem = [[GTListItem alloc] init];
            [listItem configWithDictionary:info];
            // 将生成的结构化数据加到`listItemArray`这个空数组当中
            [listItemArray addObject:listItem];
        }

        // 将网络请求回来的数据存储一下
        [weakSelf _archiveListDataWithArray:listItemArray.copy];

        // 将整个的回调放在主现成当中
        dispatch_async(dispatch_get_main_queue(), ^{
                           // 调用这个block
                           if (finishBlock) {
                               // 如果error == nil ，那就是成功
                               finishBlock(error == nil, listItemArray.copy);
                           }
                       });
    }];

    [dataTask resume];
}

// 获取ios沙盒地址
// 建立一个获取沙盒地址的函数
- (void)_archiveListDataWithArray:(NSArray<GTListItem *> *)array {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    // 地址是文件的第一位
    NSString *cachePath = [pathArray firstObject];

    // 创建一个Filemanager(文件管理)
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 创建一个文件夹, 先生成一个地址
    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"GTData"];

    NSError *createError;
    // 建立这个文件
    [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&createError];

    // 创建文件的地址
    NSString *listDataPath = [dataPath stringByAppendingPathComponent:@"list"];
    // 如果想往文件中存入一些数据,把数据转换成二进制流,使用`NSUTF8StringEncoding`UTF-8编码，转换成了一个二进制流
//    NSData *listData = [@"abc" dataUsingEncoding:NSUTF8StringEncoding];
    
    // 序列化操作
    NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];

    // 建立这个文件
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];
    
    // 读取文件实现反序列化 ,将二进制文件从listDataPath读取出来
    NSData *readListData = [fileManager contentsAtPath:listDataPath];
    
    // 实现二进制文件反序列化
    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [GTListItem class], nil] fromData:readListData error:nil];

    // 查询文件
//    BOOL fileExist = [fileManager fileExistsAtPath:listDataPath];

    // 删除文件
//    if (fileExist) {
//        [fileManager removeItemAtPath:listDataPath error:nil];
//    }

    NSLog(@"");

//    // 向`listData`中增加数据, 需要用到FileHandle
//    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:listDataPath];
//
//    // 在文件末尾追加数据
//    [fileHandle seekToEndOfFile];
//    [fileHandle writeData:[@"def" dataUsingEncoding:NSUTF8StringEncoding]];
//    // 刷新一下这个文件
//    [fileHandle synchronizeFile];
//    // 关闭文件的操作
//    [fileHandle closeFile];
}

@end
