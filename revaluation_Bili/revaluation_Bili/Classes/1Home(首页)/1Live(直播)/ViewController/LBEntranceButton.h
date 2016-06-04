//
//  LBEntranceButton.h
//  Bili
//
//  Created by 林彬 on 16/4/14.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LBEntranceButtonItem;
@interface LBEntranceButton : UIButton
// 定义一个模型属性
@property(nonatomic , strong)LBEntranceButtonItem *buttonItem;

@property(nonatomic , assign)NSNumber *buttonID;


@end
