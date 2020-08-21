//
//  GTRecommendViewController.m
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/8/16.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTRecommendViewController.h"

// 需要在这里声明一下使用的delaget
@interface GTRecommendViewController ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>

@end


@implementation GTRecommendViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"推荐";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/like@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/like_selected@2x.png"];
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    // 设置scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever。在开发过程中的frame布局的项目中，所有的scrollView也都建议设置这个属性。
    scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    // `self.view.bounds.size.width * 5` 表示，有五个屏幕的大小
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 5, self.view.bounds.size.height);
    
    // 这是拖拽要设置的
    scrollView.delegate = self;
    
    NSArray *colorArray = @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor lightGrayColor], [UIColor grayColor]];
    
    for (int i = 0; i < 5; i++) {
        [scrollView addSubview:({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(scrollView.bounds.size.width * i, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
            // 增加一个小view视图
            [view addSubview:({
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
                view.backgroundColor = [UIColor yellowColor];
                // 实现自定义手势
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick)];
                tapGesture.delegate = self;
                // 把tapGesture加到view当中，就能识别到手势了
                [view addGestureRecognizer:tapGesture];
                view;
            })];
            
            view.backgroundColor = [colorArray objectAtIndex:i];
            view;
        })];
    }
    // 通过`pagingEnabled`来设置单页效果
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
}
// `scrollViewDidScroll`监听页面滚动,以及根据Offset做业务逻辑
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 打log,和javaScript里一样，可以打log，在javascript里使用console.log,在Object-c这里是用NSLog
  //  NSLog(@"scrollViewDidScroll - %@", @(scrollView.contentOffset.x)); // 获取当前标志scrollView在哪,获得水平方向的contentOffset
}

// 纵横的先暂时不使用
// - (void)scrollViewDidZoom:(UIScrollView *)scrollView API_AVAILABLE(ios(3.2)); // any zoom scale changes

// 拖拽的函数, 开始拖拽，中断一些业务逻辑，如视频/gif播放
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"BeginDragging");
}

// 纵横的先暂时不使用
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset API_AVAILABLE(ios(5.0)){
//
//}

// 拖拽的函数 结束拖拽， 开始拖拽，中断一些业务逻辑，如视频/gif播放
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"EndDragging");
}

// 拖拽的减速开始 ，页面停止时开始逻辑，如视频自动播放
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
}

// 拖拽的减速结束，页面停止时开始逻辑，如视频自动播放
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
}


// 实现自定义手势
- (void) viewClick{
    NSLog(@"viewClick");
}

// 实现自定义手势是否被识别，
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

@end

//总结：
//UIScrollView
//1. 是 UICollectionView 和 UITableView 的父类
//2. frame 决定视图在屏幕中展示的大小
//3. contentSize 视图内部内容可以滚动的区域
//4. contentOffset 滚动区域左上角与视图左上角的距离
//5. pagingEnabled 可以实现翻页效果
