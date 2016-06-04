//
//  LBDarmaViewController.m
//  Bili
//
//  Created by 林彬 on 16/3/31.
//  Copyright © 2016年 gl. All rights reserved.
//


// 番剧
#import "LBDarmaViewController.h"
#import "LBDarmaViewModel.h"
//#import "LBHttpTool.h"

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

#warning not finsh Network
-(void)getNetData{
    
   
    
//    [LBHttpTool getDarmaBottomNetDataSuccess:^(NSDictionary *responseObj) {
//        _bottomCellArr = [LBDarmaBottomModel mj_objectArrayWithKeyValuesArray:responseObj[@"result"]];
//        // 刷新数据
//        [self.tableView reloadData];
//        
//    } failure:^(NSError *error) {
//        NSLog(@"网络响应失败");
//    }];
//
//    
//    
//    [LBHttpTool getDarmaOtherNetDataSuccess:^(NSDictionary *responseObj) {
//        _banners = [LBDarmaBanaerModel mj_objectArrayWithKeyValuesArray:responseObj[@"result"][@"banners"]];
//        
//        _ends = [LBDarmaEndsModel mj_objectArrayWithKeyValuesArray:responseObj[@"result"][@"ends"]];
//        
//        _latestUpdate = [LBDarmaLatestUpdateModel mj_objectArrayWithKeyValuesArray:responseObj[@"result"][@"latestUpdate"][@"list"]];
//        
//        // 刷新数据
//        [self.tableView reloadData];
//
//    } failure:^(NSError *error) {
//        NSLog(@"网络响应失败");
//    }];
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
