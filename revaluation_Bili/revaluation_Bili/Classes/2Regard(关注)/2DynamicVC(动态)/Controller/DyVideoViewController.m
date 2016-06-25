//
//  DyVideoViewController.m
//  Bili
//
//  Created by mac on 16/5/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "DyVideoViewController.h"
//#import "GLAVPlayerController.h"
#import "GLVideoPlayView.h"
//#import <SVProgressHUD.h>

@interface DyVideoViewController ()
@property (weak, nonatomic) IBOutlet UIView *PlayBackView;

/** cid */
@property (nonatomic, strong) NSString *cid;

/** PlayUrl */
@property (nonatomic, strong) NSString *playUrl;

/** isPlayer */
@property (nonatomic, assign) bool isPlaying;

@end

@implementation DyVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self loadViewData];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapInitPlyaer:)];
    [self.PlayBackView addGestureRecognizer:tap];
}

- (void)tapInitPlyaer:(UITapGestureRecognizer *)tap
{
    if (self.isPlaying) {
        return;
    }
    if (self.playUrl) {
//        [self setupVideoVC];
        self.isPlaying = YES;
        NSLog(@"成功加载播放器");
    }else{
        [SVProgressHUD showInfoWithStatus:@"网络不好,请稍后再试"];
    }
}

- (void)loadViewData
{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{
                               @"access_key":@"aa769b7fbfadf8a43d209a567792b1f7",
                               @"actionKey":@"appkey",
                               @"aid":self.aid,
                               @"appkey":@"27eb53fc9058f8c3",
                               @"build":@"3170",
                               @"device":@"phone",
                               @"plat":@"0",
                               @"platform":@"ios",
                               @"sign":@"2e64dfa7972576ede55bcef629552fe3",
                               @"ts":@"1462638919"
                               };
/*
 http://app.bilibili.com/x/view?access_key=aa769b7fbfadf8a43d209a567792b1f7&actionKey=appkey&aid=4570340&appkey=27eb53fc9058f8c3&build=3170&device=phone&plat=0&platform=ios&sign=2e64dfa7972576ede55bcef629552fe3&ts=1462638919
 */
    [session GET:@"http://app.bilibili.com/x/view" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        
        self.cid = responseObject[@"data"][@"pages"][0][@"cid"];
        [self loadVideoData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"DyVideoViewController-loadViewData-%@",error);
    }];
    
}

- (void)loadVideoData
{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{
                               @"platform":@"android",
                               @"_device":@"android",
                               @"_hwid":@"831fc7511fa9aff5",
                               @"_tid":@"0",
                               @"_p":@"1",
                               @"_down":@"0",
                               @"quality":@"2",
                               @"otype":@"json",
                               @"appkey":@"86385cdc024c0f6c",
                               @"type":@"mp4",
                               @"sign":@"7fed8a9b7b446de4369936b6c1c40c3f",
                               @"cid":self.cid
                               };
    /**
     //    http://interface.bilibili.com/playurl?platform=android&_device=android&_hwid=831fc7511fa9aff5&_tid=0&_p=1&_down=0&quality=2&otype=json&appkey=86385cdc024c0f6c&type=mp4&sign=7fed8a9b7b446de4369936b6c1c40c3f&cid=5378182
     */
    [session GET:@"http://interface.bilibili.com/playurl" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
       self.playUrl = responseObject[@"durl"][0][@"url"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [self endRefreshing];
        GLLog(@"%@",error);
    }];
}
/*
- (void)setupVideoVC
{
    GLAVPlayerController *av = [GLAVPlayerController shareGLAVPlayer];
    [av setupVideoPlayViewWithPlayUrl:self.playUrl Inview:self.view AtRect:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16)];
    
    [self.view addSubview:av.view];

    __weak GLAVPlayerController *weakav = av;
    
    av.playView.switchOrientation = ^(bool isUp){
        
//        if (isUp) {
//            weakav.playView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
//            weakav.playView.center = self.view.center;
//            [UIView animateWithDuration:0.5 animations:^{
//                weakav.playView.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
//            }];
//        }else{
//            weakav.playView.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.width * 9 / 16 * 0.5);
//            weakav.playView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
//            
//            [UIView animateWithDuration:0.5 animations:^{
//                weakav.playView.transform = CGAffineTransformMakeRotation(-(M_PI * 0.5));
//            }];
//        }
//        
    };
}
*/
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    GLAVPlayerController *av = [GLAVPlayerController shareGLAVPlayer];
//    [av removeAllItems];
//    av = nil;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
//    NSLog(@"%@",coordinator);
//    
//    NSLog(@"size%@",NSStringFromCGSize(size));
//    
//    GLAVPlayerController *av = [GLAVPlayerController shareGLAVPlayer];
//    if (size.width > size.height) {
//        NSLog(@"视频方大-");
//        av.playView.frame = CGRectMake(0, 0, size.width, size.height);
//        [self.view bringSubviewToFront:av.playView];
//    }else{
//        NSLog(@"视频xiao-");
//        av.playView.frame = CGRectMake(0, 0, size.width, size.width * 9 / 16);
//    }
}


#pragma mark - 屏幕旋转代理方法
//- (BOOL)isAnimated
//{
//    return YES;
//}

- (BOOL)initiallyInteractive
{
    return YES;
}

- (NSTimeInterval)transitionDuration
{
    return 10;
}

- (UIModalPresentationStyle)presentationStyle
{
    return UIModalPresentationOverCurrentContext;
}

- (UIView *)containerView
{
    return self.view;
}

- (CGAffineTransform)targetTransform
{
    return CGAffineTransformMakeRotation(M_PI_2);
}


@end
