//
//  GLRecomBannerViewModel.h
//  revaluation_Bili
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLRecomBannerViewModel : NSObject
/** 【值	可以是http://链接】 【可以是番剧aid号码】 */
@property (nonatomic, copy) NSArray *imageArr;
///** 【值	可以是http://链接】 【可以是番剧aid号码】 */
//@property (nonatomic, copy) NSString *value;
///** 【轮播图片】 */
//@property (nonatomic, copy) NSString *image;
///** 【类型	2是打开网页,3是番剧】 */
//@property (nonatomic, copy) NSNumber *type;

+ (instancetype)viewModel;

- (void)handleRecomData;

@end
