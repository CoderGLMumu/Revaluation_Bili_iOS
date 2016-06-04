//
//  BiLiBaseTwoLevelCollectionViewController.h
//  BiLiBil 二级展示界面
//
//  Created by sunny on 16/4/8.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiLiTwoLevelAllPlayingItem.h"
//#import "LBHttpTool.h"
@interface GLLiveContentShowViewController : UICollectionViewController

/** 标题对应的tag 用于请求数据 */
@property (nonatomic, strong) NSString *tag;

/** 标题对应的tag 用于请求数据 */
@property (nonatomic, assign) NSInteger area_id;

/** 排序方式 */
@property (nonatomic, strong) NSString *sort;

/** 每次网络请求的页数 */
@property (nonatomic, assign) NSInteger page;

/** 加载最新数据方法 */
- (void)loadData;

/** 加载更多数据方法 */
- (void)loadMoreData;

/** 快速创建的类工厂方法 */
+ (instancetype)viewController;
@end
