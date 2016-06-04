//
//  GLNavigationViewModel.h
//  revaluation_Bili
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLNavigationViewModel : NSObject

+ (instancetype)viewModel;

- (void)setUpBackBtn:(void(^)(UIButton *backButton))complete;

@end
