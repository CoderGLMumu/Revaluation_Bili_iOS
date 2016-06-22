//
//  WYLGameCenterViewController.m
//  Bili
//
//  Created by 王亚龙 on 16/5/11.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLGameCenterViewController.h"

@interface WYLGameCenterViewController ()

@end

@implementation WYLGameCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标题
    self.title = @"游戏中心";
    
    // 加载数据
//    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

// 加载数据
-(void)loadData
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [mgr GET:@"http://api.biligame.com/app/iOS/homePage?access_key=fff31e88a011097d502f65c403a36bac&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3110&cli_version=4.17.1&device=phone&platform=ios&sign=d1bb1a4f19dadabd8b5b3f81e881ae43&svr_version=1.1&timestamp=1462936516000&ts=1462936516&udid=4dc791b793a01fe38ce943f118c81311&uid=26790158" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        //        [responseObject writeToFile:@"/Users/apple/Desktop/button.plist" atomically:YES];
        NSLog(@"%@",responseObject);
        
        //刷新数据
//        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if ( cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = @"马丹,数据加密";
    
    return cell;
}




@end
