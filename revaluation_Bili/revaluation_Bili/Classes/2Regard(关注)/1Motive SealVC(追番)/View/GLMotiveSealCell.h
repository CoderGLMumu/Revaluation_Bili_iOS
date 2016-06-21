//
//  GLMotiveSealCell.h
//  Bili
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GLMotiveSealCellItem;
@interface GLMotiveSealCell : UITableViewCell

/** <#描述#> */
@property (nonatomic, strong) GLMotiveSealCellItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView AndIdentifier:(NSString *)ID;

@end
