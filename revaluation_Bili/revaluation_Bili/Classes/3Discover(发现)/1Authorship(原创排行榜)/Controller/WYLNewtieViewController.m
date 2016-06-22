//
//  WYLNewtieViewController.m
//  Bili
//
//  Created by 王亚龙 on 16/5/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLNewtieViewController.h"

@interface WYLNewtieViewController ()

@end

@implementation WYLNewtieViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    // 加载数据
    [self loadDataWithURLString:@"http://api.bilibili.com/list?_device=iphone&_hwid=4dc791b793a01fe3&_ulv=5000&access_key=fff31e88a011097d502f65c403a36bac&appkey=27eb53fc9058f8c3&appver=3110&build=3110&ios=0&order=hot&page=0&pagesize=20&platform=ios&type=json&sign=5186ec1e943d58558d1fde7c9bf367fd"];
}
@end
