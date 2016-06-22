//
//  PartitionItem.h
//  Bili
//
//  Created by mac on 16/4/23.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLPartitionItem : NSObject

/** ID */
@property (nonatomic, strong) NSString *ID;
/** 图片 */
@property (nonatomic, strong) NSString *pic;
/** 图片名称 */
@property (nonatomic, strong) NSString *name;

/** Item_index */
@property (nonatomic, strong) UIViewController* Item_VC;

@end
