//
//  GLRecommedItemViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLRecommedItemViewModel.h"
#import "GLRecommedModel.h"

#import "GLBodyModel.h"

@implementation GLRecommedItemViewModel

- (instancetype)initWithArticleModel:(GLRecommedModel *)model
{
    self = [super init];
    if (nil != self) {
        // 设置intro属性和model的属性的级联关系.
//        RAC(self, title) = [RACSignal combineLatest:@[RACObserve(model, head), RACObserve(model, desc)] reduce:^id(NSString * title, NSString * desc){
//            NSString * intro = [NSString stringWithFormat: @"标题:%@ 内容:%@", model.title, model.desc];
//            
//            return intro;
//        }];
        [RACObserve(model, head) subscribeNext:^(NSDictionary *head) {
            self.title = head[@"title"];
        }];
        
        
        // 设置self.blogId与model.id的相互关系.
        [RACObserve(model, type) subscribeNext:^(NSString *type) {
            self.type = type;
        }];
    }
    
    return self;
}

-(CGFloat)cellHeight
{
    // 如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    
    if (_type == nil || [_type isEqualToString:@"weblink"]) return (GLScreenW - 20) * 211 / 714 + 30;
    
    GLBodyModel *item = [NSArray yy_modelArrayWithClass:[GLBodyModel class] json:self.body][0];
    
    //    LBBodyModel *item = [LBBodyModel mj_objectArrayWithKeyValuesArray:_body][0];
    
    return item.bodyHeight * 2 + 110;
    
}

@end
