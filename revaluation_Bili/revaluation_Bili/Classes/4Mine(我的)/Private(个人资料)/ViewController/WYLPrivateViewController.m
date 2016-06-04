//
//  WYLPrivateViewController.m
//  Bili
//
//  Created by 王亚龙 on 16/4/22.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLPrivateViewController.h"

@interface WYLPrivateViewController ()

@end

@implementation WYLPrivateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 10;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}

@end