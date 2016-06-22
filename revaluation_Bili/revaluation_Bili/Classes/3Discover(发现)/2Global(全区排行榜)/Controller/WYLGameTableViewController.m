//
//  WYLGameTableViewController.m
//  Bili
//
//  Created by 王亚龙 on 16/4/3.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLGameTableViewController.h"

@interface WYLGameTableViewController ()

@end

@implementation WYLGameTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDataWithURLString:@"http://api.bilibili.com/list?_device=iphone&_hwid=4dc791b793a01fe3&_ulv=5000&access_key=fff31e88a011097d502f65c403a36bac&appkey=27eb53fc9058f8c3&appver=3110&build=3110&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=4&type=json&sign=ffea781cc69b81d1c7f1f15f0690e8df"];
}
@end
