//
//  UIButton+HLEdgeInsets.h
//  APPdemo
//
//  Created by db on 2022/1/14.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ButtonEdgeInsetsStyle) {
    ButtonEdgeInsetsStyleTop  = 1 << 0,//image在上,title在下
    ButtonEdgeInsetsStyleLeft = 1 << 1,//image在左边,title在右边
    ButtonEdgeInsetsStyleBottom = 1 << 2,//image在下,title在上
    ButtonEdgeInsetsStyleRight = 1 << 3,//image在右边,title在左边
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (HLEdgeInsets)
- (void)layoutButtonEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;

- (void)layoutButtonEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style contentHorizontalSpace:(CGFloat)horizonSpace contentVerticalSpace:(CGFloat)verticalSpace imageTitleSpace:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
