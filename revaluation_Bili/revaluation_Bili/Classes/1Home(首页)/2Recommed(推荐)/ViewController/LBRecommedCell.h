//
//  LBRecommedCell.h
//  Bili
//
//  Created by 林彬 on 16/5/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LBRecommedModel;
@interface LBRecommedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic , strong) LBRecommedModel *cellItem;
@end
