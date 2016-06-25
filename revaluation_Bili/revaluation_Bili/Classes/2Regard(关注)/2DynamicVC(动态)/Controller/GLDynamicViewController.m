//
//  DynamicViewController.m
//  Bili
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "GLDynamicViewController.h"

#import "GLDynamicCell.h"

#import "GLDynamicCellItem.h"

//#import "DyVideoViewController.h"
#import "GLDIYHeader.h"

#import "GLVideoRoomViewController.h"
#import "GLVideoRoomViewModel.h"

@interface GLDynamicViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableV;

/** DynamicCellItem_arr */
@property (nonatomic, strong) NSMutableArray *DynamicCellItem_arr;

@end

@implementation GLDynamicViewController

- (NSMutableArray *)DynamicCellItem_arr
{
    if (_DynamicCellItem_arr == nil) {
        _DynamicCellItem_arr = [NSMutableArray array];
    }
    return _DynamicCellItem_arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = GLRandomColor;

    self.tableV.delegate = self;
    self.tableV.dataSource = self;
//    self.tableV.sectionHeaderHeight = 0;
//    self.tableV.sectionFooterHeight = 5;
    self.tableV.rowHeight = 140;
    self.tableV.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    self.tableV.scrollIndicatorInsets = self.tableV.contentInset;
    
//    self.tableV.bounds.size.width = 
    
    [self pullRefresh];
    
    [self loadData];
}


- (void)loadData
{
    
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        
    NSDictionary *parameters = @{
 @"access_key":@"ae900d5c7c80481faf01a3e81fc8355e",
                               @"actionKey":@"appkey",
                               @"appkey":@"27eb53fc9058f8c3",
                               @"build":@"3060",
                               @"device":@"pad",
                               @"platform":@"ios",
                               @"pn":@"1",
                               @"ps":@"30",
                        @"sign":@"b68899662ee13ab87c3f4554ed78f6e4",
                               @"ts":@"1459964587",
                               @"type":@"0"
                              };
    /** 
     //    http://api.bilibili.com/x/feed/pull?access_key=ae900d5c7c80481faf01a3e81fc8355e&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3060&device=pad&platform=ios&pn=1&ps=30&sign=b68899662ee13ab87c3f4554ed78f6e4&ts=1459964587&type=0
     */
        [session GET:@"http://api.bilibili.com/x/feed/pull" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:responseObject[@"data"]];
            
            NSArray *arr_m = dictM[@"feeds"];
            
            for (NSDictionary *dict_test in arr_m) {
                
                GLDynamicCellItem *item_1 = [GLDynamicCellItem mj_objectWithKeyValues:dict_test[@"addition"]];
                GLDynamicCellItem *item_2 = [GLDynamicCellItem mj_objectWithKeyValues:dict_test[@"source"]];
                
                item_1.avatar = item_2.avatar;
            
                [self.DynamicCellItem_arr addObject:item_1];
                [self.tableV reloadData];
                [self endRefreshing];
            }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            GLLog(@"%@",error);
            [self endRefreshing];
        }];
}

- (void)viewDidLayoutSubviews
{
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.DynamicCellItem_arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = @"glDynamicCell";
    
    GLDynamicCell *cell = [self.tableV dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [GLDynamicCell cellWithTableView:tableView AndIdentifier:ID];
    }

    if (self.DynamicCellItem_arr.count != 0) {
        cell.item = self.DynamicCellItem_arr[indexPath.section];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GLLog(@"第%zd组被点击了,传递信息给下一个控制器",indexPath.section);
    GLDynamicCellItem *cellItem = self.DynamicCellItem_arr[indexPath.section];
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DyVideoViewController" bundle:nil];
//    
//    DyVideoViewController *dyVideo = [storyboard instantiateInitialViewController];
//    dyVideo.aid = cellItem.aid;
//    [self.navigationController pushViewController:dyVideo animated:YES];
    GLVideoRoomViewController *videoVC = [[UIStoryboard storyboardWithName:@"GLVideoRoomViewController" bundle:nil]instantiateInitialViewController];
    GLVideoRoomViewModel *VM = [[GLVideoRoomViewModel alloc]initWithAid:cellItem.aid];
    videoVC.viewModel = VM;
    
    [self.navigationController pushViewController:videoVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

//分隔线左对齐--必须赋值代理属性
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark UITableView + 下拉刷新 动画图片
- (void)pullRefresh
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    
    self.tableV.mj_header = [GLDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    
    // 马上进入刷新状态
    [self.tableV.mj_header beginRefreshing];
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    // 刷新表格
    [self loadData];
}

- (void)endRefreshing
{
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.tableV.mj_header endRefreshing];
}

@end
