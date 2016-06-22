//
//  WYLBaseGlobalViewController.m
//  Bili
//
//  Created by 王亚龙 on 16/5/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLBaseGlobalViewController.h"
#import "WYLSweetsopCell.h"

#import "WYLSweetsopItem.h"


static NSString *ID = @"cell";

@interface WYLBaseGlobalViewController ()

@end

@interface WYLBaseGlobalViewController()

@end

@implementation WYLBaseGlobalViewController
-(NSMutableArray *)itemArray
{
    if (_itemArray == nil) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"WYLSweetsopCell" bundle:nil] forCellReuseIdentifier:ID];
    
    //请求数据
//    [self loadData];
    
    //设置数据源
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

// 加载数据
-(void)loadDataWithURLString:(NSString *)url
{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [mgr GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        //获取字典
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:responseObject[@"list"]];
        
        //移除多余的key
        [dict removeObjectForKey:@"num"];
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (int i = 0; i < 20; i++) {
            NSDictionary *tempDict = dict[[NSString stringWithFormat:@"%d",i]];
            [array addObject:tempDict];
        }
        
        //字典数组-->模型数组
        self.itemArray = [WYLSweetsopItem mj_objectArrayWithKeyValuesArray:array];
        
        //刷新数据
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    
}




#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYLSweetsopCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    WYLSweetsopItem *item = self.itemArray[indexPath.row];
    
    //设置数据
    cell.item = item;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

@end
