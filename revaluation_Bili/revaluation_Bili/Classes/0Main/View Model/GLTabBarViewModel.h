//
//  GLTabBarViewModel.h
//  revaluation_Bili
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GLTabBarViewModel : NSObject

+ (void)setUpAllChildVC:(void(^)(UIViewController *ViewController))complete;

+ (instancetype)ViewModel;

+ (void)setupTabBarItem:(UITabBarItem *)item;

+ (void)setUpButtons:(NSUInteger)index :(UINavigationController *)nav;

@end
