//
//  GLRecomBannerModel.h
//  revaluation_Bili
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLRecomBannerModel : NSObject
/** 标题,暂时没发现用途	"双星之阴阳师" */
@property (nonatomic, copy) NSString *title;
/** 【值	可以是http://链接】 【可以是番剧aid号码】 */
@property (nonatomic, copy) NSString *value;
/** 【轮播图片】 */
@property (nonatomic, copy) NSString *image;
/** 【类型	2是打开网页,3是番剧】 */
@property (nonatomic, copy) NSNumber *type;
/** 【重量	没发现用途】 */
@property (nonatomic, copy) NSNumber *weight;
/** 【备注	可能为空】 */
@property (nonatomic, copy) NSString *remark;
/** 【哈希值	291fa812775fe5d9d6d98e8fdebe82ae】 不知道干嘛的 先注释 */
//@property (nonatomic, copy) NSString *hash;

@end
