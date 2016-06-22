//
//  WYLBaseGlobalViewController.h
//  Bili
//
//  Created by 王亚龙 on 16/5/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYLBaseGlobalViewController : UITableViewController


/** 模型数组*/
@property (nonatomic ,strong) NSMutableArray *itemArray;

// 加载数据
-(void)loadDataWithURLString:(NSString *)url;

@end
