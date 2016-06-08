//
//  GLLiveBodyView.h
//  revaluation_Bili
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLLiveBodyView : UIControl

+ (instancetype)GLLiveBodyViewFromNib;

/** body */
@property (nonatomic, strong) NSDictionary *body;

@end
