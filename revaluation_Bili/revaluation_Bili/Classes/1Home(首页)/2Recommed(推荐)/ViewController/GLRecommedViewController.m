//
//  RecommedViewController.m
//  revaluation_Bili
//
//  Created by mac on 16/5/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLRecommedViewController.h"
#import "GLVideoRoomViewController.h"
#import "GLVideoRoomViewModel.h"
#import "GLLiveRoomViewController.h"
#import "GLLiveRoomViewModel.h"
#import "GLRecomBannerViewModel.h"

#import "GLRecommedViewModel.h"
#import "GLRecommedItemViewModel.h"
#import "GLRecommedCellViewModel.h"
#import "GLRecommedCellModel.h"
#import "GLRecommedCellItemViewModel.h"

#import "GLRecommedCell.h"

#import "GLDIYHeader.h"

#import <SDCycleScrollView/SDCycleScrollView.h>

@interface GLRecommedViewController () <SDCycleScrollViewDelegate>

@property (strong, nonatomic) GLRecommedViewModel * viewModel;

@property (strong, nonatomic) GLRecomBannerViewModel * bannerviewModel;

@end

@implementation GLRecommedViewController

static NSString * const recommendCellID = @"recommendCell";
static NSString * const liveCellID = @"liveCell";
static NSString * const bangumi_2CellID = @"bangumi_2Cell";
static NSString * const weblinkCellID = @"weblinkCell";
static NSString * const zhoukanCellID = @"zhoukanCell";
static NSString * const regionCellID = @"regionCell";
static NSString * const bangumi_3CellID = @"bangumi_3Cell";

- (GLRecommedViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[GLRecommedViewModel alloc] init];
    }
    return _viewModel;
}

- (GLRecomBannerViewModel *)bannerviewModel
{
    if (_bannerviewModel == nil) {
        _bannerviewModel = [[GLRecomBannerViewModel alloc] init];
    }
    return _bannerviewModel;
}


- (void)viewDidLoad {
    CGFloat imageH = GLScreenW * 200 / 640;
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, GLScreenW, imageH);
    
    [super viewDidLoad];
    
    /** 先读取缓存 */
    
    [self.bannerviewModel loadPhoneDataSourceToComplete:^{
        [self setupHeaderView];
    }];
    
    [self.viewModel loadPhoneDataSourceToComplete:^{
//        [self setupHeaderView];
    }];
    
    /** 网络请求 */
    [self bannerviewModel];
    
    [self viewModel];
    
    /** 设置头部 */
    [self setupTableView];
    
    [RACObserve(self.viewModel, cellItemViewModels) subscribeNext:^(id x) {
        [self updateView];
    }];
    
    [RACObserve(self.bannerviewModel, imageArr) subscribeNext:^(id x) {
        [self setupHeaderView];
    }];
    
}

- (void)setupTableView
{
    // 去掉Cell的间隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    /** 设置头部刷新 */
    self.tableView.mj_header = [GLDIYHeader headerWithRefreshingBlock:^{
        [self.viewModel first];
        [self.bannerviewModel handleRecomData];
    }];
}

- (void)setupHeaderView
{
    for (UIView *view in self.tableView.tableHeaderView.subviews) {
        [view removeFromSuperview];
    }
    if (self.bannerviewModel.imageArr) {
        
        // 网络加载 --- 创建带标题的图片轮播器
        SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:self.tableView.tableHeaderView.bounds delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView2.currentPageDotColor = GLColor(255, 30, 175);
        cycleScrollView2.pageDotColor = GLColor(255, 255, 255);
        
        cycleScrollView2.clickItemOperationBlock = ^(NSInteger currentIndex){
            NSString *value_str = self.bannerviewModel.imageValueArr[currentIndex];
            if([value_str hasPrefix:@"http://"]){
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:value_str]]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:value_str]];
                }
            }
        };
        
        // 自定义分页控件小圆标颜色
        [self.tableView.tableHeaderView addSubview:cycleScrollView2];
        cycleScrollView2.imageURLStringsGroup = self.bannerviewModel.imageArr;
    }
}

/**
 * 更新视图.
 */
- (void)updateView
{
    [self.tableView.mj_header endRefreshing];
    
    [self.tableView reloadData];
}

#pragma mark - talbeView数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = self.viewModel.cellItemViewModels.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // 传递VM
    // 设置 Cell...
    GLRecommedItemViewModel *vm = self.viewModel.cellItemViewModels[indexPath.row];
    
    GLRecommedCellViewModel *cellVM = [[GLRecommedCellViewModel alloc]init];
    
    cellVM.title = vm.title;
    
    cellVM.body = vm.body;
    
    [cellVM setCellBodyData];
    
    cellVM.type = vm.type;
    cellVM.style = vm.style;
    if ([vm.type isEqualToString:@"recommend"]) {
        GLRecommedCell *cell = [self.tableView dequeueReusableCellWithIdentifier:recommendCellID];
        cell.viewModel = cellVM;
        [self pushVideoVC:cell];
        return cell;
    } else if([vm.type isEqualToString:@"live"]){
        GLRecommedCell *cell = [self.tableView dequeueReusableCellWithIdentifier:liveCellID];
        [self pushVideoVC:cell];
        cell.viewModel = cellVM;
        return cell;
    } else if([vm.type isEqualToString:@"bangumi_2"]) {
        GLRecommedCell *cell = [self.tableView dequeueReusableCellWithIdentifier:bangumi_2CellID];
        [self pushVideoVC:cell];
        cell.viewModel = cellVM;
        return cell;
    } else if([vm.type isEqualToString:@"weblink"]) {
        GLRecommedCell *cell = [self.tableView dequeueReusableCellWithIdentifier:weblinkCellID];
        cell.viewModel = cellVM;
        return cell;
    } else if(vm.type == nil) {
        GLRecommedCell *cell = [self.tableView dequeueReusableCellWithIdentifier:zhoukanCellID];
        cellVM.type = @"zhoukan";
        cell.viewModel = cellVM;
        return cell;
    } else if([vm.type isEqualToString:@"region"]) {
        GLRecommedCell *cell = [self.tableView dequeueReusableCellWithIdentifier:regionCellID];
        [self pushVideoVC:cell];
        cell.viewModel = cellVM;
         return cell;
    } else if([vm.type isEqualToString:@"bangumi_3"]) {
        GLRecommedCell *cell = [self.tableView dequeueReusableCellWithIdentifier:bangumi_3CellID];
        [self pushVideoVC:cell];
        cell.viewModel = cellVM;
        return cell;
    }
    
    GLRecommedCell *cell = [GLRecommedCell new];
    
    return cell;
}

- (void)pushVideoVC:(GLRecommedCell *)cell
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            @weakify(cell);
            cell.Videodata = ^(GLRecommedCellModel *CellModel){
                @strongify(cell);
                if ([cell.viewModel.type isEqualToString:@"recommend"] || [cell.viewModel.type isEqualToString:@"region"] || [cell.viewModel.type isEqualToString:@"bangumi_2"]) {
                    //            [self.navigationController setNavigationBarHidden:YES animated:YES];
                    GLVideoRoomViewController *videoVC = [[UIStoryboard storyboardWithName:@"GLVideoRoomViewController" bundle:nil]instantiateInitialViewController];
                    GLVideoRoomViewModel *VM = [[GLVideoRoomViewModel alloc]initWithAid:CellModel.param];
                    videoVC.viewModel = VM;
//                     NSLog(@"======%@",CellModel.param);
                    [self.navigationController pushViewController:videoVC animated:YES];
                }else if ([cell.viewModel.type isEqualToString:@"live"]) {
                    GLLiveRoomViewController *liveRoomVC = [[GLLiveRoomViewController alloc]init];
                    
                    liveRoomVC.room_id = CellModel.param;
                    liveRoomVC.online = CellModel.online;
                    liveRoomVC.face = CellModel.up_face;
                    
                    [self.navigationController pushViewController:liveRoomVC animated:YES];
                }else if ([cell.viewModel.type isEqualToString:@"weblink"]) {
//                    NSLog(@"%@",CellModel);
                }
                //        weblink
            };
        });
    });
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    GLRecommedItemViewModel *vm=self.viewModel.cellItemViewModels[indexPath.row];
//    NSLog(@"tettt%f",vm.cellHeight);
    return [self.viewModel.cellItemViewModels[indexPath.row] cellHeight];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GLRecommedCell *cell = [tableView cellForRowAtIndexPath:indexPath];
/** 这里官方是自定义的WKWebView */
    if ([cell.viewModel.type isEqualToString:@"weblink"]){
        UIApplication *app = [UIApplication sharedApplication];
        NSURL *url =[NSURL URLWithString:cell.viewModel.body[0][@"param"]];
        if([app canOpenURL:url]){
            [app openURL:url];
        }
    }else if([cell.viewModel.type isEqualToString:@"zhoukan"]){
        GLVideoRoomViewController *videoVC = [[UIStoryboard storyboardWithName:@"GLVideoRoomViewController" bundle:nil]instantiateInitialViewController];
        GLRecommedCellItemViewModel *viewModel = (GLRecommedCellItemViewModel *)cell.viewModel.cellbodyItemViewModels[0];
        GLVideoRoomViewModel *VM = [[GLVideoRoomViewModel alloc]initWithAid:viewModel.param];
        videoVC.viewModel = VM;
        
        [self.navigationController pushViewController:videoVC animated:YES];
    }
//    NSLog(@"%@",cell.viewModel);
    
//    @weakify(cell);
//    cell.Videodata = ^(GLRecommedCellModel *CellModel){
//        @strongify(cell);
//        if ([cell.viewModel.type isEqualToString:@"weblink"]) {
//            NSLog(@"%@",CellModel);
//        }
//        //        weblink
//    };
    // 跳转控制器

//    cell.Videodata = ^{
//        UIViewController *vc = [UIViewController new];
//        vc.view.backgroundColor = [UIColor redColor];
//        [self.navigationController pushViewController:vc animated:YES];
//    
//    };
    
}
/** 设置头部视图和cell的间距 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

@end
