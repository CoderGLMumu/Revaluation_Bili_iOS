//
//  WYLPlaySettingViewController.m
//  Bili
//
//  Created by 王亚龙 on 16/4/14.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLPlaySettingViewController.h"
#import "WYLSettingRowItem.h"
#import "WYLSettingGroupItem.h"
#import "WYLSettingCell.h"
#import "WYLSettingArrowItem.h"
#import "WYLSettingSwitchItem.h"

@interface WYLPlaySettingViewController ()

@end

@implementation WYLPlaySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"播放设置";
    
    [self addGroup1];
}

-(void)addGroup1
{
    //假数据
    WYLSettingArrowItem *rowItem1 = [WYLSettingArrowItem settingRowItemWithTitle:@"首选视频画面" detailText:@"高清"];
    
    WYLSettingSwitchItem *rowItem2 = [WYLSettingSwitchItem settingRowItemWithTitle:@"允许使用非 WI-FI 网络" detailText:nil];
    
    WYLSettingSwitchItem *rowItem3 = [WYLSettingSwitchItem settingRowItemWithTitle:@"自动播放" detailText:nil];
    
    WYLSettingSwitchItem *rowItem4 = [WYLSettingSwitchItem settingRowItemWithTitle:@"自动全屏播放" detailText:nil];
    
    NSArray *rowArray = @[rowItem1, rowItem2, rowItem3, rowItem4];
    
    //创建组模型
    WYLSettingGroupItem *groupItem = [WYLSettingGroupItem settingGroupItemWithrowArray:rowArray header:nil  footer:nil];
    
    [self.groupArray addObject:groupItem];
    
}

@end
