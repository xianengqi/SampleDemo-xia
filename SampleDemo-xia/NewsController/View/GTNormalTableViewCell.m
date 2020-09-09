//
//  GTNormalTableViewCell.m
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/8/19.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTNormalTableViewCell.h"
#import "GTListItem.h"
#import "SDWebImage.h"
#import "GTScreen.h"

// 创建自己的UILabel 进行复杂布局
@interface GTNormalTableViewCell ()

// 1.创建四个最基本的UILabel ，初始化
@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *sourceLabel;
@property (nonatomic, strong, readwrite) UILabel *commentLabel;
@property (nonatomic, strong, readwrite) UILabel *timeLabel;

// 创建自定义的image
@property (nonatomic, strong, readwrite) UIImageView *rightimageView;

// 创建UIButton
@property (nonatomic, strong, readwrite) UIButton *deleteButton;

@end

@implementation GTNormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 2. 把创建好的最基本的UILabel放在这里
        [self.contentView addSubview:({
            // 设置具体的大小
            self.titleLabel = [[UILabel alloc] initWithFrame:UIRect(20, 15, 270, 50)];
            self.titleLabel.font = [UIFont systemFontOfSize:16];
            self.titleLabel.textColor = [UIColor blackColor];
            // 让标题支持两行
            self.titleLabel.numberOfLines = 2;
            // 标题末尾显示..
            self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            self.titleLabel;
        })];

        [self.contentView addSubview:({
            // 设置具体的大小
            self.sourceLabel = [[UILabel alloc] initWithFrame:UIRect(20, 70, 50, 20)];
            self.sourceLabel.font = [UIFont systemFontOfSize:12];
            self.sourceLabel.textColor = [UIColor grayColor];
            self.sourceLabel;
        })];

        [self.contentView addSubview:({
            // 设置具体的大小
            self.commentLabel = [[UILabel alloc] initWithFrame:UIRect(100, 70, 50, 20)];
            self.commentLabel.font = [UIFont systemFontOfSize:12];
            self.commentLabel.textColor = [UIColor grayColor];
            self.commentLabel;
        })];

        [self.contentView addSubview:({
            // 设置具体的大小
            self.timeLabel = [[UILabel alloc] initWithFrame:UIRect(150, 70, 50, 20)];
            self.timeLabel.font = [UIFont systemFontOfSize:12];
            self.timeLabel.textColor = [UIColor grayColor];
            self.timeLabel;
        })];

        // 自定义的ImageView
        [self.contentView addSubview:({
            // 设置具体的大小
            self.rightimageView = [[UIImageView alloc] initWithFrame:UIRect(300, 15, 100, 70)];
            // `UIViewContentModeScaleAspectFit` 把整个图片按比例展示出来，图片不会变形
            self.rightimageView.contentMode = UIViewContentModeScaleAspectFit;
            self.rightimageView;
        })];

        // button
//        [self.contentView addSubview:({
//            // 设置具体的大小
//            self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(290, 80, 30, 20)];
//            [self.deleteButton setTitle:@"X" forState:UIControlStateNormal];
//            [self.deleteButton setTitle:@"V" forState:UIControlStateHighlighted];
//            // 加上点击的交互逻辑 `addTarget: self当前的自身触发`, `action： @selector创建一个方法`,`forControlEvents:UIControlEventTouchUpInside 事件`
//            // 当点击的时候，会调用 `deleteButtonClick`这个方法， 实现在deleteButtonClick里面
//            [self.deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
////            self.deleteButton.backgroundColor = [UIColor blueColor];
//            // 设置button的样式为圆角`self.deleteButton.layer.cornerRadius`
//            self.deleteButton.layer.cornerRadius = 10;
//            self.deleteButton.layer.masksToBounds = YES;
//            // 给按钮加上一个边框
//            self.deleteButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//            self.deleteButton.layer.borderWidth = 2;
//            self.deleteButton;
//        })];
    }
    return self;
}

// 3.创建一个方法
- (void)layoutTableViewCellWithItem:(GTListItem *)item {
    
    BOOL hasRead = [[NSUserDefaults standardUserDefaults] boolForKey:item.uniquekey];

    if (hasRead) {
        self.titleLabel.textColor = [UIColor lightGrayColor];
    } else {
        self.titleLabel.textColor = [UIColor blackColor];

    }
    
    self.titleLabel.text = item.title;

    self.sourceLabel.text = item.authorName;
    // `sizeToFit`调整一下距离和大小, 返回自适应合适的大小
    [self.sourceLabel sizeToFit];

    self.commentLabel.text = item.category;
    // `sizeToFit` 调整一下距离和大小, 返回自适应合适的大小
    [self.commentLabel sizeToFit];
    // 调整一下按钮之间的距离, 左边距设置为sourceLabel的右边距`self.sourceLabel.frame.origin.y` + self.sourceLabel.frame.size.width` 加上自身的宽度 再加上15的距离
    self.commentLabel.frame = CGRectMake(self.sourceLabel.frame.origin.x + self.sourceLabel.frame.size.width + UI(15), self.commentLabel.frame.origin.y, self.commentLabel.frame.size.width, self.commentLabel.frame.size.height);

    self.timeLabel.text = item.date;
    // `sizeToFit`调整一下距离和大小, 返回自适应合适的大小
    [self.timeLabel sizeToFit];

    self.timeLabel.frame = CGRectMake(self.commentLabel.frame.origin.x + self.commentLabel.frame.size.width + UI(15), self.timeLabel.frame.origin.y, self.timeLabel.frame.size.width, self.timeLabel.frame.size.height);

    // 2. 改成多线程提高流畅度, 这是创建的一个自定义的线程
//    NSThread *downloadImageThread = [[NSThread alloc] initWithBlock:^{
//        // 1.加载图片,耗时较高，有明显的卡顿现象，将高耗时的代码放在了NSthread里面了，就可以解决高耗时的问题.
//      //  UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.picUrl]]];
////        self.rightimageView.image = image;
//    }];
//    // 3. 设置一个名字
//    downloadImageThread.name = @"downloadImageThread";
//    // 4.执行这个线程
//    [downloadImageThread start];
    
    
    /// 使用GCD从新实现一下上面的业务逻辑
    // 1. 取系统提供的非主线程,系统提供的默认优先级`DISPATCH_QUEUE_PRIORITY_DEFAULT`
    // 非主队列
//    dispatch_queue_global_t downloadQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    // 2. 获取主队列
//    dispatch_queue_main_t mainQueue = dispatch_get_main_queue();
//    // 3, 获取到队列后，执行业务逻辑
//    dispatch_async(downloadQueue, ^{
//        // 在非主队列当中执行高耗时的操作
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.picUrl]]];
//        // 在主队列当中执行UI操作
//        dispatch_async(mainQueue, ^{
//            self.rightimageView.image = image;
//        });
//    });
//
    /**
        使用第三方开源的库，来进行图片的存储到内存或磁盘中
     第一步会先去内存中存储，如果内存中没有就会去磁盘中存储
     优化GCD, 占位图
     */
    // 1. 首先加载url
    [self.rightimageView sd_setImageWithURL:[NSURL URLWithString:item.picUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"");
    }];
 
    
    // 添加自定义的图片
//    self.rightimageView.image = [UIImage imageNamed:@"icon.bundle/splash.png"];
}

// 这是点击时触发的方法, 在上面的action:@selector(deleteButtonClick)定义
- (void)deleteButtonClick {
    // 当点击取消按钮的时候,来判断一下有没有delegate

    if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewCell:clickDeltetButton:)]) {
        [self.delegate tableViewCell:self clickDeltetButton:self.deleteButton];
    }
}

@end
