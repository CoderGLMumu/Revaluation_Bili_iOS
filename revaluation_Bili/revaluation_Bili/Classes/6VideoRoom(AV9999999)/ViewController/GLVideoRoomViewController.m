//
//  GLVideoRoomViewController.m
//  revaluation_Bili
//
//  Created by mac on 16/6/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLVideoRoomViewController.h"

@interface GLVideoRoomViewController ()

@end

@implementation GLVideoRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
