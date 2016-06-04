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

- (instancetype)initWithURL:(NSURL *)url isLiveVideo:(BOOL)isLiveVideo isFullScreen:(BOOL)isFullScreen;

+ (void)presentFromViewController:(UIViewController *)viewController withTitle:(NSString *)title URL:(NSURL *)url isLiveVideo:(BOOL)isLiveVideo isFullScreen:(BOOL)isFullScreen completion:(void (^)())completion;

@property (strong, nonatomic) IBOutlet GLVideoPlayView *playView;


@end

