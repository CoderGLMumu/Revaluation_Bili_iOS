//
//  ViewController.m
//  pack_ijkplayer
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "IJKMoviePlayerViewController.h"
#import "IJKHistoryItem.h"

#import "GLVideoPlayView.h"
#import "GLonlineVideoPlayView.h"

#import "Masonry/Masonry.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "ZFBrightnessView.h"

@interface IJKMoviePlayerViewController ()

/** 需要播放的是否在网络视频/本地视频 */
@property (nonatomic, assign) BOOL isLiveVideo;
/** 是否是弹出全屏播放 */
@property (nonatomic, assign) BOOL isFullScreen;
/** 是否是直播视频 */
@property (nonatomic, assign) BOOL isOnlineVideo;

/** 包装player的旋转view */
@property (nonatomic, weak) UIView *rotationView;

@end

@implementation IJKMoviePlayerViewController

#define UIScreen16_9 CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.width * 9 / 16)

- (void)dealloc
{
    NSLog(@"IJKMoviePlayerViewController- -播放器销毁了");
}


#pragma mark - 初始化-返回播放器控制器
+ (instancetype)InitVideoViewFromViewController:(UIViewController *)viewController withTitle:(NSString *)title URL:(NSURL *)url isLiveVideo:(BOOL)isLiveVideo isOnlineVideo:(BOOL)isOnlineVideo isFullScreen:(BOOL)isFullScreen completion:(void (^)())completion {
    IJKHistoryItem *historyItem = [[IJKHistoryItem alloc] init];
    
    historyItem.title = title;
    historyItem.url = url;
    historyItem.isLiveVideo = isLiveVideo;
    historyItem.isFullScreen = isFullScreen;
    historyItem.isOnlineVideo = isOnlineVideo;
    [[IJKHistory instance] add:historyItem];
    
    /** 创建播放器控制器 */
    IJKMoviePlayerViewController *PlayerVC = [[IJKMoviePlayerViewController alloc] initWithURL:url isLiveVideo:isLiveVideo isOnlineVideo:isOnlineVideo isFullScreen:isFullScreen];
    
    /** 对播放器控制器进行操作 */
    
    return PlayerVC;
}

#pragma mark - 初始化-弹出播放器控制器
+ (instancetype)presentFromViewController:(UIViewController *)viewController withTitle:(NSString *)title URL:(NSURL *)url isLiveVideo:(BOOL)isLiveVideo isOnlineVideo:(BOOL)isOnlineVideo isFullScreen:(BOOL)isFullScreen completion:(void (^)())completion {
    IJKHistoryItem *historyItem = [[IJKHistoryItem alloc] init];
    
    historyItem.title = title;
    historyItem.url = url;
    historyItem.isLiveVideo = isLiveVideo;
    historyItem.isFullScreen = isFullScreen;
    historyItem.isOnlineVideo = isOnlineVideo;
    [[IJKHistory instance] add:historyItem];
    
    /** 创建播放器控制器 */
    IJKMoviePlayerViewController *PlayerVC = [[IJKMoviePlayerViewController alloc] initWithURL:url isLiveVideo:isLiveVideo isOnlineVideo:isOnlineVideo isFullScreen:isFullScreen];

    /** 对播放器控制器进行操作 */
    [viewController presentViewController:PlayerVC animated:isFullScreen completion:completion];

    return PlayerVC;
}

- (instancetype)initWithURL:(NSURL *)url isLiveVideo:(BOOL)isLiveVideo isOnlineVideo:(BOOL)isOnlineVideo isFullScreen:(BOOL)isFullScreen {
    self = [self initWithNibName:@"IJKMoviePlayerViewController" bundle:nil];
    if (self) {
        self.url = url;
        self.isLiveVideo = isLiveVideo;
        self.isFullScreen = isFullScreen;
        self.isOnlineVideo = isOnlineVideo;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isLiveVideo) {
        //直播视频
//        self.url = [NSURL URLWithString:@"http://163.177.171.33/live-play.acgvideo.com/live/331/live_9617619_6384511.flv?3235&wshc_tag=0&wsts_tag=573bdfb0&wsid_tag=1b2f832a&wsiphost=ipdbm"];
        IJKFFOptions *options = [IJKFFOptions optionsByDefault];
        self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:options];
    }else{
        //网络视频
//        self.url = [NSURL URLWithString:@"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
        self.player = [[IJKAVMoviePlayerController alloc] initWithContentURL:self.url];
    }
    
//    self.playView.autoresizingMask = UIViewAutoresizingNone;
//    self.player.view.autoresizingMask = UIViewAutoresizingNone;
    
//    [self.player setScalingMode:IJKMPMovieScalingModeAspectFill];
    
    /** 用于包装player.view 旋转的视图 */
    UIView *rotationView = [[UIView alloc]init];
    
    [self.view addSubview:rotationView];
    [self.view sendSubviewToBack:rotationView];
    self.rotationView = rotationView;
    
    [self.rotationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.equalTo(self.view);
    }];
    
    [rotationView addSubview:self.player.view];
    
    UITapGestureRecognizer *sliderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSliderAction:)];
    [self.playView.mediaProgressSlider addGestureRecognizer:sliderTap];
    [self.playViewFullScreen.mediaProgressSlider addGestureRecognizer:sliderTap];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (![self.player isPlaying]) {
        
        [self installMovieNotificationObservers];
        
        [self.player prepareToPlay];
        
        [self.playView hide];
        [self.playViewFullScreen hide];
    }
    
    /** 是直播视频,-需要加载GLOnlineVideoPV */
    if (self.isOnlineVideo) {
         self.onlinePlayView.delegatePlayer = self.player;
    }else{
         self.playView.delegatePlayer = self.player;
         self.playViewFullScreen.delegatePlayer = self.player;
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    /** 不是全屏的话,视频按照16:9的比例显示 */
    if (self.isFullScreen) {
        
    }else{
        self.view.frame = UIScreen16_9;
    }
    
    /** 设置子控件约束 */
    if (self.isOnlineVideo) {
        [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.left.equalTo(self.view);
        }];
        self.onlinePlayView.overlayPanel.frame = self.view.frame;
    }else{
        [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.left.equalTo(self.view);
        }];
        self.playView.overlayPanel.frame = self.view.frame;
        self.playViewFullScreen.overlayPanel.frame = self.view.frame;
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.player shutdown];
    [self removeMovieNotificationObservers];
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    /** 全屏的话,直接强制全屏 */
    if (self.isFullScreen) {
//        NSLog(@"isll");
        return UIInterfaceOrientationMaskLandscape;
        
    }else{
//        NSLog(@"isnn");
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (BOOL)shouldAutorotate{ return NO; }

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    /** 全屏的话,直接强制全屏 */
    if (self.isFullScreen) {
//        NSLog(@"isll");
        return UIInterfaceOrientationLandscapeLeft;
        
    }else{
//        NSLog(@"isnn");
        return UIInterfaceOrientationPortrait;
        
    }
}

#pragma mark 点击滑块
/**
 *  UISlider TapAction 点击滑块
 */
- (void)tapSliderAction:(UITapGestureRecognizer *)tap
{
    // 可以封装在view里
    if ([tap.view isKindOfClass:[UISlider class]]) {
        UISlider *slider = (UISlider *)tap.view;
        CGPoint point = [tap locationInView:slider];
        CGFloat length = slider.frame.size.width;
        // 视频跳转的value
        CGFloat tapValue = point.x / length;
        
        // 视频总时间长度
        CGFloat total = self.player.duration;
        //计算出拖动的当前秒数
        NSInteger dragedSeconds = floorf(total * tapValue);
        self.player.currentPlaybackTime = dragedSeconds;
        
        // 只要点击进度条就跳转播放
        [self.player play];
    }
}

#pragma mark IBAction- -播放器视图控制相关【工具条/工具条显示隐藏】
- (IBAction)onClickOverlay:(id)sender
{
    if (self.isOnlineVideo) {
        if (self.onlinePlayView.isHideTool) {
            [self.onlinePlayView showAndFade];
            self.onlinePlayView.isHideTool = NO;
        }else{
            [self.onlinePlayView hide];
            self.onlinePlayView.isHideTool = YES;
        }
    }else{
        if (self.playView.isHideTool) {
            [self.playView showAndFade];
            [self.playViewFullScreen showAndFade];
            self.playView.isHideTool = NO;
        }else{
            [self.playView hide];
            [self.playViewFullScreen hide];
            self.playView.isHideTool = YES;
        }
    }
    
}

/** 返回直播界面present页面 */
- (IBAction)presentBack:(UIButton *)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
/** 视频播放后的pop控制器返回 */
- (IBAction)popBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 强制屏幕旋转
- (IBAction)fullScreenAndScale:(UIButton *)btn {
    
    if (btn.selected) {
        self.isFullScreen = NO;
        btn.selected = NO;
        
        /** 16 : 9 */
        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
            SEL selector             = NSSelectorFromString(@"setOrientation:");
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
            [invocation setSelector:selector];
            [invocation setTarget:[UIDevice currentDevice]];
            int val                  = UIInterfaceOrientationPortrait;
            // 从2开始是因为0 1 两个参数已经被selector和target占用
            [invocation setArgument:&val atIndex:2];
            [invocation invoke];
            //项目必须支持 UIInterfaceOrientationPortrait
        }
    }else{
        self.isFullScreen = YES;
        btn.selected = YES;
        
         /** 全屏 */
        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
            SEL selector             = NSSelectorFromString(@"setOrientation:");
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
            [invocation setSelector:selector];
            [invocation setTarget:[UIDevice currentDevice]];
            int val                  = UIInterfaceOrientationLandscapeRight;
            // 从2开始是因为0 1 两个参数已经被selector和target占用
            [invocation setArgument:&val atIndex:2];
            [invocation invoke];
            //项目必须支持 UIInterfaceOrientationLandscapeRight
        }
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [self toolsShowOrHidden];
    
    if (size.width > size.height) {
        [self.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(@0);
            make.width.equalTo(@(size.width));
            make.height.equalTo(@(size.height));
        }];
//        self.player.playbackRate = 2;
    }else {
        [self.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(@0);
            make.width.equalTo(@(size.width));
            make.height.equalTo(@(size.width *(9.0 / 16.0)));
        }];
//        self.player.playbackRate = 0.4;
    }
}

/** 占位视图 功能视图 */
- (IBAction)popBackBtn:(UIButton *)btnClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)GoBack
{
     [self dismissViewControllerAnimated:YES completion:nil];
}

/** 视频播放时功能视图 */
//- (IBAction)onClickPlay:(id)sender
//{
//    [self.player play];
//    if (self.isOnlineVideo) {
//        
//    }else{
//        [self.playView refreshMediaControl];
//        [self.playViewFullScreen refreshMediaControl];
//    }
//}
//
//- (IBAction)onClickPause:(id)sender
//{
//    [self.player pause];
//    [self.playView refreshMediaControl];
//    [self.playViewFullScreen refreshMediaControl];
//}

- (IBAction)didSliderTouchDown
{
    [self.playView beginDragMediaSlider];
    [self.playViewFullScreen beginDragMediaSlider];
}

- (IBAction)didSliderTouchCancel
{
    [self.playView endDragMediaSlider];
    [self.playViewFullScreen endDragMediaSlider];
}

- (IBAction)didSliderTouchUpOutside
{
    [self.playView endDragMediaSlider];
    [self.playViewFullScreen endDragMediaSlider];
}

- (IBAction)didSliderTouchUpInside
{
    self.player.currentPlaybackTime = self.playView.mediaProgressSlider.value;
    self.player.currentPlaybackTime = self.playViewFullScreen.mediaProgressSlider.value;
    [self.playView endDragMediaSlider];
    [self.playViewFullScreen endDragMediaSlider];
}

- (IBAction)didSliderValueChanged
{
    [self.playView continueDragMediaSlider];
    [self.playViewFullScreen continueDragMediaSlider];
}

#pragma mark - OnlineVideoPlayView工具条事件处理
- (IBAction)onClickPlayOrPause:(UIButton *)sender {
    if (!sender.isSelected) {
        sender.selected = YES;
        [self.player play];
    }else{
        sender.selected = NO;
        [self.player pause];
    }
}
- (IBAction)onClickLock:(UIButton *)sender {
    NSLog(@"self.onlinePlayView 处理视频lock");
}
- (IBAction)onClickVolume:(UIButton *)sender {
    NSLog(@"self.onlinePlayView 处理视频volume");
}
- (IBAction)onClickAddDanMu:(UIButton *)sender {
    NSLog(@"self.onlinePlayView 处理视频AddDanMu");
}
- (IBAction)onClickshowDanMu:(UIButton *)sender {
    NSLog(@"self.onlinePlayView 处理视频showDanMu");
}
- (IBAction)onClicksetting:(UIButton *)sender {
    NSLog(@"self.onlinePlayView 处理视频setting");
}
- (IBAction)onClickshare:(UIButton *)sender {
    NSLog(@"self.onlinePlayView 处理视频share");
}
- (IBAction)onClickVideoScale:(UIButton *)sender {
    NSLog(@"self.onlinePlayView 处理视频VideoScale");
}
- (IBAction)onClickVideoQuality:(UIButton *)sender {
    NSLog(@"self.onlinePlayView 处理视频VideoQuality");
}
- (IBAction)onClickBGPlay:(UIButton *)sender {
    NSLog(@"self.onlinePlayView 处理视频BGPlay");
}

#pragma Selector func- -代理监听相关

- (void)loadStateDidChange:(NSNotification*)notification {
//    IJKMPMovieLoadState loadState = _player.loadState;
//    
//    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
//        NSLog(@"LoadStateDidChange: IJKMovieLoadStatePlayThroughOK: %d\n",(int)loadState);
//    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
//        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
//    } else {
//        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
//    }
}

- (void)moviePlayBackFinish:(NSNotification*)notification {
    NSLog(@"moviePlayBackFinish");
//    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
//    switch (reason) {
//        case IJKMPMovieFinishReasonPlaybackEnded:
//            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
//            break;
//            
//        case IJKMPMovieFinishReasonUserExited:
//            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
//            break;
//            
//        case IJKMPMovieFinishReasonPlaybackError:
//            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
//            break;
//            
//        default:
//            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
//            break;
//    }
}

#pragma mark - 视频准备好播放了
- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    NSLog(@"mediaIsPreparedToPlayDidChange");
    
    if (self.isOnlineVideo) {
        [self.rotationView addSubview:self.onlinePlayView];
        [self.onlinePlayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.left.equalTo(self.view);
        }];
    }else{
        /** 网络视频 全屏播放时的控制tool 添加*/
        [self.rotationView addSubview:self.playViewFullScreen];
        [self.playViewFullScreen mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.left.equalTo(self.view);
        }];
        [self.playViewFullScreen setupSubviewsConstraint];
        /** 网络视频 16:9播放时的控制tool 添加*/
        [self.rotationView addSubview:self.playView];
        [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.left.equalTo(self.view);
        }];
        [self.playView setupSubviewsConstraint];
    }
    
    [self toolsShowOrHidden];
    
    [self.view bringSubviewToFront:self.rotationView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.isOnlineVideo) {
            [self.onlinePlayView showAndFade];
        }else{
            [self.playView showAndFade];
        }
    });
    
//    [self onClickPlay:nil];
    
    [self onClickPlayOrPause:nil];
    
    RAC(self.playView.playOrPause,selected) = RACObserve(self.player, isPlaying);
    RAC(self.playView.smallPlayOrPause,selected) = RACObserve(self.playView.playOrPause,selected);
    RAC(self.playViewFullScreen.playOrPause,selected) = RACObserve(self.player, isPlaying);
    RAC(self.playView.fullSreenBtn,selected) = RACObserve(self, isFullScreen);
    RAC(self.playViewFullScreen.fullSreenBtn,selected) = RACObserve(self, isFullScreen);
    
    // 亮度view加到window最上层
    ZFBrightnessView *brightnessView = [ZFBrightnessView sharedBrightnessView];
    [self.view addSubview:brightnessView];
}

- (void)toolsShowOrHidden
{
    if(self.isFullScreen){
        self.playViewFullScreen.hidden = NO;
        self.playView.hidden = YES;
    }else{
        self.playViewFullScreen.hidden = YES;
        self.playView.hidden = NO;
    }
}


- (void)moviePlayBackStateDidChange:(NSNotification*)notification {
    NSLog(@"moviePlayBackStateDidChange");
//    switch (_player.playbackState) {
//        case IJKMPMoviePlaybackStateStopped:
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
//            break;
//            
//        case IJKMPMoviePlaybackStatePlaying:
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
//            break;
//            
//        case IJKMPMoviePlaybackStatePaused:
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
//            break;
//            
//        case IJKMPMoviePlaybackStateInterrupted:
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
//            break;
//            
//        case IJKMPMoviePlaybackStateSeekingForward:
//        case IJKMPMoviePlaybackStateSeekingBackward: {
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
//            break;
//        }
//            
//        default: {
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
//            break;
//        }
//    }
}

#pragma Install Notifiacation- -播放器依赖的相关监听
- (void)installMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
    
}

#pragma mark Remove Movie Notification Handlers- -销毁播放器前必须销毁的通知监听

/* Remove the movie notification observers from the movie object. */
- (void)removeMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_player];
    
}

@end
