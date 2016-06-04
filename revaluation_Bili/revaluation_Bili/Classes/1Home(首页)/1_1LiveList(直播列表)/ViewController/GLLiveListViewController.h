//
//  GLLiveListViewController.h
//  revaluation_Bili
//
//  Created by mac on 16/5/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLLiveListViewController : UIViewController

/** 直播类型 列表ID */
@property (nonatomic, assign) int listID;

/** 直播列表名称  */
@property (nonatomic, strong) NSString *list_name;

@end
