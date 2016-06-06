//
//  GLRecommedCellViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLRecommedCellViewModel.h"

#import "GLRecommedCellModel.h"

@implementation GLRecommedCellViewModel

- (instancetype)init
{
    self = [self initWithModel: nil];
    
    return self;
}

- (instancetype)initWithModel:(GLRecommedCellModel *)model
{
    self = [super init];
    
//    if (nil != self) {
//        // 设置self.blogId与model.id的相互关系.
//        [RACObserve(model, id) subscribeNext:^(id x) {
//            self.blogId = x;
//        }];
//        
//        [self setup];
//    }
    
    return self;
}

@end
