//
//  GLRecommedCellViewModel.h
//  revaluation_Bili
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GLRecommedCellModel;

/**
 *  cell的视图模型.
 */
@interface GLRecommedCellViewModel : NSObject

@property(nonatomic , strong)NSArray *body;

- (instancetype)initWithModel:(GLRecommedCellModel *) model;

@end
