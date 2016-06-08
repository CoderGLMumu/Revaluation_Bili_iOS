//
//  GLRecommedCellItemViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLRecommedCellItemViewModel.h"
#import "GLRecommedCellModel.h"

#import "GLRecBodyView.h"
#import "GLBangumiBodyView.h"
#import "GLLiveBodyView.h"

@interface GLRecommedCellItemViewModel ()

@end

@implementation GLRecommedCellItemViewModel

- (instancetype)initWithModel:(GLRecommedCellModel *)model
{
    self = [super init];
    if (self) {
        // 设置vm与model的相互关系.
        [RACObserve(model, cover) subscribeNext:^(NSString *cover) {
            self.cover = cover;
        }];
        
        [RACObserve(model, danmaku) subscribeNext:^(NSString *danmaku) {
            self.danmaku = danmaku;
        }];
        [RACObserve(model, param) subscribeNext:^(NSString *param) {
            self.param = param;
        }];
        [RACObserve(model, play) subscribeNext:^(NSString *play) {
            self.play = play;
        }];
        [RACObserve(model, desc1) subscribeNext:^(NSString *desc1) {
            self.desc1 = desc1;
        }];
        [RACObserve(model, style) subscribeNext:^(NSString *style) {
            self.style = style;
        }];
        [RACObserve(model, up) subscribeNext:^(NSString *up) {
            self.up = up;
        }];
        [RACObserve(model, online) subscribeNext:^(NSString *online) {
            self.online = online;
        }];
        [RACObserve(model, height) subscribeNext:^(NSString *height) {
            self.height = height;
        }];
        [RACObserve(model, width) subscribeNext:^(NSString *width) {
            self.width = width;
        }];
        [RACObserve(model, title) subscribeNext:^(NSString *title) {
            self.title = title;
            [self setCellDate];
        }];
    }
    
    return self;
}

- (void)setCellDate
{
    if ([self.style isEqualToString:@"gm_av"]) {
        //recommend
    }else if([self.style isEqualToString:@"gm_live"]){
        
    }else if([self.style isEqualToString:@"gs_bangumi"]){
        
    }else if([self.style isEqualToString:@"gl_pic"]){
        
    }
    
}



@end
