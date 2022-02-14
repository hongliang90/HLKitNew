//
//  BaseViewController.m
//  APPdemo
//
//  Created by db on 2022/1/20.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    //对于异步任务,直接返回,又因为是串行队列,所以先把子类的方法viewDidLoad执行完再执行这里面的方法.
    dispatch_async(dispatch_get_main_queue(), ^{
        [self test];
    });
    // Do any additional setup after loading the view.
}

- (void)test{
    NSLog(@"%s",__func__);
}


@end
