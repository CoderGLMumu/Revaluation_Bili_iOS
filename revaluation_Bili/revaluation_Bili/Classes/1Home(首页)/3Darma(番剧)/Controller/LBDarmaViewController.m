//
//  LBDarmaViewController.m
//  Bili
//
//  Created by 林彬 on 16/3/31.
//  Copyright © 2016年 gl. All rights reserved.
//


// 番剧
#import "LBDarmaViewController.h"

#import "LBDarmaBottomModel.h"
#import "LBDarmaBanaerModel.h"
#import "LBDarmaEndsModel.h"
#import "LBDarmaLatestUpdateModel.h"

#import "LBLatestUpdateCell.h"
#import "LBEndsCell.h"
#import "LBBottomCell.h"

@interface LBDarmaViewController ()
// 保存底部cell的模型数组
@property (nonatomic ,strong)NSMutableArray *bottomCellArr;

// 滚动条的模型数组
@property (nonatomic ,strong)NSMutableArray *banners;
// row1完结动画的模型数组
@property (nonatomic ,strong)NSMutableArray *ends;
// row0新番连载的模型数组
@property (nonatomic ,strong)NSMutableArray *latestUpdate;
@end

@implementation LBDarmaViewController

static NSString * const Darma = @"LBDarmaCell";

-(NSMutableArray *)bottomCellArr
{
    if (_bottomCellArr == nil) {
        _bottomCellArr = [[NSMutableArray alloc] init];
    }
    return _bottomCellArr;
}

-(NSMutableArray *)banners
{
    if (_banners == nil) {
        _banners = [[NSMutableArray alloc] init];
    }
    return _banners;
}

-(NSMutableArray *)ends
{
    if (_ends == nil) {
        _ends = [[NSMutableArray alloc] init];
    }
    return _ends;
}

-(NSMutableArray *)latestUpdate{
    if (_latestUpdate == nil) {
        _latestUpdate = [[NSMutableArray alloc] init];
    }
    return _latestUpdate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取网络数据
    [self getNetData];
    // 去掉Cell的间隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = LBGlobeColor;
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LBBottomCell" bundle:nil] forCellReuseIdentifier:Darma];
}


-(void)getNetData{
    
    NSString *btn_url = @"http://bangumi.bilibili.com/api/bangumi_recommend?access_key=bf427204b6ae8b8dfe51e6c99273189b&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3220&cursor=0&device=phone&pagesize=10&platform=ios&sign=184fbd3bc1f60de9f169ef1f31f6dc5b&ts=1463483273";
    
    [HttpToolSDK getWithURL:btn_url parameters:nil success:^(id json) {
        if (json) {
            _bottomCellArr = [LBDarmaBottomModel mj_objectArrayWithKeyValuesArray:json[@"result"]];
            // 刷新数据
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"网络不好"];
    }];
    
    NSString *other_url = @"http://bangumi.bilibili.com/api/app_index_page_v2?access_key=bf427204b6ae8b8dfe51e6c99273189b&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3220&device=phone&platform=ios&sign=cbcc9ba78250d034eefb0f088f5faf96&ts=1463483417";
    
    [HttpToolSDK getWithURL:other_url parameters:nil success:^(id json) {
        _banners = [LBDarmaBanaerModel mj_objectArrayWithKeyValuesArray:json[@"result"][@"banners"]];
        
        _ends = [LBDarmaEndsModel mj_objectArrayWithKeyValuesArray:json[@"result"][@"ends"]];
        
        _latestUpdate = [LBDarmaLatestUpdateModel mj_objectArrayWithKeyValuesArray:json[@"result"][@"latestUpdate"][@"list"]];
        
        // 刷新数据
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"网络不好"];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.bottomCellArr.count + self.ends.count + self.latestUpdate.count - self.ends.count - self.latestUpdate.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        LBLatestUpdateCell *cell = [[NSBundle mainBundle] loadNibNamed:@"LBLatestUpdateCell" owner:self options:nil].lastObject;
        cell.models = self.latestUpdate;
        return cell;
    }else if (indexPath.row == 1) {
        LBEndsCell *cell = [[NSBundle mainBundle] loadNibNamed:@"LBEndsCell" owner:self options:nil].lastObject;
        cell.models = self.ends;
        return cell;
        
    
    }else{
//        LBEndsCell *cell = tableView.
        LBBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:Darma forIndexPath:indexPath];
        cell.model = self.bottomCellArr[indexPath.row - 2];
        return cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [self.latestUpdate[0] cellHeight];
    }else if (indexPath.row == 1){
        return [self.ends[0] cellHeight];
    }
    else {
        return [self.bottomCellArr[0] cellHeight];
    }
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

@end
