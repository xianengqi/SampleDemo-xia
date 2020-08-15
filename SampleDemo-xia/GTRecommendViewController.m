//
//  GTRecommendViewController.m
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/8/16.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTRecommendViewController.h"

@interface GTRecommendViewController ()

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
    // `self.view.bounds.size.width * 5` 表示，有五个屏幕的大小
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 5, self.view.bounds.size.height);
    
    NSArray *colorArray = @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor lightGrayColor], [UIColor grayColor]];
    
    for (int i = 0; i < 5; i++) {
        [scrollView addSubview:({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(scrollView.bounds.size.width * i, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
            view.backgroundColor = [colorArray objectAtIndex:i];
            view;
        })];
    }
    // 通过`pagingEnabled`来设置单页效果
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
}


@end
