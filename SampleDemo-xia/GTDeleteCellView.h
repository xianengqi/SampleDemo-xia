//
//  GTDeleteCellView.h
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/8/24.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTDeleteCellView : UIView
// 需要暴露出来，共外面的调用
- (void) showDeleteViewFromPoint:(CGPoint)point clickBolck:(dispatch_block_t) clickBlock;

@end

NS_ASSUME_NONNULL_END
