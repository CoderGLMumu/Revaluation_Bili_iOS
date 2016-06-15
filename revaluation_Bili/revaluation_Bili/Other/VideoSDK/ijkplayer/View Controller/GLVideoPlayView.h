//
//  GLVideoPlayView.h
//  pack_ijkplayer
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IJKMediaPlayback;

@interface GLVideoPlayView : UIControl

- (void)showNoFade;
- (void)showAndFade;
- (void)hide;
- (void)refreshMediaControl;

- (void)beginDragMediaSlider;
- (void)endDragMediaSlider;
- (void)continueDragMediaSlider;

- (void)setupSubviewsConstraint;

- (void)SendBarrage:(NSArray *)arr_danmus;

//- (void)setupBaseViewConstraint;

- (void)tapSliderAction:(CGFloat)value;

@property(nonatomic,weak) id<IJKMediaPlayback> delegatePlayer;

/** 是否是在线直播 */
@property (nonatomic, assign) BOOL isOnlineVideo;

/** isHideTool */
@property (nonatomic, assign) BOOL isHideTool;

@property(nonatomic,strong) IBOutlet UIView *overlayPanel;
@property(nonatomic,strong) IBOutlet UIView *topPanel;
@property(nonatomic,strong) IBOutlet UIView *bottomPanel;

@property (weak, nonatomic) IBOutlet UIButton *fullSreenBtn;
@property (weak, nonatomic) IBOutlet UIButton *playOrPause;
@property (weak, nonatomic) IBOutlet UIButton *smallPlayOrPause;

@property(nonatomic,strong) IBOutlet UILabel *currentTimeLabel;
@property(nonatomic,strong) IBOutlet UILabel *totalDurationLabel;
@property(nonatomic,strong) IBOutlet UISlider *mediaProgressSlider;
@property (weak, nonatomic) IBOutlet UIProgressView *ProgressValueView;

@end
