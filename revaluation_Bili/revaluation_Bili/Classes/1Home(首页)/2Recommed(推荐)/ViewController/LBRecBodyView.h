//
//  LBRecBodyView.h
//  Bili
//
//  Created by 林彬 on 16/5/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LBBodyModel;
@interface LBRecBodyView : UIView

@property(nonatomic , strong)LBBodyModel *bodyItem;

+(instancetype)LBRecBodyViewFromNib;
@end
