//
//  LBLiveViewController.m
//  Bili
//
//  Created by 林彬 on 16/3/31.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBLiveViewModel.h"
// 直播
#import "LBLiveViewController.h"
#import "LBEntranceButtonItem.h"
#import "LBLiveViewCell.h"
#import "LBLiveItem.h"

#import "LBLiveBannerItem.h"
#import "LBHeaderView.h"
#import "GLDIYHeader.h"

#import "GLLiveListViewController.h" //more 直播列表

@interface LBLiveViewController ()<LBHeaderViewDelegate>

/** lbviewModel */
@property (nonatomic, weak) LBLiveViewModel *lbviewModel;

@end

@implementation LBLiveViewController

static NSString * const ID = @"LBLiveViewCell";

- (LBLiveViewModel *)lbviewModel
{
    if (_lbviewModel == nil) {
        _lbviewModel = [LBLiveViewModel viewModel];
    }
    return _lbviewModel;
}

#pragma mark -  界面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 去掉Cell的间隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.view.backgroundColor = LBGlobeColor;
    
    [self loadDataSouce];
    
    self.tableView.mj_header = [GLDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDataSouce)];
    
    [self.tableView.mj_header beginRefreshing];
    
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LBLiveViewCell" bundle:nil] forCellReuseIdentifier:ID];
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)setUpHeaderView
{
    
    [LBLiveViewModel setUpHeaderViewComplete:^(UIView *buttonView) {
        
        LBHeaderView *headView = [LBHeaderView headerViewFromNib];
        
        self.tableView.tableHeaderView = headView;
        headView.entranceButtomItems = self.lbviewModel.entranceButtomItems;
        headView.headerBannerArr = self.lbviewModel.headerBannerArr;
        // 设置headerView的代理
        headView.delegate = self;
        
        self.tableView.tableFooterView = buttonView;
    }];
}


/*
 http://live.bilibili.com/AppIndex/home?actionKey=appkey&appkey=27eb53fc9058f8c3&build=3060&device=phone&platform=ios&scale=2&sign=13f053baf875521b0d1958c812a0f110&ts=1460106665
 */

#pragma mark -  获取网络数据
- (void)loadDataSouce
{
    __weak typeof(self)weakSelf = self;
    // 发送网络请求
    [weakSelf.lbviewModel handleLiveViewDataSuccess:^{
        [weakSelf.tableView reloadData];
        [weakSelf setUpHeaderView];
        [weakSelf.tableView.mj_header endRefreshing];
    } Failure:^{
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}


#pragma mark -  实现headerView的代理方法
// 处理headerView的按钮点击事件
- (void)middleButtonsDidClick:(UIButton *)button ClickBtnID:(int)clickBtnID ButtonItem:(LBEntranceButtonItem *)buttonItem
{
    GLLiveListViewController *vc = [[GLLiveListViewController alloc]init];

    vc.list_name = buttonItem.name;

    vc.listID = clickBtnID;
    [self.navigationController pushViewController:vc animated:YES];
 
    /** 为什么直接使用 button 赋值标题会导致button.titleLabel的.text 无法显示 */
    
//    [self.lbviewModel.entranceButtomItems.rac_sequence.signal subscribeNext:^(id x) {
////        NSLog(@"%@",x);
//    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lbviewModel.cellItemArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBLiveViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.cellItem = self.lbviewModel.cellItemArr[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.lbviewModel.cellItemArr[indexPath.row] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}

@end
