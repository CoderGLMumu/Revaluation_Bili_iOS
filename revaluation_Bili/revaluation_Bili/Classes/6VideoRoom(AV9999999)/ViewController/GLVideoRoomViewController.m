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
#import "GLVideoDownloadMViewController.h"

#import "GLVideoDownloadCover.h"

@interface GLVideoRoomViewController () <UIGestureRecognizerDelegate>

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

@property (weak, nonatomic) IBOutlet UIScrollView *VideoPagesSView;
@property (weak, nonatomic) IBOutlet UILabel *VideoPagesLabel;


/** tags按钮 数组 */
@property (nonatomic, strong) NSArray *tags_Btn;

@property (weak, nonatomic) IBOutlet UIControl *videoView;

/** dwCoverView */
@property (nonatomic, weak) GLVideoDownloadCover *dwCoverView;

/** isFullScreen */
@property (nonatomic, assign) BOOL isFullScreen;

@end

@implementation GLVideoRoomViewController


-  (GLVideoDownloadCover *)dwCoverView
{
    
    if (_dwCoverView == nil) {
        GLVideoDownloadCover *dwCoverView = [[NSBundle mainBundle]loadNibNamed:@"GLVideoDownloadCover" owner:nil options:nil][0];
        dwCoverView.DownMClick = ^{
            
            GLVideoDownloadMViewController *downMVC = [[UIStoryboard storyboardWithName:@"GLVideoDownloadMViewController" bundle:nil] instantiateInitialViewController];
            
            [self.navigationController pushViewController:downMVC animated:YES];
        
        };
        _dwCoverView = dwCoverView;
    }
    return _dwCoverView;
}

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
    // 没有分集隐藏 VideoPagesSView 和 VideoPagesLabel
    
    
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
}

- (IBAction)popBackBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.navigationBar.alpha = 0.0;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - 加载视频
- (IBAction)playVideoView:(UIControl *)sender {
    NSLog(@"播放视频");
    self.PVC = [IJKMoviePlayerViewController InitVideoViewFromViewController:self withTitle:self.viewModel.title URL:[NSURL URLWithString:self.viewModel.videoLink] isLiveVideo:YES isOnlineVideo:NO isFullScreen:NO completion:nil];
    [self addChildViewController:self.PVC];
    [self.view addSubview:self.PVC.view];
    
    [self.PVC SendBarrage:self.viewModel.arr_danmus];
    
    [RACObserve(self.PVC, isFullScreen) subscribeNext:^(NSNumber *isFullScreen) {
        !isFullScreen.boolValue ? self.navigationController.interactivePopGestureRecognizer.delegate = nil : nil;
    }];
    
    [RACObserve(self.navigationController.navigationBar, alpha) subscribeNext:^(NSNumber *alpha) {
        [self.navigationController.navigationBar setHidden:YES];
    }];
}

/** 点击缓存按钮 */
- (IBAction)localVideo:(UIButton *)sender {
    
    if (!self.dwCoverView.superview) {
        [self.view addSubview:self.dwCoverView];
        [self.dwCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.dwCoverView.superview);
        }];
    }else{
        self.dwCoverView.hidden = NO;
    }
    
    // 根据 集数 添加scrollView内容
    
    
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
