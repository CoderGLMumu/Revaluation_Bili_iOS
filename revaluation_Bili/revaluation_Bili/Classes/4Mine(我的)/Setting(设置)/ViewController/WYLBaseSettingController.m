//
//  WYLBaseSettingController.m
//  Lottery
//
//  Created by 王亚龙 on 16/3/12.
//  Copyright © 2016年 王亚龙. All rights reserved.
//

#import "WYLBaseSettingController.h"
#import "WYLSettingGroupItem.h"
#import "WYLSettingRowItem.h"
#import "WYLSettingCell.h"

@interface WYLBaseSettingController ()

@end

@implementation WYLBaseSettingController


//加载数组
-(NSMutableArray *)groupArray
{
    if (_groupArray == nil) {
        _groupArray = [[NSMutableArray alloc] init];
    }
    return _groupArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

-(instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

#pragma mark - 数据源方法

//多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groupArray.count;
}

//多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //取出模型
    WYLSettingGroupItem *groupItem = self.groupArray[section];
    return groupItem.rowArray.count;
}

//设置cell的显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //取出模型
    WYLSettingGroupItem *groupItem = self.groupArray[indexPath.section];
    WYLSettingRowItem *item = groupItem.rowArray[indexPath.row];
    
    //创建cell
    WYLSettingCell *cell = [WYLSettingCell settingCellWithRowItem:item tableView:tableView style:UITableViewCellStyleValue1];
    
    //传递数据给cell
    cell.rowItem = item;
    
    return cell;
}


//头部标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //取出模型
    WYLSettingGroupItem *groupItem = self.groupArray[section];
    return groupItem.header;
}


-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    //取出模型
    WYLSettingGroupItem *groupItem = self.groupArray[section];
    return groupItem.footer;
}




@end
