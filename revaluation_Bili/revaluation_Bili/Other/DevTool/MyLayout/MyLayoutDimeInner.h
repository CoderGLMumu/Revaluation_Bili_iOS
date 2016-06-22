//
//  MyLayoutDimeInner.h
//  MyLayout
//
//  Created by apple on 15/6/14.
//  Copyright (c) 2015年 欧阳大哥. All rights reserved.
//

#import "MyLayoutDime.h"


//尺寸对象内部定义
@interface MyLayoutDime()

@property(nonatomic, weak) UIView *view;
@property(nonatomic, assign) MyMarginGravity dime;

@property(nonatomic, assign) MyLayoutValueType dimeValType;

@property(nonatomic, readonly, strong) NSNumber *dimeNumVal;
@property(nonatomic, readonly, strong) NSArray *dimeArrVal;
@property(nonatomic, readonly, strong) MyLayoutDime *dimeRelaVal;


//是否跟父视图相关
@property(nonatomic, readonly,assign) BOOL isMatchParent;

-(BOOL)isMatchView:(UIView*)v;

//只有为数值时才有意义。
@property(nonatomic, readonly, assign) CGFloat measure;

//有效的尺寸， 有效的尺寸取值 minVal <= measure <= maxVal
-(CGFloat)validMeasure:(CGFloat)measure;


@end
