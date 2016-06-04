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
#import "Masonry/Masonry.h"
#import "ZFBrightnessView.h"

@interface IJKMoviePlayerViewController ()

/** isLiveVideo */
@property (nonatomic, assign) BOOL isLiveVideo;
/** isFullScreen */
@property (nonatomic, assign) BOOL isFullScreen;

/** isHideTool */
@property (nonatomic, assign) BOOL isHideTool;

/** 占位旋转view */
@property (nonatomic, weak) UIView *rotationView;



@end

@implementation IJKMoviePlayerViewController

#define UIScreen16_9 CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.width * 9 / 16)

- (void)dealloc
{
    NSLog(@"IJKMoviePlayerViewController- -播放器销毁了");
    
}

+ (void)presentFromViewController:(UIViewController *)viewController withTitle:(NSString *)title URL:(NSURL *)url isLiveVideo:(BOOL)isLiveVideo isFullScreen:(BOOL)isFullScreen completion:(void (^)())completion {
    IJKHistoryItem *historyItem = [[IJKHistoryItem alloc] init];
    
    historyItem.title = title;
    historyItem.url = url;
    historyItem.isLiveVideo = isLiveVideo;
    historyItem.isFullScreen = isFullScreen;
    [[IJKHistory instance] add:historyItem];
    
    [viewController presentViewController:[[IJKMoviePlayerViewController alloc] initWithURL:url isLiveVideo:isLiveVideo isFullScreen:isFullScreen] animated:isLiveVideo completion:completion];
}

- (instancetype)initWithURL:(NSURL *)url isLiveVideo:(BOOL)isLiveVideo isFullScreen:(BOOL)isFullScreen {
    self = [self initWithNibName:@"IJKMoviePlayerViewController" bundle:nil];
    if (self) {
        self.url = url;
        self.isLiveVideo = isLiveVideo;
        self.isFullScreen = isFullScreen;
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
    
    UIView *rotationView = [[UIView alloc]init];
   
    [self.view addSubview:rotationView];
    self.rotationView = rotationView;
    
    [self.rotationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.equalTo(self.view);
    }];
    
    [rotationView addSubview:self.player.view];
    
//    self.player.playbackRate = 0.5;
    self.playView.delegatePlayer = self.player;
    
    UITapGestureRecognizer *sliderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSliderAction:)];
    [self.playView.mediaProgressSlider addGestureRecognizer:sliderTap];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (![self.player isPlaying]) {
        
        [self installMovieNotificationObservers];
        
        [self.player prepareToPlay];
        
        [self.playView hide];
    }
    
    if (self.isFullScreen) {
        self.playView.mediaProgressSlider.hidden = YES;
        self.playView.totalDurationLabel.hidden = YES;
        self.playView.fullSreenBtn.hidden = YES;
    }else{
        
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.isFullScreen) {
        
    }else{
        self.view.frame = UIScreen16_9;
    }
    
    [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.equalTo(self.view);
    }];
    self.playView.overlayPanel.frame = self.view.frame;

}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.player shutdown];
    [self removeMovieNotificationObservers];
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (self.isFullScreen) {
//        NSLog(@"isll");
        return UIInterfaceOrientationMaskLandscape;
        
    }else{
//        NSLog(@"isnn");
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
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

#pragma mark IBAction- -播放器视图控制相关
- (IBAction)onClickOverlay:(id)sender
{
    if (self.isHideTool) {
        [self.playView showAndFade];
        self.isHideTool = NO;
    }else{
        [self.playView hide];
        self.isHideTool = YES;
    }
}

- (IBAction)Back:(UIButton *)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 强制屏幕旋转
- (IBAction)fullScreenAndScale:(UIButton *)btn {
    
    if (btn.selected) {
        self.isFullScreen = NO;
        btn.selected = NO;
        
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
    if (size.width > size.height) {
        [self.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(@0);
            make.width.equalTo(@(size.width));
            make.height.equalTo(@(size.height));
        }];
        self.player.playbackRate = 2;
    }else {
        [self.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(@0);
            make.width.equalTo(@(size.width));
            make.height.equalTo(@(size.width *(9.0 / 16.0)));
        }];
        self.player.playbackRate = 0.4;
    }
}

- (IBAction)onClickPlay:(id)sender
{
    [self.player play];
    [self.playView refreshMediaControl];
}

- (IBAction)onClickPause:(id)sender
{
    [self.player pause];
    [self.playView refreshMediaControl];
}

- (IBAction)didSliderTouchDown
{
    [self.playView beginDragMediaSlider];
}

- (IBAction)didSliderTouchCancel
{
    [self.playView endDragMediaSlider];
}

- (IBAction)didSliderTouchUpOutside
{
    [self.playView endDragMediaSlider];
}

- (IBAction)didSliderTouchUpInside
{
    self.player.currentPlaybackTime = self.playView.mediaProgressSlider.value;
    [self.playView endDragMediaSlider];
}

- (IBAction)didSliderValueChanged
{
    [self.playView continueDragMediaSlider];
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
    [self.rotationView addSubview:self.playView];
    [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.equalTo(self.view);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.playView showAndFade];
    });
    [self onClickPlay:nil];
    
    [self.playView setupSubviewsConstraint];
    
    // 亮度view加到window最上层
    ZFBrightnessView *brightnessView = [ZFBrightnessView sharedBrightnessView];
    [self.view addSubview:brightnessView];
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
