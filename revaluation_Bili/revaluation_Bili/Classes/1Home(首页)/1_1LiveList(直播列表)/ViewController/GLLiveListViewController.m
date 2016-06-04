//
//  GLLiveListViewController.m
//  revaluation_Bili
//
//  Created by mac on 16/5/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLLiveListViewController.h"
#import "GLLiveListViewModel.h"

#import "GLLiveListTitleViewController.h"
//#import "GLLiveContentShowViewController.h"

@interface GLLiveListViewController ()

/** 头部标题按钮控制器 */
@property (nonatomic, weak) GLLiveListTitleViewController *liveListTitleViewController;

///** 列表内容控制器 */
//@property (nonatomic, weak) GLLiveContentShowViewController *liveContentShowViewController;

@end

@implementation GLLiveListViewController

#pragma mark - 懒加载子控制器
- (GLLiveListTitleViewController *)liveListTitleViewController
{
    if (_liveListTitleViewController == nil) {
        GLLiveListTitleViewController *liveListTitleVC = [[GLLiveListTitleViewController alloc] init];
        [self addChildViewController:liveListTitleVC];
        self.liveListTitleViewController = liveListTitleVC;
    }
    return _liveListTitleViewController;
}

//- (GLLiveContentShowViewController *)liveContentShowViewController
//{
//    if (_liveContentShowViewController == nil) {
//        [self addChildViewController: [[GLLiveContentShowViewController alloc] init]];
//    }
//    return _liveContentShowViewController;
//}

/** 
 // 1 网络请求【拿到TitleVC需要的数据】
 
 // 2 设置TitleVC【点击TitleBtn请求ContentShowVC数据】
 
 // 3 设置ContentShowVC 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.list_name;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self liveListTitleViewController];
    [self.view addSubview:self.childViewControllers.firstObject.view];
    
    /** 处理 TitleVC 后的操作 传递数据给 TitleVC */
    __weak typeof(self) weakSelf = self;
    [[GLLiveListViewModel viewModel]handleLiveViewDataWithListID:self.listID success:^(NSArray *btn_titles) {
   
//        [self liveListTitleViewController];
        weakSelf.liveListTitleViewController.area_id = weakSelf.listID;
        weakSelf.liveListTitleViewController.btn_Titles = btn_titles;
        [weakSelf.liveListTitleViewController setupListView];
        
    } Failure:^(NSArray *btn_titles) {
        weakSelf.liveListTitleViewController.area_id = weakSelf.listID;
        weakSelf.liveListTitleViewController.btn_Titles = btn_titles;
        [weakSelf.liveListTitleViewController setupListView];
    }];
   
    
}


@end
