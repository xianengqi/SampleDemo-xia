//
//  GTDeleteCellView.m
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/8/24.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTDeleteCellView.h"

// 创建两个子view

@interface GTDeleteCellView ()

// 背景颜色
@property(nonatomic, strong, readwrite) UIView *backgroundView;
@property(nonatomic, strong, readwrite) UIButton *deleteButton;
@property(nonatomic, copy, readwrite) dispatch_block_t deleteBlock;

@end

@implementation GTDeleteCellView

// 初始化的时候，去响应这两个button
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            // `_`下横线表示：简单的来说，两种方式都是访问属性。区别就是使用self. 其实是使用了属性的getter/setter方法，而使用_ 则是直接访问。
           // 当我们需要在赋值和获取属性的时候做一些hook处理，我们可以将相应的逻辑写在getter/setter方法之中，这个时候需要使用self.来触发。同时block中为了防止循环引用也建议显式的写成self. 当然两者效率上的差别我认为可以忽略不计，在日常使用遵循项目的规范和个人习惯就好。
            _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
            _backgroundView.backgroundColor = [UIColor blackColor];
            _backgroundView.alpha = 0.5;
            // 增加一个点击的手势
            [_backgroundView addGestureRecognizer:({
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDeleteView)];
                tapGesture;
            })];
            _backgroundView;
        })];
        
        // 创建一个删除的按钮
        [self addSubview:({
            _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            // 点击这个按钮有一些相应的操作
            [_deleteButton addTarget:self action:@selector(_clickButton) forControlEvents:UIControlEventTouchUpInside];
            _deleteButton.backgroundColor = [UIColor blueColor];
            _deleteButton;
        })];
    }
    return self;
}

// 什么时候展示
- (void) showDeleteViewFromPoint:(CGPoint)point clickBolck:(dispatch_block_t) clickBlock {
    _deleteButton.frame = CGRectMake(point.x, point.y, 0, 0);
    _deleteBlock = [clickBlock copy];
    // 放在window上，作为全局引用的
    [[UIApplication sharedApplication].windows.lastObject addSubview:self];
    // 展示view的时候，去做一个展示的动画
    // `animateWithDuration: 1.f` 表示1秒的动画
    // `animations`动画的位置
    // `animateWithDuration`动画的时间,`delay`延迟,`usingSpringWithDamping和initialSpringVelocity`阻尼的系数
    // `options:UIViewAnimationOptionCurveEaseInOut`前后慢，中间快。
    
//     `animations:^{  表示整个的初始位置到最终位置
//        self.deleteButton.frame = CGRectMake((self.bounds.size.width - 200)/2 , (self.bounds.size.height - 200)/2, 200, 200);
//      }`
    [UIView animateWithDuration:1.f delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.deleteButton.frame = CGRectMake((self.bounds.size.width - 200)/2 , (self.bounds.size.height - 200)/2, 200, 200);
    } completion:^(BOOL finished) {
        NSLog(@"");
    }];
}

// 什么时候隐藏
- (void) dismissDeleteView{
    // 在delete的时候，移除掉.
    [self removeFromSuperview];
}

// 实现一下点击事件
- (void) _clickButton{
    // 执行block
    if (_deleteBlock) {
        _deleteBlock();
    }
    // 在点击的时候，也需要移除掉整个的view
     [self removeFromSuperview];
}

@end
