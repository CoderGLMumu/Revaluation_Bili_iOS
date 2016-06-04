//
//  LBLiveBodyView.h
//  Bili
//
//  Created by 林彬 on 16/5/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LBBodyModel;
@interface LBLiveBodyView : UIView
@property(nonatomic , strong)LBBodyModel *bodyItem;
+(instancetype)LBLiveBodyViewFromNib;
@end
