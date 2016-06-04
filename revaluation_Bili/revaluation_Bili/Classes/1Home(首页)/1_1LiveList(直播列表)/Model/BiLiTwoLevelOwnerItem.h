//
//  BiLiTwoLevelAllPlayingOwnerItem.h
//  BiLiBil 二级展示界面
//
//  Created by sunny on 16/4/17.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BiLiTwoLevelOwnerItem : NSObject
/** 用户名 */
@property (nonatomic,weak)NSString *name;
/** 左下角的脸的url字符串 */
@property (nonatomic,strong)NSString *face;

@end
