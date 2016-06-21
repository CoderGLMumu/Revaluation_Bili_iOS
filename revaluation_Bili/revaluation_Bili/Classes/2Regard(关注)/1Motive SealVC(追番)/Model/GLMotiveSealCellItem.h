//
//  GLMotiveSealCellItem.h
//  Bili
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 看到第 last_ep_index 话/total_count话全  title番剧名称  cover图片*/

@interface GLMotiveSealCellItem : NSObject

/** 内容图片 */
@property (nonatomic, strong) NSString *cover;

/** 番剧标题 */
@property (nonatomic, strong) NSString *title;

/** 看到第 last_ep_index 话 */
@property (nonatomic, strong) NSString *last_ep_index;

/** 总番集数 */
@property (nonatomic, strong) NSString *total_count;

/** push控制器 详情页面 请求参数 */
@property (nonatomic, strong) NSString *season_id;

/** 是否已经观看 */
//@property (nonatomic, assign, getter=isWatch) BOOL Watch;

@end
