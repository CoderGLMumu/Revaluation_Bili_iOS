//
//  HMXFanJuDetailController.m
//  Bili
//
//  Created by hemengxiang on 16/4/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "HMXFanJuDetailController.h"
#import "HMXFanJuCollectionViewCell.h"
#import "HMXFanJuDetailHeaderView.h"
#import "GLMotiveSealCellItem.h"
#import "HMXFanjuCommetCell.h"
#define cellW (GLScreenW - (cols + 1) * collectionViewMargin) / cols
@interface HMXFanJuDetailController ()<UICollectionViewDataSource>

/** 头部视图 */
@property(weak,nonatomic)UIView *header;
/** collectionView */
@property(weak,nonatomic)UICollectionView *collectionView;
/** collectionView的高度 */
@property(nonatomic,assign)CGFloat collectionViewH;

@end

static NSString *const commentCellID = @"commentCell";
static NSString *const collectionCellID = @"collectionCell";

/** collectionView中cell的总列数 */
static CGFloat const cols = 4;
/** collectionView中cell的高度 */
static CGFloat const cellH = 40;
/** collectionView的X值 */
static CGFloat const collectionViewMargin = 15;
/** collectionView的Y值 */
static CGFloat const collectionViewY = 345;

@implementation HMXFanJuDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableView的分割线
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    //设置导航条
    [self setUpNavBar];
    
    //设置头部视图
    [self setUptableHeaderView];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HMXFanjuCommetCell class]) bundle:nil] forCellReuseIdentifier:commentCellID];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HMXFanJuCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:collectionCellID];
}



-(void)viewDidLayoutSubviews
{
    //布局collectionView
    CGFloat collectionViewW = GLScreenW - 2 * collectionViewMargin;
    CGFloat collectionViewH = self.collectionViewH;
    self.collectionView.frame = CGRectMake(collectionViewMargin,collectionViewY,collectionViewW,collectionViewH);
}


#pragma mark - 设置导航条

-(void)setUpNavBar
{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"番剧详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
}


#pragma mark - 添加HeaderView

-(void)setUptableHeaderView
{
    //header
    HMXFanJuDetailHeaderView *header = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HMXFanJuDetailHeaderView class]) owner:nil options:nil].firstObject ;
    //计算头部视图的高度
    //cell的总行数
    NSInteger rows = (self.motiveSealItem.total_count.integerValue - 1)/ cols + 1;
    CGFloat collectionViewH = rows * (collectionViewMargin + cellH);
    self.collectionViewH = collectionViewH;
    header.frame = CGRectMake(0, 0, 0, collectionViewY + collectionViewH);
    
    //禁止tableView的弹簧效果
    self.tableView.bounces = NO;
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(header.glh_height, 0, 0, 0);
    self.header = header;
    header.motiveSealItem = self.motiveSealItem;
    self.tableView.tableHeaderView = header;
    //隐藏tabBar
    self.tabBarController.tabBar.hidden = YES;
    
    //添加collectionView
    //创建和设置布局参数
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(cellW, cellH);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = collectionViewMargin;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    collectionView.dataSource = self;
    self.collectionView = collectionView;
    [self.header addSubview:collectionView];
}


#pragma mark - 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMXFanjuCommetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    
    return cell;
}


#pragma mark - CollectionView 数据源方法

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.motiveSealItem.total_count.integerValue;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HMXFanJuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - 代理方法

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //导航控制器的透明度随着偏移量Y值的增大而变得不透明
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //根据内容计算cell的高度
    return  200;
}


@end