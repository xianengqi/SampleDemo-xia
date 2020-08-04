//
//  ViewController.m
//  SampleDemo
//
//  Created by 夏能啟 on 2020/8/4.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "ViewController.h"

@interface TestView : UIView
@end

@implementation TestView

- (instancetype) init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)willMoveToSuperview:(nullable UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
}
- (void)didMoveToSuperview{
    [super didMoveToSuperview];
}
- (void)willMoveToWindow:(nullable UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
}
- (void)didMoveToWindow{
    [super didMoveToWindow];
}

@end


@interface ViewController ()

@end

@implementation ViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
};
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
};
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
};
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
};

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame: self.view.bounds];
    
    [self.view addSubview:tableView];
    
//    TestView *view = [[TestView alloc] init];
//    view.backgroundColor = [UIColor redColor];
//    view.frame = CGRectMake(100, 100, 100, 100);
//    [self.view addSubview: view];
//
//
//
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(pushController)];
//
//    [view addGestureRecognizer: tapGesture];
    
}

- (void)pushController{
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.navigationItem.title = @"内容";
    
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"右侧标题" style:UIBarButtonItemStylePlain target:self action:nil];
    

    [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]];
    [self.navigationController pushViewController: viewController animated:YES];
}

@end
