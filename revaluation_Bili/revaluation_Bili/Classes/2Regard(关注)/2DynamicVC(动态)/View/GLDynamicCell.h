//
//  GLDynamicCell.h
//  Bili
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GLDynamicCellItem;
@interface GLDynamicCell : UITableViewCell

/** item */
@property (nonatomic, strong) GLDynamicCellItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView AndIdentifier:(NSString *)ID;
@end
