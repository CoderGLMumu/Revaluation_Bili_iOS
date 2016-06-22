//
//  WYLSearchViewController.m
//  Bili
//
//  Created by 王亚龙 on 16/5/10.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLSearchViewController.h"

@interface WYLSearchViewController ()<UISearchBarDelegate, UISearchResultsUpdating>

/** 搜索控制器*/
@property (nonatomic ,strong) UISearchController *searchController;
/** 需要展示的数据列表,这个列表要做缓存*/
@property (nonatomic ,strong) NSMutableArray *dataList;
/** 需要展示的搜索列表*/
@property (nonatomic ,strong) NSMutableArray *searchList;

@end

@implementation WYLSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加搜索控制器,搜索栏
    [self setUpSearchController];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self.searchController.searchBar becomeFirstResponder];
}

#pragma mark - 初始化
// 添加搜索控制器,搜索栏
-(void)setUpSearchController
{
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    // 初始化数据列表
    self.dataList = [NSMutableArray arrayWithCapacity:2000];
    for (int i = 0; i < 2000; i++) {
        [self.dataList addObject:[NSString stringWithFormat:@"马丹,数据又加密%zd",i]];
    }
    
    // 创建搜索控制器
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    // 是否隐藏
    self.searchController.dimsBackgroundDuringPresentation = YES;
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 40);
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    // 占位文字
    self.searchController.searchBar.placeholder = @"占位文字";
    
    self.searchController.searchBar.delegate = self;
    
    // 设置取消按钮
    [self.searchController.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
//    self.searchController.searchBar.tintColor = [UIColor colorWithRed:253/255.0 green:197/255.0 blue:211/255.0 alpha:1.0];
    self.searchController.searchBar.tintColor = [UIColor blackColor];
}


#pragma mark - UITableViewDataSource
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchController.active) {
        return self.searchList.count;
    }else{
        return self.dataList.count;
    }
}

// cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    // 设置数据
    if(self.searchController.active)
    {
        cell.textLabel.text = self.searchList[indexPath.row];
    }else{
        cell.textLabel.text = self.dataList[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UISearchBarDelegate
// searchBar开始编辑
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}

// 点击取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:NO completion:nil];
}



#pragma mark - UISearchResultsUpdating
// 更新数据
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // 取出搜索框的内容
    NSString *searchString = [self.searchController.searchBar text];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains %@", searchString];
    //    if (self.searchList) {
    //        [self.searchList removeAllObjects];
    //    }
    
    // 将搜索得到的数据存放到搜索列表中,用于显示
    // 过滤
    self.searchList = [NSMutableArray arrayWithArray:[self.dataList filteredArrayUsingPredicate:predicate]];
    
    
    // 刷新数据
    [self.tableView reloadData];
}





@end
