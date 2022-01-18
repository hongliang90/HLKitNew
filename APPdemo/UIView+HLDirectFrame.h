//
//  UIView+HLDirectFrame.h
//  APPdemo
//
//  Created by db on 2022/1/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HLDirectFrame)

- (CGFloat)HL_x;
- (CGFloat)HL_y;
- (CGFloat)HL_width;
- (CGFloat)HL_height;

- (void)setHL_x:(CGFloat)x;
- (void)setHL_y:(CGFloat)y;
- (void)setHL_width:(CGFloat)width;
- (void)setHL_height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
