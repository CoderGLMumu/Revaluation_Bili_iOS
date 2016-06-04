//
//  LBEntranceButtonItem.h
//  Bili
//
//  Created by 林彬 on 16/4/14.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBEntranceButtonItem : NSObject
@property(nonatomic ,strong)NSDictionary *entrance_icon;

@property(nonatomic ,strong)NSString *name;


// 字典里的属性是id,和系统的关键字重名了.要用框架做下处理.
@property(nonatomic ,strong)NSNumber *ID;

@end
