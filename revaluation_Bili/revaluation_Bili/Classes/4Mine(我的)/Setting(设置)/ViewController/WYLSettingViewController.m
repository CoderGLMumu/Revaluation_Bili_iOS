//
//  WYLSettingViewController.m
//  Bili
//
//  Created by 王亚龙 on 16/4/14.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLSettingViewController.h"
#import "WYLSettingRowItem.h"
#import "WYLSettingGroupItem.h"
#import "WYLSettingCell.h"
#import "WYLSettingArrowItem.h"
#import "WYLSettingSwitchItem.h"
#import "WYLPlaySettingViewController.h"

@interface WYLSettingViewController ()

@end

@implementation WYLSettingViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"设置";
    
    self.tableView.sectionHeaderHeight = 20;
    self.tableView.sectionFooterHeight = 0;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-15, 0, 0, 0);
    
    //添加组模型
    [self addGroup1];
    [self addGroup2];
    [self addGroup3];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)addGroup1
{
    WYLSettingArrowItem *rowItem1 = [WYLSettingArrowItem settingRowItemWithTitle:@"播放设置" detailText:nil];
    //设置跳转
    rowItem1.desClass = [WYLPlaySettingViewController class];
    rowItem1.myBlock = ^{
        [self.navigationController pushViewController:[[WYLPlaySettingViewController alloc] init] animated:YES];
    };
    
    WYLSettingArrowItem *rowItem2 = [WYLSettingArrowItem settingRowItemWithTitle:@"弹幕设置" detailText:nil];
    
    WYLSettingArrowItem *rowItem3 = [WYLSettingArrowItem settingRowItemWithTitle:@"缓存设置" detailText:nil];
    
    WYLSettingArrowItem *rowItem4 = [WYLSettingArrowItem settingRowItemWithTitle:@"分享授权设置" detailText:nil];
    
    WYLSettingSwitchItem *rowItem5 = [WYLSettingSwitchItem settingRowItemWithTitle:@"关闭启动动画" detailText:nil];
    
    NSArray *rowArray = @[rowItem1, rowItem2, rowItem3, rowItem4, rowItem5];
    
    //创建组模型
    WYLSettingGroupItem *groupItem = [WYLSettingGroupItem settingGroupItemWithrowArray:rowArray header:nil  footer:nil];
    
    [self.groupArray addObject:groupItem];
    
}

-(void)addGroup2
{
    WYLSettingArrowItem *rowItem1 = [WYLSettingArrowItem settingRowItemWithTitle:@"关于哔哩哔哩iOS官方客户端" detailText:nil];
    
    WYLSettingArrowItem *rowItem2 = [WYLSettingArrowItem settingRowItemWithTitle:@"给我们平分" detailText:nil];
    
    WYLSettingArrowItem *rowItem3 = [WYLSettingArrowItem settingRowItemWithTitle:@"反馈问题或建议" detailText:nil];
    
    NSArray *rowArray = @[rowItem1, rowItem2, rowItem3];
    
    //创建组模型
    WYLSettingGroupItem *groupItem = [WYLSettingGroupItem settingGroupItemWithrowArray:rowArray header:nil  footer:nil];
    
    [self.groupArray addObject:groupItem];
    
}

-(void)addGroup3
{
    //假数据
    WYLSettingRowItem *rowItem1 = [WYLSettingRowItem settingRowItemWithTitle:@"当前版本" detailText:@"4.17.1(3110)"];
    WYLSettingRowItem *rowItem2 = [WYLSettingRowItem settingRowItemWithTitle:@"核心组件" detailText:@"3.0.8"];
    WYLSettingRowItem *rowItem3 = [WYLSettingRowItem settingRowItemWithTitle:@"启动组件" detailText:@"1460604061"];
    
    NSArray *rowArray = @[rowItem1, rowItem2, rowItem3];
    
    //创建组模型
    WYLSettingGroupItem *groupItem = [WYLSettingGroupItem settingGroupItemWithrowArray:rowArray header:nil  footer:nil];
    
    [self.groupArray addObject:groupItem];
    
}

#pragma mark - 代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出模型
    WYLSettingGroupItem *groupItem = self.groupArray[indexPath.section];
    WYLSettingRowItem *item = groupItem.rowArray[indexPath.row];
    
    //判断模型的类型是不是箭头
    if ([item isKindOfClass:[WYLSettingArrowItem class]]) {
        //真实类型
        WYLSettingArrowItem *rowItem = (WYLSettingArrowItem *)item;
        
        //如果实现了block
        if (rowItem.myBlock) {
            //执行block
            rowItem.myBlock();
            return;
        }
        //判断有没有要跳转的类
//        if (rowItem.desClass) {
//            //创建控制器,并跳转
//            WYLPushViewController *pushVC = [[rowItem.desClass alloc] init];
//            [self.navigationController pushViewController:pushVC animated:YES];
//        }
    }
}



@end
