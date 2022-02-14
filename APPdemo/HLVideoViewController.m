//
//  HLVideoViewController.m
//  APPdemo
//
//  Created by db on 2022/2/14.
//
//fitOnScreen  竖屏全屏 横屏旋转 rotation

#import "HLVideoViewController.h"
#import <SJVideoPlayer/SJVideoPlayer.h>
#import <Masonry.h>
#import <SJBaseVideoPlayer/SJPlaybackRecordSaveHandler.h>
#import "SJPlaybackRecord+SJTestExtended.h"
#import <SJBaseVideoPlayer/SJBarrageItem.h>
#import <SJBaseVideoPlayer/SJWatermarkView.h>


@interface HLVideoViewController ()
@property (nonatomic, strong, readonly) SJVideoPlayer *player;
@property (nonatomic, assign) BOOL shouldRotateFlag;
@property (nonatomic, strong) UIButton *switchButton;
@property (nonatomic, strong) UIButton *barragePausedButton;
@property (nonatomic, strong) UIButton *barrageContuesButton;
@property (nonatomic, strong) UIButton *huzhonghuaButton;
@property (nonatomic, strong) UIButton *huzhonghuaExitButton;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) NSArray *urlArray;
@end

@implementation HLVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"视频播放器";
    
    _player = SJVideoPlayer.player;
    [self.view addSubview:_player.view];
    [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
            if(@available(ios 11.0, *)){
                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            }else{
                make.top.mas_offset(20);
            }
            make.left.right.offset(0);
            make.height.equalTo(self.player.view.mas_width).multipliedBy(9/16.0);
    }];
    
    self.switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.switchButton setTitle:@"旋转" forState:UIControlStateNormal];
    [self.view addSubview:self.switchButton];
    [self.switchButton setBackgroundColor:[UIColor grayColor]];
    [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.player.view.mas_bottom).offset(20);
            make.width.mas_equalTo(40);
            make.leading.mas_offset(40);
    }];
    [_switchButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.barragePausedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.barragePausedButton setTitle:@"暂停弹幕" forState:UIControlStateNormal];
    [self.view addSubview:self.barragePausedButton];
    [self.barragePausedButton setBackgroundColor:[UIColor grayColor]];
    [self.barragePausedButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.player.view.mas_bottom).offset(20);
            make.width.mas_equalTo(80);
        make.leading.mas_equalTo(self.switchButton.mas_trailing).mas_offset(20);
    }];
    [self.barragePausedButton addTarget:self action:@selector(pauseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.barrageContuesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.barrageContuesButton setTitle:@"开始弹幕" forState:UIControlStateNormal];
    [self.view addSubview:self.barrageContuesButton];
    [self.barrageContuesButton setBackgroundColor:[UIColor grayColor]];
    [self.barrageContuesButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.player.view.mas_bottom).offset(20);
            make.width.mas_equalTo(80);
        make.leading.mas_equalTo(self.barragePausedButton.mas_trailing).mas_offset(20);
    }];
    [self.barrageContuesButton addTarget:self action:@selector(contuesButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.huzhonghuaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.huzhonghuaButton setTitle:@"开启画中画" forState:UIControlStateNormal];
    [self.view addSubview:self.huzhonghuaButton];
    [self.huzhonghuaButton setBackgroundColor:[UIColor grayColor]];
    [self.huzhonghuaButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.switchButton.mas_bottom).offset(20);
            make.width.mas_equalTo(120);
        make.leading.mas_equalTo(self.view).mas_offset(20);
    }];
    [self.huzhonghuaButton addTarget:self action:@selector(huzhonghuaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.huzhonghuaExitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.huzhonghuaExitButton setTitle:@"结束画中画" forState:UIControlStateNormal];
    [self.view addSubview:self.huzhonghuaExitButton];
    [self.huzhonghuaExitButton setBackgroundColor:[UIColor grayColor]];
    [self.huzhonghuaExitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.self.switchButton.mas_bottom).offset(20);
            make.width.mas_equalTo(120);
        make.leading.mas_equalTo(self.huzhonghuaButton.mas_trailing).mas_offset(20);
    }];
    [self.huzhonghuaExitButton addTarget:self action:@selector(huzhonghuaExictButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
self.urlArray = @[@"https://upos-sz-mirrorcos.bilivideo.com/upgcxcode/95/07/506460795/506460795-1-16.mp4?e=ig8euxZM2rNcNbRVhwdVhwdlhWdVhwdVhoNvNC8BqJIzNbfq9rVEuxTEnE8L5F6VnEsSTx0vkX8fqJeYTj_lta53NCM=&uipk=5&nbs=1&deadline=1644839782&gen=playurlv2&os=cosbv&oi=3030164437&trid=2649c7880bbe4d19bf741bb5359ca27eh&platform=html5&upsig=bcd50c7422194f66bba3cd5759e61955&uparams=e,uipk,nbs,deadline,gen,os,oi,trid,platform&mid=0&bvc=vod&nettype=0&bw=53325&logo=80000000",@"https://upos-sz-mirrorhw.bilivideo.com/upgcxcode/95/41/493624195/493624195_nb2-1-16.mp4?e=ig8euxZM2rNcNbRVhwdVhwdlhWdVhwdVhoNvNC8BqJIzNbfq9rVEuxTEnE8L5F6VnEsSTx0vkX8fqJeYTj_lta53NCM=&uipk=5&nbs=1&deadline=1644824535&gen=playurlv2&os=hwbv&oi=3030164437&trid=f1ef95509bf347ee94dd75a16db76213h&platform=html5&upsig=a80d7135e500f8178b244a91b4a9c563&uparams=e,uipk,nbs,deadline,gen,os,oi,trid,platform&mid=0&bvc=vod&nettype=0&bw=35281&logo=80000000"];
    
    SJVideoPlayerURLAsset *asset = [[SJVideoPlayerURLAsset alloc]initWithURL:[NSURL URLWithString:self.urlArray[0]] startPosition:0 ];
    _player.URLAsset = asset;
   // _player.rotationManager.disabledAutorotation = YES;
    //typeof()的作用是获取他的类型,获取self 的类型
    //__weak typeof(self) weakSelf = self;
    /*__weak HLVideoViewController* weakself = self;
    _player.shouldTriggerRotation = ^BOOL(__kindof SJBaseVideoPlayer * _Nonnull player) {
        //__strong typeof(self) strongSelf = weakSelf;
        __strong  HLVideoViewController* strongSelf = weakself;
        if (!strongSelf) {
            return NO;
        }
        //其他情况
        return strongSelf.shouldRotateFlag;
    };*/
    
    _player.rotationObserver.rotationDidStartExeBlock = ^(id<SJRotationManager>  _Nonnull mgr) {
        if (mgr.isFullscreen) {
            NSLog(@"将要旋转到横屏");
        }else{
            NSLog(@"将要旋转到竖屏");
        }
    };
    
    _player.rotationObserver.rotationDidEndExeBlock = ^(id<SJRotationManager>  _Nonnull mgr) {
        NSLog(@"已经旋转完成了");
        if (mgr.isFullscreen) {
            NSLog(@"旋转到横屏");
        }
    };
    
    
    /*
    _player.fitOnScreen = YES;
    
    //下面是竖屏全屏
 
    //竖直全屏大小切换
//    [_player setFitOnScreen:YES animated:YES completionHandler:^(__kindof SJBaseVideoPlayer * _Nonnull player) {
//
//    }];
   __block BOOL onScreenFlag = YES;
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10 repeats:YES block:^(NSTimer * _Nonnull timer) {
        //恢复小屏
        [weakSelf.player setFitOnScreen:onScreenFlag animated:onScreenFlag];
        onScreenFlag =!onScreenFlag;
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    _player.fitOnScreenObserver.fitOnScreenWillBeginExeBlock = ^(id<SJFitOnScreenManager>  _Nonnull mgr) {
        if (mgr.isFitOnScreen) {
            NSLog(@"将要全屏");
        }else{
            NSLog(@"将要小屏幕");
        }
    };
    
    _player.rotationObserver.rotationDidEndExeBlock = ^(id<SJRotationManager>  _Nonnull mgr) {
        NSLog(@"竖直全屏完成");
    };*/
    
    
    //关闭自动选择
    //如果仅使用旋转功能, 可如下设置:
    _player.automaticallyPerformRotationOrFitOnScreen = NO;
    
    
    //该方法将会关闭自动选择, 仅使用竖屏相关功能.
    _player.onlyUsedFitOnScreen = YES;
    
    //竖屏全屏后, 如何允许旋转:
    _player.allowsRotationInFitOnScreen = YES;
    
    
    
//保存播放记录
    //配置保存播放记录的时机 为方便操作, 大家只需设置需要保存播放记录的时机即可, 下面的这个管理类会在发生指定的事件时, 去保存播放记录.
    SJPlaybackRecordSaveHandler *handler = SJPlaybackRecordSaveHandler.shared;
    handler.events = SJPlayerEventMaskAll;
    /*
     先创建SJPlaybackRecord模型
     NSInteger mediaId = currentVideo.id;
     NSInteger userId = SJUser.shared.id;
     // 查询
     SJPlaybackRecord *record = [SJPlaybackHistoryController.shared recordForMedia:mediaId user:userId];
     if ( record == nil ) {
         // 如不存在则创建一条记录
         record = SJPlaybackRecord.alloc.init;
         record.mediaId = mediaId;
         record.userId = userId;
     
     // 第二步
     // 为扩充的属性进行赋值
             record.title = currentVideo.title;
     }
     */
    
    /*
     获取的record对象关联到asset中 当关联到当前的播放资源上时, 在发生某个事件后, 管理类就会通过asset.record获取到该条记录, 进行保存的操作. 因此这一步是非常关键的一步.
     
     
     SJVideoPlayerURLAsset *asset = [SJVideoPlayerURLAsset.alloc initWithURL:currentVideo.URL startPosition:record.position];
         // - 为将要播放的 asset 关联一个 record, 后续管理类将会在合适的时机将其保存到`SJPlaybackHistoryController`中
         asset.record = record;
         // - 进行播放
         self.player.URLAsset = asset;
     */
    
    //长按快进
    _player.gestureControl.supportedGestureTypes |= SJPlayerGestureTypeMask_LongPress;
    // 这里设置了2.0倍
    _player.rateWhenLongPressGestureTriggered = 2.0;
    
    
    //弹幕相关
    NSString *contentStr = @"Hello World！";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[contentStr stringByAppendingString:@"\n\n"]];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, 6)];
      [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, 12)];
    SJBarrageItem *item = [SJBarrageItem.alloc initWithContent:attrStr];
    [self.player.barrageQueueController enqueue:item];
    
    
    //画中画
    /*
     1.ios 14才开始有画中画功能
     2.需要配置BackgroundModel
     */
    _player.defaultEdgeControlLayer.automaticallyShowsPictureInPictureItem = YES;
    
    
    
    UIImage *watermark = [UIImage imageNamed:@"2"];
    SJWatermarkView *watermarkView = [SJWatermarkView.alloc initWithImage:watermark];
    _player.watermarkView = watermarkView;
    
    // 修改为右下角
        watermarkView.layoutPosition = SJWatermarkLayoutPositionBottomRight;
        // 修改后更新布局
        [self.player updateWatermarkViewLayout];
    // 修改高度
       watermarkView.layoutHeight = 30;
       // 修改后更新布局
       [self.player updateWatermarkViewLayout];
    
}




- (BOOL)shouldAutorotate {
    return  NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_player vc_viewDidAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_player vc_viewWillDisappear];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_player vc_viewDidAppear];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.shouldRotateFlag = !self.shouldRotateFlag;
    
}

- (void)buttonClick:(UIButton*)button{
    [_player rotate:SJOrientation_LandscapeLeft animated:YES completion:^(__kindof SJBaseVideoPlayer * _Nonnull player) {

    }];
}

//pauseButtonClick
- (void)pauseButtonClick:(UIButton*)button{
    // 可通过`isPaused`来判断当前状态
    [self.player.barrageQueueController pause];
}

//contuesButtonClick
- (void)contuesButtonClick:(UIButton*)button{
    // 可通过`isPaused`来判断当前状态
    [self.player.barrageQueueController resume];
}

//huzhonghuaButtonClick


- (void)huzhonghuaButtonClick:(UIButton*)button{
    [_player.playbackController startPictureInPicture];
}

//
- (void)huzhonghuaExictButtonClick:(UIButton*)button{
    [_player.playbackController stopPictureInPicture];
}

@end
