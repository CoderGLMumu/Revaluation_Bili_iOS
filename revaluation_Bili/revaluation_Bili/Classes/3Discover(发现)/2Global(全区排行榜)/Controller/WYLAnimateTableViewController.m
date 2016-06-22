//
//  WYLAnimateTableViewController.m
//  Bili
//
//  Created by 王亚龙 on 16/4/3.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLAnimateTableViewController.h"

@interface WYLAnimateTableViewController ()

@end

@implementation WYLAnimateTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    // 加载数据
    [self loadDataWithURLString:@"http://api.bilibili.com/list?_device=iphone&_hwid=4dc791b793a01fe3&_ulv=5000&access_key=fff31e88a011097d502f65c403a36bac&appkey=27eb53fc9058f8c3&appver=3110&build=3110&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=1&type=json&sign=e48ee3927db0de223444c1636f29c7c1"];
}


@end
