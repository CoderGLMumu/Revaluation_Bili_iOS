//
//  GLPlaceholderView.h
//  revaluation_Bili
//
//  Created by mac on 16/5/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLPlaceholderView : UIView

+ (instancetype)sharePlaceholderView;

- (void)netWorkNotReachableisTimeOut:(BOOL)isTimeOut;

- (void)netWorkNotData;

@end
