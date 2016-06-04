//
//  BiLiBaseScrollViewController.h
//  BiLiBil 二级展示界面
//
//  Created by sunny on 16/4/7.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLLiveListTitleViewController : UIViewController

/**  标题按钮数组 <标题名称> */
@property (nonatomic, strong) NSArray *btn_Titles;

/** area_id  */
@property (nonatomic, assign) NSInteger area_id;

- (void)setupListView;

@end
