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

#import "GLDarmaHeaderView.h"
#import "LBLatestUpdateCell.h"
#import "LBEndsCell.h"
#import "LBBottomCell.h"

#import "GLFMDBToolSDK.h"

@interface LBDarmaViewController ()
/** FMDBTool */
@property (nonatomic, strong) GLFMDBToolSDK *FMDBTool;

// 保存底部cell的模型数组
@property (nonatomic ,strong)NSMutableArray *bottomCellArr;

// 滚动条的模型数组
@property (nonatomic ,strong)NSMutableArray *banners;
// row1完结动画的模型数组
@property (nonatomic ,strong)NSMutableArray *ends;
// row0新番连载的模型数组
@property (nonatomic ,strong)NSMutableArray *latestUpdate;

/** bannerImages */
@property (nonatomic, strong) NSArray *bannerImages;
/** bannerLinks */
@property (nonatomic, strong) NSArray *bannerLinks;

@end

@implementation LBDarmaViewController

- (GLFMDBToolSDK *)FMDBTool
{
    if (_FMDBTool == nil) {
        _FMDBTool = [GLFMDBToolSDK shareToolsWithCreateDDL:nil];
    }
    return _FMDBTool;
}

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

    // 读取缓存数据
    [self loadPhoneDataSourceToComplete:^{
        /** 设置头部视图 */
        [self setUpheaderView];
        [self.tableView reloadData];
    }];
    
    // 获取网络数据
    [self getNetData];
    
    // 去掉Cell的间隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = LBGlobeColor;
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LBBottomCell" bundle:nil] forCellReuseIdentifier:Darma];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    [self.tableView reloadData];
}

#pragma mark - 处理数据库缓存- -【查询】
- (void)loadPhoneDataSourceToComplete:(void (^)())complete
{
    // 传入DDL 创建表打开数据库
    self.FMDBTool = [GLFMDBToolSDK shareToolsWithCreateDDL:nil];
    
    // 查询数据【LBDarmaBottomModel】
    NSString *query_sql = @"select * from t_LBDarmaBottomModel";
    
    FMResultSet *result = [self.FMDBTool queryWithSql:query_sql];
    
    NSMutableArray * LBDarmaBottomModels = [NSMutableArray array];
    while ([result next]) { // next方法返回yes代表有数据可取
        LBDarmaBottomModel *model = [LBDarmaBottomModel new];
        model.cover = [result stringForColumn:@"cover"];
        model.desc = [result stringForColumn:@"desc"];
        model.link = [result stringForColumn:@"link"];
        model.title = [result stringForColumn:@"title"];
        [LBDarmaBottomModels addObject:model];
    }

    self.bottomCellArr = LBDarmaBottomModels;
    
    // 查询数据【LBDarmaBanaerModel】
    query_sql = @"select * from t_LBDarmaBanaerModel";
    
    result = [self.FMDBTool queryWithSql:query_sql];
    
    NSMutableArray * LBDarmaBanaerModels = [NSMutableArray array];
    while ([result next]) { // next方法返回yes代表有数据可取
        LBDarmaBanaerModel *model = [LBDarmaBanaerModel new];
        model.img = [result stringForColumn:@"img"];
        model.link = [result stringForColumn:@"link"];
        model.title = [result stringForColumn:@"title"];
        [LBDarmaBanaerModels addObject:model];
    }
    self.banners = LBDarmaBanaerModels;
    
    /** 给banner提供数据 */
    [self loadBannerData];
    
    // 查询数据【LBDarmaEndsModel】
    query_sql = @"select * from t_LBDarmaEndsModel";
    
    result = [self.FMDBTool queryWithSql:query_sql];
    
    NSMutableArray * LBDarmaEndsModels = [NSMutableArray array];
    while ([result next]) { // next方法返回yes代表有数据可取
        LBDarmaEndsModel *model = [LBDarmaEndsModel new];
        model.cover = [result stringForColumn:@"cover"];
        model.last_time = [result stringForColumn:@"desc"];
        model.newest_ep_id = [result stringForColumn:@"link"];
        model.newest_ep_index = [result stringForColumn:@"cover"];
        model.season_id = [result stringForColumn:@"desc"];
        model.title = [result stringForColumn:@"link"];
        model.total_count = [result stringForColumn:@"cover"];
        model.watchingCount = [result stringForColumn:@"desc"];
        [LBDarmaEndsModels addObject:model];
    }
    self.ends = LBDarmaEndsModels;
    
    // 查询数据【LBDarmaLatestUpdateModel】
    query_sql = @"select * from t_LBDarmaLatestUpdateModel";
    
    result = [self.FMDBTool queryWithSql:query_sql];
    
    NSMutableArray * LBDarmaLatestUpdateModels = [NSMutableArray array];
    while ([result next]) { // next方法返回yes代表有数据可取
        LBDarmaLatestUpdateModel *model = [LBDarmaLatestUpdateModel new];
        model.cover = [result stringForColumn:@"cover"];
        model.last_time = [result stringForColumn:@"desc"];
        model.newest_ep_id = [result stringForColumn:@"link"];
        model.newest_ep_index = [result stringForColumn:@"cover"];
        model.season_id = [result stringForColumn:@"desc"];
        model.title = [result stringForColumn:@"link"];
        model.total_count = [result stringForColumn:@"cover"];
        model.watchingCount = [result stringForColumn:@"desc"];
        [LBDarmaLatestUpdateModels addObject:model];
    }
    self.latestUpdate = LBDarmaLatestUpdateModels;
    
    
    // 查询数据【LBDarmaLatestUpdateModel】
    query_sql = @"select * from t_LBDarmaLatestUpdateModel";
    
    result = [self.FMDBTool queryWithSql:query_sql];
    
    if (self.bottomCellArr.count) {
        complete();
    }
}

#pragma mark - 处理网络请求数据
-(void)getNetData{
    
    NSString *btn_url = @"http://bangumi.bilibili.com/api/bangumi_recommend?access_key=bf427204b6ae8b8dfe51e6c99273189b&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3220&cursor=0&device=phone&pagesize=10&platform=ios&sign=184fbd3bc1f60de9f169ef1f31f6dc5b&ts=1463483273";
    
    [HttpToolSDK getWithURL:btn_url parameters:nil success:^(id json) {
        if (json) {
            self.bottomCellArr = [LBDarmaBottomModel mj_objectArrayWithKeyValuesArray:json[@"result"]];
            
            /** FMDB缓存 */
            if (self.bottomCellArr.count) {
                NSString *delete_sql = @"delete from t_LBDarmaBottomModel";
                [self.FMDBTool deleteWithSql:delete_sql];
                for (LBDarmaBottomModel *model in self.bottomCellArr) {
                    NSString *insert_sql = [NSString stringWithFormat:@"insert into t_LBDarmaBottomModel (cover,desc,link,title) values('%@','%@','%@','%@');",model.cover,model.desc,model.link,model.title];
                    [self.FMDBTool insertWithSql:insert_sql, nil];
                }
            }
            // 刷新数据
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"网络不好"];
    }];
    
    NSString *other_url = @"http://bangumi.bilibili.com/api/app_index_page_v2?access_key=bf427204b6ae8b8dfe51e6c99273189b&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3220&device=phone&platform=ios&sign=cbcc9ba78250d034eefb0f088f5faf96&ts=1463483417";
    
    [HttpToolSDK getWithURL:other_url parameters:nil success:^(id json) {
        self.banners = [LBDarmaBanaerModel mj_objectArrayWithKeyValuesArray:json[@"result"][@"banners"]];
        
        /** FMDB缓存 */
        if (self.banners.count) {
            NSString *delete_sql = @"delete from t_LBDarmaBanaerModel";
            [self.FMDBTool deleteWithSql:delete_sql];
            for (LBDarmaBanaerModel *model in self.banners) {
                NSString *insert_sql = [NSString stringWithFormat:@"insert into t_LBDarmaBanaerModel (img,link,title) values('%@','%@','%@');",model.img,model.link,model.title];
                [self.FMDBTool insertWithSql:insert_sql, nil];
            }
        }

        self.ends = [LBDarmaEndsModel mj_objectArrayWithKeyValuesArray:json[@"result"][@"ends"]];
        
        /** FMDB缓存 */
        if (self.ends.count) {
            NSString *delete_sql = @"delete from t_LBDarmaBottomModel";
            [self.FMDBTool deleteWithSql:delete_sql];

            for (LBDarmaEndsModel *model in self.ends) {
                NSString *insert_sql = [NSString stringWithFormat:@"insert into t_LBDarmaEndsModel (cover,last_time,newest_ep_id,newest_ep_index,season_id,title,total_count,watchingCount) values('%@','%@','%@','%@','%@','%@','%@','%@');",model.cover,model.last_time,model.newest_ep_id,model.newest_ep_index,model.season_id,model.title,model.total_count,model.watchingCount];
                [self.FMDBTool insertWithSql:insert_sql, nil];
            }
        }
        
        self.latestUpdate = [LBDarmaLatestUpdateModel mj_objectArrayWithKeyValuesArray:json[@"result"][@"latestUpdate"][@"list"]];
        
        /** FMDB缓存 */
        if (self.latestUpdate.count) {
            NSString *delete_sql = @"delete from t_LBDarmaLatestUpdateModel";
            [self.FMDBTool deleteWithSql:delete_sql];
            
            for (LBDarmaLatestUpdateModel *model in self.latestUpdate) {
                NSString *insert_sql = [NSString stringWithFormat:@"insert into t_LBDarmaLatestUpdateModel (cover,last_time,newest_ep_id,newest_ep_index,season_id,title,total_count,watchingCount) values('%@','%@','%@','%@','%@','%@','%@','%@');",model.cover,model.last_time,model.newest_ep_id,model.newest_ep_index,model.season_id,model.title,model.total_count,model.watchingCount];
                [self.FMDBTool insertWithSql:insert_sql, nil];
            }
        }

        /** 给banner提供数据 */
        [self loadBannerData];
        
        /** 设置头部视图 */
        [self setUpheaderView];
        // 刷新数据
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"网络不好"];
    }];
}

- (void)loadBannerData
{
    /** 给banner提供数据 */
    NSMutableArray *arrM_img = [NSMutableArray array];
    NSMutableArray *arrM_link = [NSMutableArray array];
    for (LBDarmaBanaerModel *model in self.banners) {
        if (model.img) {
            [arrM_img addObject:model.img];
        }
        if (model.link) {
            [arrM_link addObject:model.link];
        }
    }
    self.bannerImages = arrM_img;
    self.bannerLinks = arrM_link;
}

- (void)setUpheaderView
{
    GLDarmaHeaderView *headerView = [GLDarmaHeaderView darmaHeaderView];
    self.tableView.tableHeaderView = headerView;
    // 网络加载 --- 创建带标题的图片轮播器
    if (self.bannerImages) {
        headerView.bannerImages = self.bannerImages;
    }
    
    headerView.ClickBanner = ^(NSInteger currentIndex){
        NSString *link = self.bannerLinks[currentIndex];
        if([link hasPrefix:@"http://"]){
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:link]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
            }
        }
    };
    
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
        if (self.latestUpdate.count == 0) {
            return 0;
        }
        return [self.latestUpdate[0] cellHeight];
    }else if (indexPath.row == 1){
        if (self.ends.count == 0) {
            return 0;
        }
        return [self.ends[0] cellHeight];
    }
    else {
        return [self.bottomCellArr[0] cellHeight];
    }
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

@end
