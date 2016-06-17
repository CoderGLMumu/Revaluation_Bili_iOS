//
//  ViewController.h
//  pack_ijkplayer
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IJKMediaFramework/IJKMediaFramework.h>
@class GLVideoPlayView;

@interface IJKMoviePlayerViewController : UIViewController

@property(atomic,strong) NSURL *url;

@property(atomic, retain) id<IJKMediaPlayback> player;

- (instancetype)initWithURL:(NSURL *)url isLiveVideo:(BOOL)isLiveVideo isOnlineVideo:(BOOL)isOnlineVideo isFullScreen:(BOOL)isFullScreen;

/** 弹出播放器控制器 */
+ (instancetype)presentFromViewController:(UIViewController *)viewController withTitle:(NSString *)title URL:(NSURL *)url isLiveVideo:(BOOL)isLiveVideo isOnlineVideo:(BOOL)isOnlineVideo isFullScreen:(BOOL)isFullScreen completion:(void (^)())completion;

/** 返回播放器控制器 */
+ (instancetype)InitVideoViewFromViewController:(UIViewController *)viewController withTitle:(NSString *)title URL:(NSURL *)url isLiveVideo:(BOOL)isLiveVideo isOnlineVideo:(BOOL)isOnlineVideo isFullScreen:(BOOL)isFullScreen completion:(void (^)())completion;

@property (strong, nonatomic) IBOutlet GLVideoPlayView *playView;

@property (strong, nonatomic) IBOutlet GLVideoPlayView *playViewFullScreen;

@property (strong, nonatomic) IBOutlet GLVideoPlayView *onlinePlayView;

@property (strong, nonatomic) IBOutlet UIView *placeholderView;

/** 是否是弹出全屏播放 */
@property (nonatomic, assign) BOOL isFullScreen;

- (IBAction)popBackBtn:(UIButton *)btnClick;

- (void)GoBack;

- (void)toolsShowOrHidden;

- (void)SendBarrage:(NSArray *)arr_danmus;

@end

