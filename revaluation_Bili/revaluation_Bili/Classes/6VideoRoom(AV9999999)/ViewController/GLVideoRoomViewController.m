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

@interface GLVideoRoomViewController ()
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

@end

@implementation GLVideoRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (IBAction)popBackBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 加载视频
- (IBAction)playVideoView:(UIControl *)sender {
    NSLog(@"播放视频");
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
