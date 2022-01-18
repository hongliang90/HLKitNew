//
//  UIView+HLDirectFrame.m
//  APPdemo
//
//  Created by db on 2022/1/18.
//

#import "UIView+HLDirectFrame.h"

@implementation UIView (HLDirectFrame)

- (CGFloat)HL_x{
    return self.frame.origin.x;
}


- (CGFloat)HL_y{
    return self.frame.origin.y;
}


- (CGFloat)HL_width{
    return  self.frame.size.width;
}


- (CGFloat)HL_height{
    return  self.frame.size.height;
}


- (void)setHL_x:(CGFloat)x{
    self.frame = CGRectMake(x, self.HL_y, self.HL_width, self.HL_height);
}


- (void)setHL_y:(CGFloat)y{
    self.frame = CGRectMake(self.HL_x,y, self.HL_width, self.HL_height);
}



- (void)setHL_width:(CGFloat)width{
    self.frame = CGRectMake(self.HL_x, self.HL_y, width, self.HL_height);
}


- (void)setHL_height:(CGFloat)height{
    self.frame = CGRectMake(self.HL_x, self.HL_y, self.HL_width, height);
}


@end
