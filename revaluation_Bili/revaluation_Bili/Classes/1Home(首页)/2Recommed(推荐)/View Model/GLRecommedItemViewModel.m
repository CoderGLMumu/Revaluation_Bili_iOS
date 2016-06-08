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
        
        // 设置vm与model的相互关系.
        [RACObserve(model, head) subscribeNext:^(NSDictionary *head) {
            self.title = head[@"title"];
        }];
        
        [RACObserve(model, type) subscribeNext:^(NSString *type) {
            self.type = type;
        }];
        
        [RACObserve(model, body) subscribeNext:^(NSArray *body) {
            self.body = body;
        }];
    }
    
    return self;
}

- (CGFloat)cellHeight
{
    // 如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    
    if (_type == nil || [_type isEqualToString:@"weblink"]) return (GLScreenW - 20) * 211 / 714 + 30;
    
    //    GLBodyModel *item = [NSArray yy_modelArrayWithClass:[GLBodyModel class] json:self.body][0];
    
    CGFloat bodyHeight = ((GLScreenW - 30) * 0.5) * 128/ 234 + 60;
    return bodyHeight * 2 + 110;
   
}

@end
