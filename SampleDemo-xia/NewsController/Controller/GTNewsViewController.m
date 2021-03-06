//
//  GTNewsViewController.m
//  SampleDemo
//
//  Created by 夏能啟 on 2020/8/4.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTNewsViewController.h"
#import "GTNormalTableViewCell.h"
//#import "GTDetailViewController.h"
#import "GTDeleteCellView.h"
#import "GTListLoader.h"
#import "GTListItem.h"
#import "GTMediator.h"

@interface GTNewsViewController () <UITableViewDataSource, UITableViewDelegate, GTNormalTableViewCellDelegate>
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) NSArray *dataArray; // NSArray是不可变的数组
@property (nonatomic, strong, readwrite) GTListLoader *listLoader;
@end

@implementation GTNewsViewController

#pragma mark - lefe cycle

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    // 初始化loading..
    self.listLoader = [[GTListLoader alloc] init];
    // 处理一下循环引用
    __weak typeof (self) wself = self;

    [self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<GTListItem *> * _Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        // 1.副值给dataArray
        strongSelf.dataArray = dataArray;
        // 2. 刷新当前的列表
        [strongSelf.tableView reloadData];
    }];

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

#pragma mark - UITableViewDelegate

// 实现一个高度cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

// 点击cell触发的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   GTListItem *item = [self.dataArray objectAtIndex:indexPath.row];
    // `GTDetailViewController` 自定义webkit
    
//    __kindof UIViewController *detailController = [GTMediator detailViewControllerWithUrl:item.articleUrl];
//    detailController.view.backgroundColor = [UIColor whiteColor];
//    detailController.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
//    [self.navigationController pushViewController:detailController animated:YES];
//    [GTMediator openUrl:@"detail://" params:@{@"url":item.articleUrl, @"controller":self.navigationController}];
    
    Class cls = [GTMediator classForProtol:@protocol(GTDetailViewControllerProtocol)];
    
    [self.navigationController pushViewController:[[cls alloc] detailViewControllerWithUrl:item.articleUrl] animated:YES];
    
   
    // 处理一下已读的状态
    // 当点击的时候
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:item.uniquekey];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // `dequeueReusableCellWithIdentifier`是系统的回收池，用来取cell
    GTNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[GTNormalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        // 设置cell的delegate,实现点击删除按钮的触发事件
        cell.delegate = self;
    }
    
    // 在每次TableView需要布局的时候，我们去调用一下。
    [cell layoutTableViewCellWithItem:[self.dataArray objectAtIndex:indexPath.row]];

    return cell;
}

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeltetButton:(UIButton *)deleteButton {
//    GTDeleteCellView *deleteView = [[GTDeleteCellView alloc] initWithFrame:self.view.bounds];
//
//    // 需要转换cell的坐标系到window中
//    CGRect rect = [tableViewCell convertRect:deleteButton.frame toView:nil];
//
//    // 处理一下循环引用
//    __weak typeof (self) wself = self;
//
//    [deleteView showDeleteViewFromPoint:rect.origin clickBolck:^{
//        __strong typeof (wself) strongSelf = wself;
//        [strongSelf.tableView deleteRowsAtIndexPaths:@[[strongSelf.tableView indexPathForCell:tableViewCell]] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }];
}

@end
