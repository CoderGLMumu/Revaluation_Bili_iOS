//
//  GLVideoDownloadMViewController.m
//  revaluation_Bili
//
//  Created by mac on 16/7/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLVideoDownloadMViewController.h"

@interface GLVideoDownloadMViewController ()

@end

@implementation GLVideoDownloadMViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tabBarController.tabBar setHidden:YES];
    self.title = @"传过来aid";
    self.navigationItem.rightBarButtonItem.title = @"编辑";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBar.alpha = 1;
}



@end
