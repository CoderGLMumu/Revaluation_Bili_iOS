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

//- (void)setupBaseViewConstraint;

- (void)tapSliderAction:(CGFloat)value;

@property(nonatomic,weak) id<IJKMediaPlayback> delegatePlayer;

@property(nonatomic,strong) IBOutlet UIView *overlayPanel;
@property(nonatomic,strong) IBOutlet UIView *topPanel;
@property(nonatomic,strong) IBOutlet UIView *bottomPanel;

@property(nonatomic,strong) IBOutlet UIButton *playButton;
@property(nonatomic,strong) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *fullSreenBtn;

@property(nonatomic,strong) IBOutlet UILabel *currentTimeLabel;
@property(nonatomic,strong) IBOutlet UILabel *totalDurationLabel;
@property(nonatomic,strong) IBOutlet UISlider *mediaProgressSlider;
@property (weak, nonatomic) IBOutlet UIProgressView *ProgressValueView;

@end
