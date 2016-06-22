//
//  WYLAmusementTableViewController.m
//  Bili
//
//  Created by 王亚龙 on 16/4/3.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLAmusementTableViewController.h"

@interface WYLAmusementTableViewController ()

@end

@implementation WYLAmusementTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDataWithURLString:@"http://api.bilibili.com/list?_device=iphone&_hwid=4dc791b793a01fe3&_ulv=5000&access_key=fff31e88a011097d502f65c403a36bac&appkey=27eb53fc9058f8c3&appver=3110&build=3110&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=5&type=json&sign=4b2e1a254292e3ea531cd4328d52307d"];
}

@end
