//
//  BiLiBaseTwoLevelCollectionViewController.m
//  BiLiBil 二级展示界面
//
//  Created by sunny on 16/4/8.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import "GLLiveContentShowViewController.h"
#import "GLLiveContentShowViewModel.h"
#import "GLPlaceholderView.h"

#import "ContentShowViewCell.h"
#import "GLDIYHeader.h"

#import "GLLiveRoomViewController.h"

@interface GLLiveContentShowViewController ()

/** glLiveContentShowViewModel */
@property (nonatomic, strong) GLLiveContentShowViewModel *glLiveContentShowViewModel;

@end

@implementation GLLiveContentShowViewController

static NSString * const reuseIdentifier = @"Cell";

- (GLLiveContentShowViewModel *)glLiveContentShowViewModel
{
    if (_glLiveContentShowViewModel == nil) {
        _glLiveContentShowViewModel = [GLLiveContentShowViewModel viewModel];
    }
    return _glLiveContentShowViewModel;
}

+ (instancetype)viewController
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(168, 150);
    layout.sectionInset = UIEdgeInsetsMake(10,12, 0, 12);
    GLLiveContentShowViewController *vc = [[self alloc] initWithCollectionViewLayout:layout];
    
    return vc;
}
#warning 需要实现每次点击 没有选中的 按钮都刷新界面,需要实现最新,最热排序
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GLPlaceholderView *placeholderView = [GLPlaceholderView sharePlaceholderView];
   
    [self.view addSubview:placeholderView];
    @weakify(self);
    [placeholderView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    self.glLiveContentShowViewModel.Reachable = ^{
        if (!placeholderView.superview) {
            [GLPlaceholderView sharePlaceholderView];
        }
    };
    
    self.glLiveContentShowViewModel.notReachable = ^(BOOL isTimeOut){
        [placeholderView netWorkNotReachableisTimeOut:isTimeOut];
    };
    
    self.glLiveContentShowViewModel.notData = ^{
        [placeholderView netWorkNotData];
    };
    
    self.page = 1;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //    注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"ContentShowViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.mj_header = [GLDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    // 先结束刷新,取消上一次的请求
    if ([self.collectionView.mj_header isRefreshing]) {
         @strongify(self);
        [GLLiveContentShowViewModel cancelloadLiveViewDataAtComplete:^{
            [self.collectionView.mj_header beginRefreshing];
        }];
    }
    
//    设置上拉刷新
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];

}
//sort  area_id
#pragma mark - 加载最新数据 （留给子类去实现）
- (void)loadData
{
    @weakify(self);
    [self.glLiveContentShowViewModel handleLiveViewDataWithTag:self.tag Sort:self.sort Area_id:(int)self.area_id Success:^{
        @strongify(self);
        /** 成功后处理占位视图并刷新collectionView */
        [[GLPlaceholderView sharePlaceholderView] removeFromSuperview];
        [self.collectionView reloadData];
        //        结束下拉刷新
        [self.collectionView.mj_header endRefreshing];
    } Failure:^{
        //        结束下拉刷新
        [self.collectionView.mj_header endRefreshing];

    }];
    
//    [LBHttpTool get:@"http://live.bilibili.com/mobile/rooms?_device=android&_hwid=16492aebc0d9175b&appkey=c1b107428d337928&area_id=11&build=417000&page=1&platform=android&sort=hottest&sign=8cf89d4e1286bf9d983eb0d04b008578" params:nil success:^(id responseObj) {
//
//        self.itemArray = [BiLiTwoLevelAllPlayingItem mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
//
//        //        刷新数据
//        [self.collectionView reloadData];
//
//        //        结束下拉刷新
//        [self.collectionView.mj_header endRefreshing];
//        
//    } failure:^(NSError *error) {
//        //        结束下拉刷新
//        [self.collectionView.mj_header endRefreshing];
//    }];
}

#pragma mark - 加载更多数据 （留给子类去实现）
- (void)loadMoreData
{
//    [LBHttpTool get:@"http://live.bilibili.com/mobile/rooms?_device=android&_hwid=16492aebc0d9175b&appkey=c1b107428d337928&area_id=11&build=417000&page=2&platform=android&sort=hottest&sign=0f76d2644842672fa9d55f7bfcda5874" params:nil success:^(id responseObj) {
//        
//        NSArray *tempArray = [BiLiTwoLevelAllPlayingItem mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
//        [self.itemArray addObjectsFromArray:tempArray];
//        
//        //        刷新数据
//        [self.collectionView reloadData];
//        
//        //        结束下拉刷新
//        [self.collectionView.mj_footer endRefreshing];
//        
//    } failure:^(NSError *error) {
//        //        结束下拉刷新
//        [self.collectionView.mj_footer endRefreshing];
//    }];
}

#pragma mark - collectionView的数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.glLiveContentShowViewModel.itemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ContentShowViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    BiLiTwoLevelAllPlayingItem *item = self.glLiveContentShowViewModel.itemArray[indexPath.row];
    cell.allPlayingItem = item;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // push控制器,传递cid,room_id,
    GLLiveRoomViewController *LiveRoomVC = [[GLLiveRoomViewController alloc]initWithStyle:UITableViewStyleGrouped];
    
    BiLiTwoLevelAllPlayingItem *LiveRoomItem = self.glLiveContentShowViewModel.itemArray[indexPath.row];
    
    LiveRoomVC.room_id = LiveRoomItem.room_id;
    
    LiveRoomVC.face = LiveRoomItem.owner.face;
    
    LiveRoomVC.online = [NSString stringWithFormat:@"%ld",(long)LiveRoomItem.online];
    
    [self.navigationController pushViewController:LiveRoomVC animated:YES];
}


@end
