//
//  GTNormalTableViewCell.h
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/8/19.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GTListItem;

// 自己实现一个delegate

/// 点击删除按钮
@protocol GTNormalTableViewCellDelegate <NSObject>
// 1. 当点击按钮的时候去触发这个Delegate
- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeltetButton:(UIButton *)deleteButton;

@end

/// 新闻列表cell
@interface GTNormalTableViewCell : UITableViewCell

// 2. 设置属性

@property (nonatomic, weak, readwrite) id<GTNormalTableViewCellDelegate> delegate;

// 暴露这个方法
- (void)layoutTableViewCellWithItem:(GTListItem *)item;

@end

NS_ASSUME_NONNULL_END
