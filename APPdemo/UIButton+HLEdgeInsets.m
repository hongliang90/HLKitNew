//
//  UIButton+HLEdgeInsets.m
//  APPdemo
//
//  Created by db on 2022/1/14.
//

#import "UIButton+HLEdgeInsets.h"

@implementation UIButton (HLEdgeInsets)

- (void)layoutButtonEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space {
    [self layoutButtonEdgeInsetsStyle:style contentHorizontalSpace:0 contentVerticalSpace:0 imageTitleSpace:space];
}

- (void)layoutButtonEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style contentHorizontalSpace:(CGFloat)horizonSpace contentVerticalSpace:(CGFloat)verticalSpace imageTitleSpace:(CGFloat)space{
        // 1. 由于iOS8中titleLabelimageView的size为0，用下面的这种设置
        CGFloat imageWith = self.imageView.intrinsicContentSize.width;
        CGFloat imageHeight = self.imageView.intrinsicContentSize.height;
        CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
        CGFloat labelHeight = self.titleLabel.intrinsicContentSize.height;
        
        // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
        UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
        UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
        UIEdgeInsets buttonEdgeInsets = UIEdgeInsetsZero;
        
        
        // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch (style) {
            case  ButtonEdgeInsetsStyleTop:
            {
                imageEdgeInsets = UIEdgeInsetsMake(verticalSpace -labelHeight-space/2.0, 0, 0, -labelWidth);
                labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, verticalSpace -imageHeight-space/2.0, 0);
                buttonEdgeInsets = UIEdgeInsetsMake(verticalSpace, 0, verticalSpace, 0);
                
            }
                break;
            case ButtonEdgeInsetsStyleLeft:
            {
                imageEdgeInsets = UIEdgeInsetsMake(0, horizonSpace -space/2.0, 0, space/2.0);
                labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, horizonSpace -space/2.0);
                buttonEdgeInsets = UIEdgeInsetsMake(0,horizonSpace,0, horizonSpace);
            }
                break;
            case ButtonEdgeInsetsStyleBottom:
            {
                imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
                labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
                buttonEdgeInsets = UIEdgeInsetsMake(verticalSpace, 0, verticalSpace, 0);
            }
                break;
            case ButtonEdgeInsetsStyleRight:
            {
                imageEdgeInsets = UIEdgeInsetsMake(10,labelWidth+space/2.0, 10,  - labelWidth-space/2.0);
                labelEdgeInsets = UIEdgeInsetsMake(0,  -imageWith-space/2.0, 0, imageWith+space/2.0 );
                buttonEdgeInsets = UIEdgeInsetsMake(0,horizonSpace,0, horizonSpace);
            }
                break;
            default:
                break;
        }
  
                
    if (@available(iOS 15.0, *)) {
        NSDirectionalEdgeInsets buttonDirEdgeInsets = NSDirectionalEdgeInsetsZero;
        UIButtonConfiguration *config  = [UIButtonConfiguration plainButtonConfiguration];
        config.imagePlacement = (ButtonEdgeInsetsStyle)style;
        config.imagePadding = space;
        buttonDirEdgeInsets = NSDirectionalEdgeInsetsMake(verticalSpace,horizonSpace,verticalSpace,horizonSpace);
        config.contentInsets = buttonDirEdgeInsets;
        self.configuration = config;
        
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        self.titleEdgeInsets = labelEdgeInsets;
        self.imageEdgeInsets = imageEdgeInsets;
        self.contentEdgeInsets = buttonEdgeInsets;
#pragma clang diagnostic pop
    }
}

@end
