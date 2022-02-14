//
//  ViewController.m
//  APPdemo
//
//  Created by db on 2022/1/12.
//

#import "ViewController.h"
#import "UIButton+HLEdgeInsets.h"
#import <Masonry.h>
#import "UIView+HLDirectFrame.h"
#import <CoreLocation/CoreLocation.h>
#import <SJVideoPlayer/SJVideoPlayer.h>

#define kDefaultTopViewHeight 44.0

@protocol testDelegate <NSObject>

@property (nonatomic, copy) NSString *testName;

@end

@interface ViewController ()<CLLocationManagerDelegate,testDelegate>
@property (nonatomic, strong) UIView *navBar;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) CLLocationManager *loctaionManager;
@property (nonatomic, strong) CLGeocoder *geoC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (CLLocationManager *)loctaionManager {
    if (!_loctaionManager) {
        _loctaionManager = [CLLocationManager new];
        _loctaionManager.delegate = self;
        _loctaionManager.desiredAccuracy  = kCLLocationAccuracyBest;
        [_loctaionManager requestAlwaysAuthorization];
    }
    return  _loctaionManager;
}

- (CLGeocoder *)geoC {
    if (!_geoC) {
        _geoC = [CLGeocoder new];
    }
    return  _geoC;
}

- (IBAction)getLocation:(id)sender {
    
    [self.loctaionManager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if(locations.count == 0) return;
    [self.geoC reverseGeocodeLocation:locations.lastObject completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if(error != nil) return;
            CLPlacemark *placeM = [placemarks firstObject];
            NSString *placeName = placeM.name;
            NSString *latitude = @(placeM.location.coordinate.latitude).stringValue;
            NSString *longitude = @(placeM.location.coordinate.longitude).stringValue;
            NSLog(@"当前位置是在:%@------经度:%@------纬度:%@",placeName,longitude,latitude);
    }];
    
}














//子类方法调父类可以用supper,如果想在父类里面调子类呢?如何操作
- (void)test{
    NSLog(@"%s",__func__);
}



-(void)studySafeArea {
    
    //安全区域 https://blog.csdn.net/sz_vcp2007/article/details/86669773
    // iOS 11 safeArea详解 & iphoneX 适配
    // Masonry适配SafeArea  https://www.jianshu.com/p/1432a94ef66f
    // 安全区:指的是不被导航栏和底部tabBar影响的部分,如果竖屏变横屏,那么刘海屏对顶部就没有影响,所以这个值是根据
    //屏幕,根据横竖屏变化的,这个值也是变化的,最后调整的结果可以通过safeAreaLayoutGuide 和 safeAreaInsets来表现,
    //如果我们想让显示的内容都在安全区内我们可以通过masonry 的这些mas_safeAreaLayoutGuideTop属性来调整,
    //如果想通过frame可以通过safeAreaInsets来获取当前安全区域相对于整个屏幕来讲的内边距,可以通过这个属性来进行一些其他设置.
    UIView *redeView = [[UIView alloc]initWithFrame:self.view.safeAreaLayoutGuide.layoutFrame];
    redeView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redeView];
    [redeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.mas_equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.right.mas_equalTo(self.view.mas_safeAreaLayoutGuideRight);
    }];
    
    self.navigationController.navigationBar.hidden = YES;
    _navBar = [UIView new];
    _navBar.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_navBar];
    [_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_offset(0);
    }];

    UILabel *label = [UILabel new];
    _label = label;
    label.tintColor = [UIColor greenColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.text = @"自定义导航栏";
    [_navBar addSubview:label];
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    
    NSLog(@"self.view guide:%@",self.view.safeAreaLayoutGuide);
    /*if (@available(ios 11.0,*)) {
        
    }*/
    
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UIEdgeInsets safeAreaInsets = hl_safeAreaInset(self.view);
    CGFloat height = kDefaultTopViewHeight; // 导航栏原本的高度，通常是44.0
    height += safeAreaInsets.top > 0 ? safeAreaInsets.top : 20.0; // 20.0是statusbar的高度，这里假设statusbar不消失
    if (_navBar && _navBar.HL_height != height) {
        _navBar.HL_height = height;
        [_label sizeToFit];
        CGFloat label_X = (_navBar.HL_width - _label.HL_width)*0.5;
        CGFloat addtionY = safeAreaInsets.top > 0 ? safeAreaInsets.top : 20.0;
        CGFloat label_Y = (kDefaultTopViewHeight - _label.HL_height)*0.5 + addtionY;
        _label.frame = CGRectMake(label_X, label_Y,_label.HL_width , _label.HL_height);
        
    }
    
    }


static inline UIEdgeInsets hl_safeAreaInset(UIView *view) {
    if (@available(iOS 11.0, *)) {
        return view.safeAreaInsets;
    }
    return UIEdgeInsetsZero;
}









//自定义按钮
- (void)buttonClick {
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







//被static 修饰的局部变量存在常量区,只有一份内存,所以只要操作就是操作同一个对象.
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self add:10];
}

- (void)add:(int)b {
    static int a = 0;
    a = a+b;
   // NSLog(@"a = %d",a);
}


@synthesize testName;

@end
