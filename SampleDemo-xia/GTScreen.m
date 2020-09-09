//
//  GTScreen.m
//  SampleDemo-xia
//
//  Created by 夏能啟 on 2020/9/9.
//  Copyright © 2020 夏能啟. All rights reserved.
//

#import "GTScreen.h"

@implementation GTScreen

// iphone xs max
+ (CGSize) sizeFor65Inch {
    return CGSizeMake(414, 896);
}

// iphone xr
+ (CGSize) sizeFor61Inch {
    return CGSizeMake(414, 896);
}

// iphone x
+ (CGSize) sizeFor58Inch {
    return CGSizeMake(375, 812);
}

@end
