//
//  GTVideoViewController.m
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/8/14.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTVideoViewController.h"
// 替换系统提供的UIControllerView
#import "GTVideoCoverView.h"


@interface GTVideoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation GTVideoViewController

- (instancetype) init {
    self = [super init];
    // 这是从SceneDelegate.m文件抽离到这的,通过点击tabBar来显示UI视图
    if (self) {
        self.tabBarItem.title = @"视频";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/video@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/video_selected@2x.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 0. 注册一个layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置一个最基础的瀑布流样式
    // `minimumLineSpacing和minimumInteritemSpacing`是两个元素间隙的大小
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    // 整个屏幕的宽度减去中间预留的10
//    flowLayout.itemSize = CGSizeMake((self.view.frame.size.width - 10)/2, 300);
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width / 16 * 9);
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    // 2. 需要设置delegate和dataSource
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    // 1. 初始化的时候需要注册重用的
    [collectionView registerClass:[GTVideoCoverView class] forCellWithReuseIdentifier:@"GTVideoCoverView"];
    
    [self.view addSubview:collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    // 需要展示多少条
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    // 从系统的自动回收池去取
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GTVideoCoverView" forIndexPath:indexPath];
    // 判读一下，是否是GTVideoCoverView,如果是，就展示相关的逻辑
    if ([cell isKindOfClass:[GTVideoCoverView class]]) {
        // http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4
        [((GTVideoCoverView* )cell) layoutWithVideoCoverUrl:@"icon.bundle/splash.png" videoUrl:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    }
    return cell;
}

// 自定义设置流式布局
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    // `% 3`表示 以3为整数的
//    if (indexPath.item % 3 == 0) {
//        return CGSizeMake(self.view.frame.size.width, 100);
//    } else {
//        return CGSizeMake((self.view.frame.size.width - 10)/2, 300);
//    }
//}

@end
