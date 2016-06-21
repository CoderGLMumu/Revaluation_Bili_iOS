//
//  GLMotiveSealViewController.m
//  Bili
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "GLMotiveSealViewController.h"

#import "GLMotiveSealCell.h"

#import "GLMotiveSealCellItem.h"

#import "HMXFanJuDetailController.h"

#import "GLDIYHeader.h"

@interface GLMotiveSealViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableV;

/** MotiveSealCellItem_arr */
@property (nonatomic, strong) NSMutableArray<GLMotiveSealCellItem *> *motiveSealCellItem_arr;

@end

@implementation GLMotiveSealViewController

- (NSMutableArray *)motiveSealCellItem_arr
{
    if (_motiveSealCellItem_arr == nil) {
        _motiveSealCellItem_arr = [NSMutableArray array];
    }
    return _motiveSealCellItem_arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = GLRandomColor;
    
    self.navigationController.navigationBarHidden = YES;
    self.tableV.dataSource = self;
    
    self.tableV.delegate = self;
    
    self.tableV.rowHeight = 110;
    
    [self pullRefresh];
    
    [self loadData];
    
//    self.refresh_tableV = ^(UITableView *tableV){
//        tableV = self.tableV;
//    };
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
//    self.navigationController.navigationBarHidden = YES;
}

- (void)loadData
{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSDictionary *progress = @{
                    @"access_key":@"ae900d5c7c80481faf01a3e81fc8355e",
                               @"actionKey":@"appkey",
                               @"appkey":@"27eb53fc9058f8c3",
                               @"build":@"3060",
                               @"device":@"pad",
                               @"page":@"1",
                               @"pagesize":@"30",
                               @"platform":@"ios",
                        @"sign":@"800991505820fb53f69086878b7dab6d",
                               @"taid":@"",
                               @"ts":@"1460380310"
                               };
    /** 
     //    http://bangumi.bilibili.com/api/get_concerned_season?access_key=ae900d5c7c80481faf01a3e81fc8355e&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3060&device=pad&page=1&pagesize=30&platform=ios&sign=800991505820fb53f69086878b7dab6d&taid=&ts=1460380310
     */
    [session GET:@"http://bangumi.bilibili.com/api/get_concerned_season" parameters:progress progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /** 看到第 last_ep_index 话/total_count话全  title番剧名称  cover图片*/
        NSArray *arr_m = responseObject[@"result"];
        
        self.motiveSealCellItem_arr = [GLMotiveSealCellItem mj_objectArrayWithKeyValuesArray:arr_m];
        
        int i = 0;
        for (NSDictionary *dict_test in arr_m) {
   
            GLMotiveSealCellItem *item_1 = [GLMotiveSealCellItem mj_objectWithKeyValues:dict_test[@"user_season"]];
            
            self.motiveSealCellItem_arr[i].last_ep_index = item_1.last_ep_index;
            i++;
        }
        [self.tableV reloadData];
        [self endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self endRefreshing];
        GLLog(@"%@",error);
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.motiveSealCellItem_arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = @"glMotiveSealCell";
    
    GLMotiveSealCell *cell = [self.tableV dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [GLMotiveSealCell cellWithTableView:tableView AndIdentifier:ID];
    }
    
    if (self.motiveSealCellItem_arr) {
        cell.item = self.motiveSealCellItem_arr[indexPath.row];
    }
    
    return cell;
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

#pragma mark tableView代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMXFanJuDetailController *fanJuDetaiVC = [[HMXFanJuDetailController alloc]init];
    fanJuDetaiVC.motiveSealItem = self.motiveSealCellItem_arr[indexPath.row];
    [self.navigationController pushViewController:fanJuDetaiVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
