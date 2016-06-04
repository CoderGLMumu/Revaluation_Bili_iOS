//
//  LBRecommedModel.h
//  Bili
//
//  Created by 林彬 on 16/5/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LBBodyModel;
@interface LBRecommedModel : NSObject
@property(nonatomic , strong)NSDictionary *head;
@property(nonatomic , strong)NSArray *body;
@property(nonatomic , strong)NSString *type;

@property(nonatomic , assign) CGFloat cellHeight;
@property(nonatomic , strong)LBBodyModel *bodyItem;
@end
