//
//  GLVideoPlayView.m
//  pack_ijkplayer
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLVideoPlayView.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "Masonry.h"
#import <AVFoundation/AVFoundation.h>

// 枚举值，包含水平移动方向和垂直移动方向
typedef NS_ENUM(NSInteger, PanDirection){
    PanDirectionHorizontalMoved, //横向移动
    PanDirectionVerticalMoved    //纵向移动
};

@interface GLVideoPlayView () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *panel_bottomCpmstraont;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *panel_topCpmstraont;

/** NSTimer *progress_timer */
@property (nonatomic, strong) NSTimer *progress_timer;

/** 音量滑杆 */
@property (nonatomic, strong) UISlider *volumeViewSlider;

/** 用来保存快进的总时长 */
@property (nonatomic, assign) CGFloat sumTime;
/** 是否在调节音量*/
@property (nonatomic, assign) BOOL isVolume;

/** 快进快退label */
@property (nonatomic, strong) UILabel *horizontalLabel;

/** 定义一个实例变量，保存枚举值 */
@property (nonatomic, assign) PanDirection panDirection;

@end

@implementation GLVideoPlayView
{
    BOOL _isMediaSliderBeingDragged;
}

- (void)dealloc
{
    NSLog(@"GLvideo被销毁了");
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)tapSliderAction:(CGFloat)value
{
    
}

- (void)awakeFromNib
{
    [self refreshMediaControl];
    
    // 加载完成后，再添加平移手势
    // 添加平移手势，用来控制音量、亮度、快进快退
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panDirection:)];

    pan.delegate = self;
    
    [self addGestureRecognizer:pan];
    
    /** 获取/设置系统音量 */
    [self configureVolume];
    
    /** 每秒更新视频进度 */
    self.progress_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(time_second_listen) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.progress_timer forMode:NSRunLoopCommonModes];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    NSLog(@"awakeFromNib%@",self);

}

- (void)setupSubviewsConstraint
{
    [self addSubview:self.horizontalLabel];
    self.horizontalLabel.hidden = YES;
    [self.horizontalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(40);
        make.center.equalTo(self.delegatePlayer.view);
    }];
}

#pragma mark - 每秒设置进度条的进度
- (void)time_second_listen
{
    self.ProgressValueView.progress = self.delegatePlayer.playableDuration / self.delegatePlayer.duration;
}

#pragma mark - 淡入淡出工具条
- (void)showNoFade
{
     self.panel_bottomCpmstraont.constant = 0;
     self.panel_topCpmstraont.constant = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.playOrPause.alpha = 1;
        self.bottomPanel.alpha = 1;
        self.topPanel.alpha = 1;
       [self layoutIfNeeded];
    }];
    [self cancelDelayedHide];
    [self refreshMediaControl];
}

- (void)showAndFade
{
    [self showNoFade];
    [self performSelector:@selector(hide) withObject:nil afterDelay:6];
}

- (void)hide
{
    _panel_bottomCpmstraont.constant = -45;
    _panel_topCpmstraont.constant = -45;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.playOrPause.alpha = 0;
        self.bottomPanel.alpha = 0;
        self.topPanel.alpha = 0;
        [self layoutIfNeeded];
    }];
    
    self.isHideTool = YES;
    [self cancelDelayedHide];
}

- (void)cancelDelayedHide
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hide) object:nil];
}

#pragma mark - 拖拽进度条
- (void)beginDragMediaSlider
{
    _isMediaSliderBeingDragged = YES;
}

- (void)endDragMediaSlider
{
    _isMediaSliderBeingDragged = NO;
}

- (void)continueDragMediaSlider
{
    [self refreshMediaControl];
}

#pragma mark - 刷新工具条
- (void)refreshMediaControl
{
    // duration
    NSTimeInterval duration = self.delegatePlayer.duration;
    NSInteger intDuration = duration + 0.5;
    if (intDuration > 0) {
        self.mediaProgressSlider.maximumValue = duration;
        self.totalDurationLabel.text = [NSString stringWithFormat:@"%02d:%02d", (int)(intDuration / 60), (int)(intDuration % 60)];
    } else {
        self.totalDurationLabel.text = @"--:--";
        self.mediaProgressSlider.maximumValue = 1.0f;
    }
    
    
    // position
    NSTimeInterval position;
    if (_isMediaSliderBeingDragged) {
        position = self.mediaProgressSlider.value;
    } else {
        position = self.delegatePlayer.currentPlaybackTime;
    }
    NSInteger intPosition = position + 0.5;
    if (intDuration > 0) {
        self.mediaProgressSlider.value = position;
    } else {
        self.mediaProgressSlider.value = 0.0f;
    }
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d", (int)(intPosition / 60), (int)(intPosition % 60)];
    
    
    // status
//    BOOL isPlaying = [self.delegatePlayer isPlaying];
//    self.playButton.hidden = isPlaying;
//    self.pauseButton.hidden = !isPlaying;
    
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshMediaControl) object:nil];
    if (!self.overlayPanel.hidden) {
        [self performSelector:@selector(refreshMediaControl) withObject:nil afterDelay:0.5];
    }
}

#pragma mark - 音频/屏幕亮度调节

#pragma mark - UIPanGestureRecognizer手势方法

/**
 *  pan手势事件
 *
 *  @param pan UIPanGestureRecognizer
 */
- (void)panDirection:(UIPanGestureRecognizer *)pan
{
    //根据在view上Pan的位置，确定是调音量还是亮度
    CGPoint locationPoint = [pan locationInView:self];
    
    // 我们要响应水平移动和垂直移动
    // 根据上次和本次移动的位置，算出一个速率的point
    CGPoint veloctyPoint = [pan velocityInView:self];
    
    // 判断是垂直移动还是水平移动
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{ // 开始移动
            // 使用绝对值来判断移动的方向
            CGFloat x = fabs(veloctyPoint.x);
            CGFloat y = fabs(veloctyPoint.y);
            NSLog(@"%f,-%f",x,y);
            if (x > y) { // 水平移动
                // 取消隐藏
                if (self.isOnlineVideo) break;
                    self.horizontalLabel.hidden = NO;
                self.panDirection = PanDirectionHorizontalMoved;
                // 给sumTime初值
                NSTimeInterval time = self.delegatePlayer.currentPlaybackTime;
                self.sumTime = time;
                
                // 暂停视频播放
                [self.delegatePlayer pause];
                // 暂停timer
                [self.progress_timer setFireDate:[NSDate distantFuture]];
            }
            else if (x < y){ // 垂直移动
                self.panDirection = PanDirectionVerticalMoved;
                // 开始滑动的时候,状态改为正在控制音量
                if (locationPoint.x > self.bounds.size.width / 2) {
                    self.isVolume = YES;
                }else { // 状态改为显示亮度调节
                    self.isVolume = NO;
                }
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{ // 正在移动
            switch (self.panDirection) {
                case PanDirectionHorizontalMoved:{
                    if (self.isOnlineVideo) break;
                    [self horizontalMoved:veloctyPoint.x]; // 水平移动的方法只要x方向的值
                    break;
                }
                case PanDirectionVerticalMoved:{
                    [self verticalMoved:veloctyPoint.y]; // 垂直移动方法只要y方向的值
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case UIGestureRecognizerStateEnded:{ // 移动停止
            // 移动结束也需要判断垂直或者平移
            // 比如水平移动结束时，要快进到指定位置，如果这里没有判断，当我们调节音量完之后，会出现屏幕跳动的bug
            switch (self.panDirection) {
                case PanDirectionHorizontalMoved:{
                    if (self.isOnlineVideo) break;
                    // 继续播放
                    [self.delegatePlayer play];
                    [self.progress_timer setFireDate:[NSDate date]];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        // 隐藏视图
                        self.horizontalLabel.hidden = YES;
                    });
                    // 快进、快退时候把开始播放按钮改为播放状态
//                    self.controlView.startBtn.selected = YES;
//                    self.isPauseByUser                 = NO;
                    self.delegatePlayer.currentPlaybackTime = self.sumTime;
                    // 把sumTime滞空，不然会越加越多
                    self.sumTime = 0;
                    break;
                }
                case PanDirectionVerticalMoved:{
                    // 垂直移动结束后，把状态改为不再控制音量
                    self.isVolume = NO;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.horizontalLabel.hidden = YES;
                    });
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}

/**
 *  pan垂直移动的方法
 *
 *  @param value void
 */
- (void)verticalMoved:(CGFloat)value
{
    self.isVolume ? (self.volumeViewSlider.value -= value / 10000) : ([UIScreen mainScreen].brightness -= value / 10000);
}

/**
 *  pan水平移动的方法
 *
 *  @param value void
 */
- (void)horizontalMoved:(CGFloat)value
{
    
//    NSLog(@"GLtestMoved***%f",value);
    
    // 快进快退的方法
    NSString *style = @"";
    if (value < 0) { style = @"<<"; }
    if (value > 0) { style = @">>"; }
    // 每次滑动需要叠加时间
    self.sumTime += value / 200;
    
    // 需要限定sumTime的范围
    NSTimeInterval totalTime = self.delegatePlayer.duration;
    
    if (self.sumTime > totalTime) { self.sumTime = totalTime - 1;}
    if (self.sumTime < 0){ self.sumTime = 0; }
    
    // 当前快进的时间
    NSString *nowTime = [self durationStringWithTime:(int)self.sumTime];
    // 总时间
    NSString *durationTime = [self durationStringWithTime:(int)totalTime];
    // 给label赋值
    self.horizontalLabel.text = [NSString stringWithFormat:@"%@ %@ / %@",style, nowTime, durationTime];
}

/**
 *  获取系统音量
 */
- (void)configureVolume
{
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    self.volumeViewSlider = nil;
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            self.volumeViewSlider = (UISlider *)view;
            break;
        }
    }
    
    // 使用这个category的应用不会随着手机静音键打开而静音，可在手机静音下播放声音
    NSError *setCategoryError = nil;
    BOOL success = [[AVAudioSession sharedInstance]
                    setCategory: AVAudioSessionCategoryPlayback
                    error: &setCategoryError];
    
    if (!success) { /* handle the error in setCategoryError */ }
    
    // 监听耳机插入和拔掉通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioRouteChangeListenerCallback:) name:AVAudioSessionRouteChangeNotification object:nil];
}

/**
 *  耳机插入、拔出事件
 */
- (void)audioRouteChangeListenerCallback:(NSNotification*)notification
{
    NSDictionary *interuptionDict = notification.userInfo;
    
    NSInteger routeChangeReason = [[interuptionDict valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
    
    switch (routeChangeReason) {
            
        case AVAudioSessionRouteChangeReasonNewDeviceAvailable:
            // 耳机插入
            break;
            
        case AVAudioSessionRouteChangeReasonOldDeviceUnavailable:
        {
            // 耳机拔掉
            // 拔掉耳机暂停
            [self.delegatePlayer pause];
            [self showNoFade];
        }
            break;
            
        case AVAudioSessionRouteChangeReasonCategoryChange:
            // called at start - also when other audio wants to play
            NSLog(@"AVAudioSessionRouteChangeReasonCategoryChange");
            break;
    }
}

#pragma mark - UIGestureRecognizerDelegate
/** 控制pan手势的响应 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint point = [touch locationInView:self];
    // （屏幕下方slider区域） || (播放完了) =====>  不响应pan手势【如果是直播也要响应】 !isOnlineVideo 是在线视频返回YES
    if (((point.y > self.bounds.size.height-40) || self.delegatePlayer.currentPlaybackTime >=self.delegatePlayer.duration) && !self.isOnlineVideo) { return NO; }
    return YES;
}

#pragma mark - 时间格式化
/**
 *  根据时长求出字符串
 *
 *  @param time 时长
 *
 *  @return 时长字符串
 */
- (NSString *)durationStringWithTime:(int)time
{
    // 获取分钟
    NSString *min = [NSString stringWithFormat:@"%02d",time / 60];
    // 获取秒数
    NSString *sec = [NSString stringWithFormat:@"%02d",time % 60];
    return [NSString stringWithFormat:@"%@:%@", min, sec];
}


- (UILabel *)horizontalLabel
{
    if (!_horizontalLabel) {
        _horizontalLabel                 = [[UILabel alloc] init];
        _horizontalLabel.textColor       = [UIColor whiteColor];
        _horizontalLabel.textAlignment   = NSTextAlignmentCenter;
        // 设置快进快退label
        _horizontalLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Management_Mask"]];
    }
    return _horizontalLabel;
}
#pragma mark IBAction


- (void)SendBarrage:(NSArray *)arr_danmus
{
    

}

@end
