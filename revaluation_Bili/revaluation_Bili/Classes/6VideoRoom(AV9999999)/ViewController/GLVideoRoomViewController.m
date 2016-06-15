//
//  GLVideoRoomViewController.m
//  revaluation_Bili
//
//  Created by mac on 16/6/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLVideoRoomViewController.h"
#import "GLVideoRoomViewModel.h"
#import "GLVideoRoomItemViewModel.h"
#import "IJKMoviePlayerViewController.h"

@interface GLVideoRoomViewController ()

/** PVC */
@property (nonatomic, strong) IJKMoviePlayerViewController *PVC;

@property (weak, nonatomic) IBOutlet UIImageView *VideoPicView;
@property (weak, nonatomic) IBOutlet UILabel *VideoAidLabel;// AV号
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//视频标题
@property (weak, nonatomic) IBOutlet UILabel *viewLabel;//观看次数
@property (weak, nonatomic) IBOutlet UILabel *danmakuLabel;//发送的弹幕
@property (weak, nonatomic) IBOutlet UILabel *descLabel;//下拉简介
@property (weak, nonatomic) IBOutlet UILabel *shareLabel;//分享数量
@property (weak, nonatomic) IBOutlet UILabel *coinLabel;//投硬币量
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;//收藏量
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;//评论量
@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;//up头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//up名称
@property (weak, nonatomic) IBOutlet UILabel *pubdateLabel;//视频发布时间戳
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;//总充电
@property (weak, nonatomic) IBOutlet UILabel *countLabel;//本月充电
/** tags按钮 数组 */
@property (nonatomic, strong) NSArray *tags_Btn;

@property (weak, nonatomic) IBOutlet UIControl *videoView;

/** isFullScreen */
@property (nonatomic, assign) BOOL isFullScreen;

@end

@implementation GLVideoRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.alpha = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [RACObserve(self.viewModel, cellItemViewModels) subscribeNext:^(id x) {
        [self updateView];
    }];
    
}
/**
 * 更新视图.
 */
- (void)updateView
{
//    [self.viewModel hand]
    [self.VideoPicView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.pic] placeholderImage:[UIImage imageNamed:@"placeholderImageX"]];
    self.VideoAidLabel.text = self.viewModel.aid_str;
    self.titleLabel.text = self.viewModel.title;
    self.viewLabel.text = self.viewModel.view;
//    NSLog(@"%@-%@",self.viewModel.view,[self.viewModel.view class]);
    self.danmakuLabel.text = self.viewModel.danmaku;
    self.descLabel.text = self.viewModel.desc;
    self.shareLabel.text = self.viewModel.share;
    self.coinLabel.text = self.viewModel.coin;
    self.favoriteLabel.text = self.viewModel.favorite;
    self.replyLabel.text = self.viewModel.reply;
    [self.faceImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.face_str] placeholderImage:[UIImage imageNamed:@"placeholderImageX"]];
    self.nameLabel.text = self.viewModel.name;
    self.pubdateLabel.text = self.viewModel.pubdate;
    self.totalLabel.text = self.viewModel.total;
    self.countLabel.text = self.viewModel.count;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"touming"] forBarMetrics:UIBarMetricsCompact];
//    self.navigationController.navigationBar.alpha = 0;
//    self.navigationController.navigationBarHidden = YES;
}

- (IBAction)popBackBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.alpha = 0.0;
}

#pragma mark - 加载视频
- (IBAction)playVideoView:(UIControl *)sender {
    NSLog(@"播放视频");
    self.PVC = [IJKMoviePlayerViewController InitVideoViewFromViewController:self withTitle:@"testttttt" URL:[NSURL URLWithString:self.viewModel.videoLink] isLiveVideo:YES isOnlineVideo:NO isFullScreen:NO completion:nil];
    [self addChildViewController:self.PVC];
    [self.view addSubview:self.PVC.view];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.PVC SendBarrage:self.viewModel.arr_danmus];
    });
    
//    [self.tabBarController.tabBar setHidden:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
