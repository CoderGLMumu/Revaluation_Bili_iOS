//
//  GLRecommedCellViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLRecommedCellViewModel.h"

#import "GLRecommedCellModel.h"

#import "GLBodyModel.h"

#import "GLRecommedCellItemViewModel.h"

//#import "LBRecBodyView.h"
//#import "LBLiveBodyView.h"
//#import "LBBangumiBodyView.h"

@interface GLRecommedCellViewModel ()

@property (nonatomic , strong)NSArray *bodyArr;

@property(nonatomic , assign) CGFloat bodyHeight;

@end

@implementation GLRecommedCellViewModel

- (instancetype)init
{
    self = [self initWithModel: nil];
    
    return self;
}

- (instancetype)initWithModel:(GLRecommedCellModel *)model
{
    self = [super init];
    
    if (nil != self) {
        
        
//        [self setup];
    }
    
    return self;
}

- (void)setData:(GLRecommedCellModel *)model
{

}

- (void)setBody:(NSArray *)body
{
    _body = body;
    NSArray *cellModel = [NSArray yy_modelArrayWithClass:[GLRecommedCellModel class] json:body];
    
    NSMutableArray * cellbodyItemViewModels = [NSMutableArray array];
    
    RACSequence * cellItemViewModel = [cellModel.rac_sequence
                                       map:^(GLRecommedCellModel * model) {
                                           GLRecommedCellItemViewModel * vm = [[GLRecommedCellItemViewModel alloc] initWithModel: model];
                                           
                                           return vm;
                                       }];
    
    
    [cellbodyItemViewModels addObjectsFromArray: cellItemViewModel.array];
    
    self.cellbodyItemViewModels = cellbodyItemViewModels;
    
//    [self setData: cellModel];
}

- (void)gaolintest
{
    
}

@end
