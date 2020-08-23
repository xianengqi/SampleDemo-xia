//
//  GTNormalTableViewCell.m
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/8/19.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTNormalTableViewCell.h"

// 创建自己的UILabel 进行复杂布局
@interface GTNormalTableViewCell ()

// 1.创建四个最基本的UILabel ，初始化
@property(nonatomic, strong, readwrite) UILabel *titleLabel;
@property(nonatomic, strong, readwrite) UILabel *sourceLabel;
@property(nonatomic, strong, readwrite) UILabel *commentLabel;
@property(nonatomic, strong, readwrite) UILabel *timeLabel;

// 创建自定义的image
@property(nonatomic, strong, readwrite) UIImageView *rightimageView;

// 创建UIButton
@property(nonatomic, strong, readwrite) UIButton *deleteButton;

@end

@implementation GTNormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 2. 把创建好的最基本的UILabel放在这里
        [self.contentView addSubview:({
            // 设置具体的大小
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 300, 50)];
//            self.titleLabel.backgroundColor = [UIColor redColor];
            self.titleLabel.font = [UIFont systemFontOfSize:16];
            self.titleLabel.textColor = [UIColor blackColor];
            self.titleLabel;
        })];
        
        [self.contentView addSubview:({
            // 设置具体的大小
            self.sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 50, 20)];
//            self.sourceLabel.backgroundColor = [UIColor redColor];
            self.sourceLabel.font = [UIFont systemFontOfSize:12];
            self.sourceLabel.textColor = [UIColor grayColor];
            self.sourceLabel;
        })];
        
        [self.contentView addSubview:({
            // 设置具体的大小
            self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 80, 50, 20)];
//            self.commentLabel.backgroundColor = [UIColor redColor];
            self.commentLabel.font = [UIFont systemFontOfSize:12];
            self.commentLabel.textColor = [UIColor grayColor];
            self.commentLabel;
        })];
        
        [self.contentView addSubview:({
            // 设置具体的大小
            self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 80, 50, 20 )];
//            self.timeLabel.backgroundColor = [UIColor redColor];
            self.timeLabel.font = [UIFont systemFontOfSize:12];
            self.timeLabel.textColor = [UIColor grayColor];
            self.timeLabel;
        })];
        
        // 自定义的ImageView
        [self.contentView addSubview:({
            // 设置具体的大小
            self.rightimageView = [[UIImageView alloc] initWithFrame:CGRectMake(330, 15, 70, 70 )];
            self.rightimageView.backgroundColor = [UIColor redColor];
            // `UIViewContentModeScaleAspectFit` 把整个图片按比例展示出来，图片不会变形
            self.rightimageView.contentMode = UIViewContentModeScaleAspectFit;
            self.rightimageView;
        })];
        
        // button
        [self.contentView addSubview:({
            // 设置具体的大小
            self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(290, 80, 30, 20)];
            [self.deleteButton setTitle:@"X" forState:UIControlStateNormal];
            [self.deleteButton setTitle:@"V" forState:UIControlStateHighlighted];
            // 加上点击的交互逻辑 `addTarget: self当前的自身触发`, `action： @selector创建一个方法`,`forControlEvents:UIControlEventTouchUpInside 事件`
            // 当点击的时候，会调用 `deleteButtonClick`这个方法， 实现在deleteButtonClick里面
            [self.deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
            self.deleteButton.backgroundColor = [UIColor blueColor];
            self.deleteButton;
        })];
    }
    return self;
}

// 3.创建一个方法
- (void)layoutTableViewCell{
    self.titleLabel.text = @"极客时间iOS开发";
    
    self.sourceLabel.text = @"极客时间";
    // `sizeToFit`调整一下距离和大小, 返回自适应合适的大小
    [self.sourceLabel sizeToFit];
    
    self.commentLabel.text = @"1888评论";
    // `sizeToFit` 调整一下距离和大小, 返回自适应合适的大小
    [self.commentLabel sizeToFit];
    // 调整一下按钮之间的距离, 左边距设置为sourceLabel的右边距`self.sourceLabel.frame.origin.y` + self.sourceLabel.frame.size.width` 加上自身的宽度 再加上15的距离
    self.commentLabel.frame = CGRectMake(self.sourceLabel.frame.origin.x + self.sourceLabel.frame.size.width + 15, self.commentLabel.frame.origin.y, self.commentLabel.frame.size.width, self.commentLabel.frame.size.height);

    self.timeLabel.text = @"三分钟前";
    // `sizeToFit`调整一下距离和大小, 返回自适应合适的大小
    [self.timeLabel sizeToFit];
    
    self.timeLabel.frame = CGRectMake(self.commentLabel.frame.origin.x + self.commentLabel.frame.size.width + 15, self.timeLabel.frame.origin.y, self.timeLabel.frame.size.width, self.timeLabel.frame.size.height);
    
    // 添加自定义的图片
    self.rightimageView.image = [UIImage imageNamed:@"icon.bundle/splash.png"];
}

// 这是点击时触发的方法, 在上面的action:@selector(deleteButtonClick)定义
- (void) deleteButtonClick {
    // 当点击取消按钮的时候,来判断一下有没有delegate
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewCell:clickDeltetButton:)]) {
        [self.delegate tableViewCell:self clickDeltetButton:self.deleteButton];
    }
    
}

@end
