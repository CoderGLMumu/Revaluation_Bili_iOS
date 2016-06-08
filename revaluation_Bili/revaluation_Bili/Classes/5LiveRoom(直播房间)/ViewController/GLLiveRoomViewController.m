//
//  GLLiveRoomViewController.m
//  revaluation_Bili
//
//  Created by mac on 16/5/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLLiveRoomViewController.h"
#import "GLLiveRoomViewModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GLLiveRoomCell.h"

#import <IJKMediaFramework/IJKMediaFramework.h>
#import "IJKMoviePlayerViewController.h"

#define margin 10

@interface GLLiveRoomViewController () <UIWebViewDelegate>

/** ViewModel */
@property (nonatomic, strong) GLLiveRoomViewModel *glLiveRoomViewModel;

/** footerViewLabel */
@property (nonatomic, weak) UILabel *footerViewLabel;

/** VideoView */
@property (nonatomic, weak) UIView *VideoView;


@end

@implementation GLLiveRoomViewController

- (GLLiveRoomViewModel *)glLiveRoomViewModel
{
    if (_glLiveRoomViewModel == nil) {
        _glLiveRoomViewModel = [GLLiveRoomViewModel viewModel];
    }
    return _glLiveRoomViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"直播房间";
    self.view.backgroundColor = GLColor(233, 233, 233);
    self.navigationController.navigationBarHidden = NO;
    
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBarButton setTitleColor:GLColor(205, 110, 140) forState:UIControlStateNormal];
    [rightBarButton setTitle:@"分享" forState:UIControlStateNormal];
    [rightBarButton setFont:[UIFont systemFontOfSize:17]];
    [rightBarButton sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBarButton];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    GLColor(245, 246, 247);
    self.tableView.backgroundColor = GLColor(245, 246, 247);
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GLLiveRoomCell class]) bundle:nil] forCellReuseIdentifier:@"LiveRoomCell"];
    
//    self.tableView.tableHeaderView  指向一个View 首先实现
//    self.tableView.tableFooterView  指向一个webView  第三实现
//    中间的cell只有1行 1列,高度根据tag 数组的按钮 宽高来计算  第二实现
//    (self.view.mas_height.accessibilityValue.floatValue * 0.5)
    
    @weakify(self)
    /** 头部视图 */
    UIView *headerView = [UIView new];
    [GLLiveRoomViewModel setUpHeaderView:headerView complete:^{
        @strongify(self)
        headerView.frame = CGRectMake(0, 0, self.view.glw_width, (self.view.glh_height * 0.5 - 20));
        self.tableView.tableHeaderView = headerView;
    }];
    
    /** 视频视图 */
    UIView *VideoView = [UIView new];
    [headerView addSubview:VideoView];
    [VideoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(headerView);
        make.height.equalTo(@(self.view.glw_width * 7.5 /16.0));
    }];
    VideoView.backgroundColor = [UIColor grayColor];
    self.VideoView = VideoView;
    
    /** UP主,信息视图 */
    UIView *up_infoView = [UIView new];
    [headerView addSubview:up_infoView];
    [up_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(VideoView.mas_bottom);
        make.left.right.bottom.equalTo(headerView);
    }];
//    up_infoView.backgroundColor = [UIColor purpleColor];
    [self.view layoutIfNeeded];
    
    /** UP主,头像IMGV */
    UIImageView *up_ImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pop"]];
    [up_infoView addSubview:up_ImageV];
    [up_ImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(up_ImageV.superview).offset(margin);
        make.height.width.equalTo(@(up_ImageV.superview.glh_height * 0.5));
    }];
//    up_ImageV.backgroundColor = [UIColor blueColor];
    up_ImageV.layer.shadowColor = GLColor(1, 1, 1).CGColor;
    up_ImageV.layer.shadowOffset = CGSizeMake(5, 5);
    up_ImageV.layer.shadowRadius = 5;
    up_ImageV.layer.shadowOpacity = 0.5;
    
    /** UP主,RoomTitle */
    UILabel *up_RoomTitle = [UILabel new];
    [up_infoView addSubview:up_RoomTitle];
    [up_RoomTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(up_RoomTitle.superview).offset(-margin);
        make.top.equalTo(up_ImageV);
        make.left.equalTo(up_ImageV.mas_right).offset(margin);
    }];
    up_RoomTitle.text = @"模拟数据模拟数据模拟数据模拟数据模拟数据模拟数据模拟数据模拟数据";
    up_RoomTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.view layoutIfNeeded];
    
    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];
    
    // [上面两个更新约束的方法不明用途]
    
    /** UP主,关注按钮【这个按钮的信息关于用户,是加密的拿不到】 */
    UIButton *up_regard_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [up_infoView addSubview:up_regard_btn];
    [up_regard_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(up_RoomTitle).offset(0);
        make.bottom.equalTo(up_ImageV).offset(5);
        make.width.equalTo(up_ImageV);
    }];
    [up_regard_btn setTitle:@"+关注" forState:UIControlStateNormal];
    [up_regard_btn setTitle:@"已关注" forState:UIControlStateSelected];
    [up_regard_btn setBackgroundColor:GLColor(205, 110, 140)];
    [[up_regard_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *clickBtn) {
        clickBtn.selected = !clickBtn.selected;
    }];
    
    /** UP主,名称 */
    UILabel *up_name = [UILabel new];
    [up_infoView addSubview:up_name];
    [up_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(up_ImageV.mas_right).offset(margin);
        make.right.equalTo(up_regard_btn.mas_left).offset(-margin);
        make.bottom.equalTo(up_ImageV);
    }];
    up_name.text = @"模拟数据模拟数据模拟数据模拟数据模拟数据模拟数据模拟数据模拟数据";
    up_name.lineBreakMode = NSLineBreakByTruncatingTail;
    
    /** UP主,两个像素的分割线 */
    UIView *up_sepLine = [UIView new];
    [up_infoView addSubview:up_sepLine];
    [up_sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(up_ImageV.mas_bottom).offset(margin);
        make.width.equalTo(up_sepLine.superview);
        make.height.equalTo(@2);
    }];
    up_sepLine.backgroundColor = GLColor(233, 233, 233);
    
    /** UP主,房间【在线】标签 */
    UILabel *up_onLineLabel = [UILabel new];
    [up_infoView addSubview:up_onLineLabel];
    [up_onLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(up_sepLine.mas_bottom).offset(5);
        make.bottom.equalTo(up_onLineLabel.superview.mas_bottom).offset(-5);
        make.left.equalTo(up_ImageV);
    }];
    up_onLineLabel.text = @"在线：";
    
    /** UP主,房间在线【人数】标签 */
    UILabel *up_onLineNumLabel = [UILabel new];
    [up_infoView addSubview:up_onLineNumLabel];
    [up_onLineNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(up_onLineLabel);
        make.bottom.equalTo(up_onLineLabel);
        make.left.equalTo(up_onLineLabel.mas_right).offset(5);
    }];
    up_onLineNumLabel.text = @"99998";
    
    /** tablev底部视图含有WebView视图 */
    UIView *footerView = [UIView new];
    
    [GLLiveRoomViewModel setUpFooterView:footerView complete:^{
        @strongify(self)
        footerView.frame = CGRectMake(0, 0, self.view.glw_width, 50);
        self.tableView.tableFooterView = footerView;
    }];
    
    /** footerView上的背景 */
    UIView *footerViewBackgroundView = [UIView new];
    [footerView addSubview:footerViewBackgroundView];
    [footerViewBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(footerViewBackgroundView.superview);
    }];
    footerViewBackgroundView.backgroundColor = GLColor(255, 255, 255);
    
    /** footerView上的公告文字 */
    UILabel *footerViewLabel = [UILabel new];
    [footerViewBackgroundView addSubview:footerViewLabel];
    self.footerViewLabel = footerViewLabel;
    [footerViewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(footerViewLabel.superview).offset(margin);
        make.right.equalTo(footerViewLabel.superview).offset(-margin);
    }];
    footerViewLabel.text = @"公告";
    
    /** footerView上的内容WebView */
    UIWebView *footerViewWebView = [UIWebView new];
    footerViewWebView.delegate = self;
    footerViewWebView.clipsToBounds = YES;
    footerViewWebView.scrollView.bounces = NO;
    
    [footerViewBackgroundView addSubview:footerViewWebView];
    [footerViewWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(footerViewLabel);
        make.top.equalTo(footerViewLabel.mas_bottom);
        make.bottom.equalTo(@1);
    }];
    
    self.glLiveRoomViewModel.liveRoomDataModel.face = self.face;
    
    __weak typeof(self)weakSelf = self;
    [self.glLiveRoomViewModel handleLiveViewDataWithRoom_id:self.room_id Success:^() {
//        liveRoomDataModel.face
        [self setupVideo:^(UIImageView *coverView) {
            [coverView sd_setImageWithURL:[NSURL URLWithString:self.glLiveRoomViewModel.liveRoomDataModel.COVER] placeholderImage:nil];
        }];
        
        [self.glLiveRoomViewModel handleVCToVMDataonline:weakSelf.online face:weakSelf.face];
        
        [up_ImageV sd_setImageWithURL:[NSURL URLWithString:self.glLiveRoomViewModel.liveRoomDataModel.face] placeholderImage:nil];
        
        up_RoomTitle.text = self.glLiveRoomViewModel.liveRoomDataModel.ROOMTITLE;
        
        up_name.text = self.glLiveRoomViewModel.liveRoomDataModel.ANCHOR_NICK_NAME;
        
        up_onLineNumLabel.text = self.glLiveRoomViewModel.liveRoomDataModel.online;
        
        [footerViewWebView loadHTMLString:self.glLiveRoomViewModel.liveRoomDataModel.des baseURL:nil];
        
        /** 刷新talbeView显示tag */
        [self.tableView reloadData];
        
    } Failure:^{
        
    }];
}

- (void)setupVideo:(void(^)(UIImageView *coverView))SetCoverView
{
    /** 视频简缩图 */
    UIImageView *coverView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"empty_list_not_found.jpg"]];
    [self.VideoView addSubview:coverView];
    [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.VideoView);
        
    }];
    
    coverView.userInteractionEnabled = YES;
    UITapGestureRecognizer *playLiveVideoTap = [UITapGestureRecognizer new];
    [coverView addGestureRecognizer:playLiveVideoTap];
    [[playLiveVideoTap rac_gestureSignal]subscribeNext:^(UITapGestureRecognizer *tap) {
        //弹出视频播放控制器
//        NSLog(@"弹出视频播放控制器URL---self.glLiveRoomViewModel.liveRoomDataModel- %@",self.glLiveRoomViewModel.liveRoomDataModel.ROOMTITLE);
        
        IJKMoviePlayerViewController *test = [IJKMoviePlayerViewController presentFromViewController:self withTitle:self.glLiveRoomViewModel.liveRoomDataModel.ROOMTITLE URL:[NSURL URLWithString:self.glLiveRoomViewModel.liveRoomDataModel.URL] isLiveVideo:YES isOnlineVideo:YES isFullScreen:YES completion:nil];
        test.view.frame = CGRectMake(0, 0, 100, 100);
    }];
    
    
    
    /** 毛玻璃 */
    UIToolbar *maoboli = [UIToolbar new];
    [coverView addSubview:maoboli];
    [maoboli mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(coverView);
    }];
    maoboli.barStyle = UIBarStyleBlack;
    maoboli.alpha = 0.9;//透明度
    
    /** 播放按钮图片 */
    UIImageView *playView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chase_roomplayer_start_icon"]];
    [coverView addSubview:playView];
    [playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(playView.superview);
        make.height.width.equalTo(@(playView.superview.glh_height * 0.23));
    }];
    SetCoverView(coverView);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GLLiveRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveRoomCell" forIndexPath:indexPath];
    
    cell.item = self.glLiveRoomViewModel.liveRoomDataModel;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return margin;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return margin;
}

#pragma mark - webView代理自动计算其高度
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
    
    webView.backgroundColor = [UIColor whiteColor];
    [webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.footerViewLabel.mas_bottom);
        make.left.right.equalTo(self.footerViewLabel);
        make.height.equalTo(@(actualSize.height - (self.footerViewLabel.glh_height * 0.5)));
    }];
    
    webView.scrollView.userInteractionEnabled = NO;
    
    GLLiveRoomCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
//    GLLiveRoomCell *cell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndex:0]];
    
    GLLiveRoomCell *cell3 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
//    [self.tableView.tableFooterView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.height.equalTo(@(actualSize.height+ self.footerViewLabel.glh_height));
//    }];
    
    self.tableView.tableFooterView.frame = CGRectMake(0, self.tableView.tableHeaderView.glh_height + cell.glh_height + self.footerViewLabel.glh_height, self.view.glw_width, actualSize.height + self.footerViewLabel.glh_height);
    
    self.tableView.contentSize = CGSizeMake(0, self.tableView.tableHeaderView.glh_height + cell.glh_height + (margin * 2) + self.footerViewLabel.glh_height + actualSize.height + margin);
    
    if (self.tableView.contentSize.height + 64 >= self.view.glh_height) {
        self.tableView.bounces = YES;
    }else{
        self.tableView.bounces = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [GLLiveRoomViewModel cancelloadLiveViewDataAtComplete:^{
        
    }];
}

- (void)dealloc
{
    NSLog(@"RoomVC,-dealloc");
    }

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
