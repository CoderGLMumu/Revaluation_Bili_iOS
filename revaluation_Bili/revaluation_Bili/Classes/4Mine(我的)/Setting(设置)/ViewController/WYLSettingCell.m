//
//  WYLSettingCell.m
//  Lottery
//
//  Created by 王亚龙 on 16/3/12.
//  Copyright © 2016年 王亚龙. All rights reserved.
//

#import "WYLSettingCell.h"
#import "WYLSettingRowItem.h"
#import "WYLSettingArrowItem.h"
#import "WYLSettingSwitchItem.h"

@implementation WYLSettingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//创建cell
+(WYLSettingCell *)settingCellWithRowItem:(WYLSettingRowItem *)rowItem tableView:(UITableView *)tableView style:(UITableViewCellStyle)style
{
    //创建cell
    static NSString *ID = @"settingCell";
    WYLSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WYLSettingCell alloc] initWithStyle:style reuseIdentifier:ID];
    }
    
    return cell;
}


//设置数据
-(void)setRowItem:(WYLSettingRowItem *)rowItem
{
    _rowItem = rowItem;
    self.textLabel.text = rowItem.title;
    self.detailTextLabel.text = rowItem.detailText;
    
    if ([rowItem isKindOfClass:[WYLSettingArrowItem class]]) {
        //设置cell的样式
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if ([rowItem isKindOfClass:[WYLSettingSwitchItem class]])
    {
        self.accessoryView = [[UISwitch alloc] init];
    }else 
    {
        self.accessoryType = UITableViewCellAccessoryNone;
        //设置cell不能选择
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
}








@end
