//
//  GLonlineVideoPlayView.h
//  pack_ijkplayer
//
//  Created by mac on 16/6/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IJKMediaPlayback;

@interface GLonlineVideoPlayView : UIControl

@property(nonatomic,weak) id<IJKMediaPlayback> delegatePlayer;

@property(nonatomic,strong) IBOutlet UIView *overlayPanel;
@property(nonatomic,strong) IBOutlet UIView *topPanel;
@property(nonatomic,strong) IBOutlet UIView *bottomPanel;

@property (weak, nonatomic) IBOutlet UILabel *videoTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlinePeopleLabel;

@property (weak, nonatomic) IBOutlet UIButton *goBackButton;
@property (weak, nonatomic) IBOutlet UIButton *backGroundPlayButton;
@property (weak, nonatomic) IBOutlet UIButton *videoQualityButton;
@property (weak, nonatomic) IBOutlet UIButton *videoscaleButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;
@property (weak, nonatomic) IBOutlet UIButton *danmuIsShowButton;
@property (weak, nonatomic) IBOutlet UIButton *volumeButton;
@property (weak, nonatomic) IBOutlet UIButton *addDanmuButton;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseVideoButton;
@property (weak, nonatomic) IBOutlet UIButton *giftButton;
@property (weak, nonatomic) IBOutlet UIButton *timerButton;


@end
