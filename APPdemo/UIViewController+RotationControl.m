//
//  UIViewController+RotationControl.m
//  APPdemo
//
//  Created by db on 2022/2/14.
//

#import "UIViewController+RotationControl.h"

@implementation UIViewController (RotationControl)
- (BOOL) shouldAutorotate {
    return  NO;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}



@end
