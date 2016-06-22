//
//  WYLSweetsopTableViewController.m
//  Bili
//
//  Created by 王亚龙 on 16/4/3.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLSweetsopTableViewController.h"


@implementation WYLSweetsopTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载数据
    [self loadDataWithURLString:@"http://api.bilibili.com/list?_device=iphone&_hwid=4dc791b793a01fe3&_ulv=5000&access_key=fff31e88a011097d502f65c403a36bac&appkey=27eb53fc9058f8c3&appver=3060&build=3060&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=13&type=json&sign=3098b1116e6c9c09db8115f435a8cb75"];
    
}
@end
