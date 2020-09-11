//
//  GTDetailViewController.m
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/8/23.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTDetailViewController.h"
// 引入webkit
#import <WebKit/WebKit.h>
#import "GTScreen.h"
#import "GTMediator.h"

@interface GTDetailViewController () <WKNavigationDelegate>
@property (nonatomic, strong, readwrite) WKWebView *webView;
// 加一个进度的展示条
@property (nonatomic, strong, readwrite) UIProgressView *progressView;
// 生成一个变量，保持构值的url
@property (nonatomic, copy, readwrite) NSString *articleUrl;

@end

@implementation GTDetailViewController

- (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl{
    return [[[self class] alloc] initWithUrlString:detailUrl];
}


+ (void) load{
//    [GTMediator registerScheme:@"detail://" processBlock:^(NSDictionary * _Nonnull params) {
//        NSString *url = (NSString *)[params objectForKey:@"url"];
//        UINavigationController *navigationController = (UINavigationController *)[params objectForKey:@"controller"];
//
//        GTDetailViewController *controller = [[GTDetailViewController alloc] initWithUrlString:url];
////        controller.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
//        [navigationController pushViewController:controller animated:YES];
//    }];
    
    [GTMediator registerProtol:@protocol(GTDetailViewControllerProtocol) class:[self class]];
}

// 在监听者销毁的时候，移除
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

// 在生成的时候传入它需要展示的url
- (instancetype)initWithUrlString:(NSString *)urlString {
    self = [super init];
    if (self) {
        self.articleUrl = urlString;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:({
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, STATUSBARHEIGHT + 44, self.view.frame.size.width, self.view.frame.size.height - STATUSBARHEIGHT - 44)];
        self.webView.navigationDelegate = self;
        self.webView;
    })];

    // 展示进度条样式
    [self.view addSubview:({
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, STATUSBARHEIGHT + 44, self.view.frame.size.width, 20)];
        self.progressView;
    })];

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.articleUrl]]];
    // 注册监听, 展示页面加载进度
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 当系统走到`didFinishNavigation`，告诉我们整个页面已经加载完了
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"");
}

// 监听后，需要回调
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    self.progressView.progress = self.webView.estimatedProgress;
    NSLog(@" ");
}

@end
