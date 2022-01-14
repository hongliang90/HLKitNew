//
//  ViewController.m
//  APPdemo
//
//  Created by db on 2022/1/12.
//

#import "ViewController.h"
#import "UIButton+HLEdgeInsets.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //btn.layer.cornerRadius = 24.5;
    btn.frame = CGRectMake(20, 200,0,49);
    [btn setTitle:@"点击跳转详情页面" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"ind"] forState:UIControlStateNormal];
   
    btn.imageView.backgroundColor = [UIColor blueColor];
    btn.titleLabel.backgroundColor = [UIColor blackColor];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn layoutButtonEdgeInsetsStyle:ButtonEdgeInsetsStyleRight contentHorizontalSpace:20 contentVerticalSpace:10 imageTitleSpace:30];
    //btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn.layer.cornerRadius = 24.5;
    [btn sizeToFit];
    
    [self.view addSubview:btn];
    
    
}


@end
