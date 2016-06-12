//
//  WYLMineViewController.m
//  Bili
//
//  Created by 王亚龙 on 16/4/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "GLMineViewController.h"
#import "GLMineItem.h"
#import "WYLSettingViewController.h"
#import "WYLPrivateViewController.h"


@interface GLMineViewController ()
/** 模型*/
@property (nonatomic ,strong) GLMineItem *item;
@property (weak, nonatomic) IBOutlet UILabel *unameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
/** 如果是vip,这个cell就需要隐藏*/
@property (weak, nonatomic) IBOutlet UITableViewCell *vipCell;

@end

@implementation GLMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    //设置组间距
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0;
    
    //内边距
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    //请求数据
    [self loadData];
    
}

#pragma mark - 数据
-(void)loadData
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr GET:@"http://account.bilibili.com/api/myinfo?_device=iphone&_hwid=4dc791b793a01fe3&_ulv=5000&access_key=fff31e88a011097d502f65c403a36bac&appkey=27eb53fc9058f8c3&appver=3110&build=3110&platform=ios&type=json&sign=8928a84707b9228981d96d67f9965737" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/apple/Desktop/mine.plist" atomically:YES];
        
//        字典转模型
        self.item = [GLMineItem yy_modelWithJSON:responseObject];
//        设置数据
        
        [self.faceImageView sd_setImageWithURL:[NSURL URLWithString:self.item.face] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        self.unameLabel.text = self.item.uname;
        
        //刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    } ];
}

#pragma mark - 代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转个人界面
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"WYLPrivateViewController" bundle:nil];
        WYLPrivateViewController *privateVc = [storyboard instantiateInitialViewController];
        [self.navigationController pushViewController:privateVc animated:YES];
    }
    
    //跳转设置界面
    if (indexPath.section == 3 && indexPath.row == 5) {
        WYLSettingViewController *settingVc = [[WYLSettingViewController alloc] init];
        [self.navigationController pushViewController:settingVc animated:YES];
    }
}



@end
