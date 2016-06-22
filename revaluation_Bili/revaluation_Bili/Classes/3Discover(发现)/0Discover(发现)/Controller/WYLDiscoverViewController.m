//
//  WYLDiscoverViewController.m
//  Bili
//
//  Created by 王亚龙 on 16/4/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLDiscoverViewController.h"
#import "WYLHeaderView.h"
#import "WYLGlobalViewController.h"
#import "WYLSettingViewController.h"
#import "WYLCoverView.h"
#import "WYLPopView.h"
#import "WYLScanViewController.h"
#import "revaluation_Bili-Swift.h"
#import "WYLAuthorshipViewController.h"
#import "WYLSearchViewController.h"
#import "WYLGameCenterViewController.h"
#import "WYLTravelViewController.h"

#import "WYLButtonItem.h"
//#import <SVProgressHUD.h>

@interface WYLDiscoverViewController ()<UISearchBarDelegate>

/** 头部view*/
@property (nonatomic ,weak)WYLHeaderView *headerView;

@property (nonatomic ,assign) CGFloat height;

/** 遮盖*/
@property (nonatomic ,weak)WYLCoverView *coverView;

/** 模型数组*/
@property (nonatomic ,strong) NSArray *buttonItemArray;

/** scanVC */
@property (nonatomic, strong) WYLScanViewController *scanVC;

@end

@implementation WYLDiscoverViewController

- (WYLScanViewController *)scanVC
{
    if (_scanVC == nil) {
        // 从storyboard中加载控制器
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"WYLScanViewController" bundle:nil];
        _scanVC = [storyboard instantiateInitialViewController];
    }
    return _scanVC;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 设置导航条为显示
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置头部间距和尾部间距
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 10;
    
    //设置headerView
    [self setUpHeaderView];
    
    //设置滚动条
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    //加载数据
    [self loadData];
    
    //监听高度改变
    [self.headerView addObserver:self forKeyPath:@"height" options:NSKeyValueObservingOptionNew context:nil];
    

    
}




-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return NO;
}

// 加载数据
-(void)loadData
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [mgr GET:@"http://s.search.bilibili.com/main/hotword?access_key=fff31e88a011097d502f65c403a36bac&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3110&device=phone&platform=ios&sign=6a9f2664111393ff6e26e801ff211475&ts=1461496255" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        //        [responseObject writeToFile:@"/Users/apple/Desktop/button.plist" atomically:YES];
        //        responseObject[@"list"]
        
        //模型数组
        self.buttonItemArray = [WYLButtonItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.headerView.itemArray = self.buttonItemArray;
        //刷新数据
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


//监听的值发生改变时调用
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.height = self.headerView.height;
    self.headerView.frame = CGRectMake(0, 20, GLScreenW, self.height);
    self.tableView.tableHeaderView = self.headerView;
}

//添加headerView
-(void)setUpHeaderView
{
    //从xib中加载headerView
    WYLHeaderView *headerView = [WYLHeaderView headerView];
    _headerView = headerView;
    
    // 跳转到搜索控制器的block
    headerView.searchBlock = ^{
        WYLSearchViewController *searchVC = [[WYLSearchViewController alloc] init];
        [self presentViewController:searchVC animated:NO completion:nil];
    };
    
    
    headerView.valueBlock = ^{
        
        [self.navigationController pushViewController:self.scanVC animated:YES];
        [[QRCodeTool shareInstance] scanQRCode:self.scanVC.view isDraw:YES resultBlock:^(NSArray <NSString *> *resultStrs){
            
            NSString *resultStr = resultStrs.lastObject;
//            NSLog(@"resultStrGL %@",resultStr);


            
            // 这里有一个注意点,每次扫描到结果都会来调用这个block
            // 这里还有一个BUG,扫描页面不销毁的时候,当扫描到结果以后,再次扫描,无效果

            if ([resultStr containsString:@"http://"]) {
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:resultStr]]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:resultStr]];
                }
            }

            
            // 弹窗提示
            [SVProgressHUD showSuccessWithStatus:@"扫描到结果"];
            
            [UIView animateWithDuration:1 animations:^{
                //去掉弹窗
                [SVProgressHUD dismiss];
                
                if ([resultStr containsString:@"http://"]) {
                    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:resultStr]]) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:resultStr]];
                    }
                }
                
            }];
            
        }];
    };
    
    self.tableView.tableHeaderView = headerView;
    [self.tableView reloadData];
    
}

-(void)dealloc
{
    //移除监听
    [self.headerView removeObserver:self forKeyPath:@"height"];
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //显示遮盖,兴趣圈
    if (indexPath.section == 0 && indexPath.row == 0) {
        //显示遮盖
        WYLCoverView *coverView = [WYLCoverView show];
        self.coverView = coverView;
        //显示提示
        [WYLPopView show];
        //监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(miss) name:@"miss" object:nil];
        
    }
    
    //跳转原创排行榜
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        //隐藏底部条
        self.hidesBottomBarWhenPushed = YES;
        
        WYLAuthorshipViewController *AuthorshipVc = [[WYLAuthorshipViewController alloc] init];
        [self.navigationController pushViewController:AuthorshipVc animated:YES];
        
        //push后显示tabbar条
        self.hidesBottomBarWhenPushed = NO;
    }
    
    //跳转全区排行版
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        //隐藏底部条
        self.hidesBottomBarWhenPushed = YES;
        
        WYLGlobalViewController *globalVc = [[WYLGlobalViewController alloc] init];
        [self.navigationController pushViewController:globalVc animated:YES];

        //push后显示tabbar条
        self.hidesBottomBarWhenPushed = NO;
    }
    
    //跳转游戏中心
    if (indexPath.section == 2 && indexPath.row == 0) {
        WYLGameCenterViewController *gameCenterVc = [[WYLGameCenterViewController alloc] init];
        [self.navigationController pushViewController:gameCenterVc animated:YES];
    }
    
    //跳转海外游
    if (indexPath.section == 2 && indexPath.row == 1) {
        //隐藏底部条
        self.hidesBottomBarWhenPushed = YES;
        
        WYLTravelViewController *travelVc = [[WYLTravelViewController alloc] init];
        [self.navigationController pushViewController:travelVc animated:YES];
        
        //push后显示tabbar条
        self.hidesBottomBarWhenPushed = NO;
    }
}

-(void)miss
{
    [self.coverView removeFromSuperview];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}




@end
