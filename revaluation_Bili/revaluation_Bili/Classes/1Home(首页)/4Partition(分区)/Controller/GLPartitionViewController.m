//
//  GLPartitionViewController.m
//  Bili
//
//  Created by mac on 16/4/23.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "GLPartitionViewController.h"
#import "GLHomeViewController.h"

#import "GLPartitionViewCell.h"

#import "GLPartitionItem.h"

@interface GLPartitionViewController ()

/** item */
@property (nonatomic, strong) NSMutableArray<GLPartitionItem *> *cellItem_arr;


@end

@implementation GLPartitionViewController

static NSString * const reuseIdentifier = @"partition";

static NSInteger margin = 30;

static NSInteger cols = 3;

#pragma mark - 懒加载
- (NSMutableArray *)ButtonItem_arr
{
    if (_cellItem_arr == nil) {
        _cellItem_arr= [NSMutableArray array];
    }
    return _cellItem_arr;
}

#pragma mark - 初始化cell布局样式
- (instancetype)init
{
    
    // 创建一个流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat itemW = (GLScreenW - margin * (cols - 1) - margin * 2) / cols;
    
    // 设置cell的尺寸
    layout.itemSize = CGSizeMake(itemW , itemW);
    
    // 设置滚动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // 行间距
//    layout.minimumLineSpacing = 10;
    
    // 设置cell之间的间距
//    layout.minimumInteritemSpacing = 10;

  // 组间距
    layout.sectionInset = UIEdgeInsetsMake(margin - 20, margin, margin - 20, margin);
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GLPartitionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self loadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.collectionView.backgroundColor = [UIColor colorWithRed:213 / 255.0 green:213 / 255.0 blue:213 / 255.0 alpha:1];
}

- (void)loadData
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Partition.plist" ofType:nil];
    NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:path];
    // 字典转模型
    self.cellItem_arr = (NSMutableArray *)[NSArray yy_modelArrayWithClass:[GLPartitionItem class] json:dataDict[@"data"]];
    [self.collectionView reloadData];
}

/*
- (void)setupData
{
    
    GLPartitionItem *item1 = [[GLPartitionItem alloc]init];
    item1.ID = @"1";
    item1.image = [UIImage imageNamed:@"hd_home_subregion_live"];
    item1.name_image = @"直播";
//    item1.Item_VC = ;
    
    GLPartitionItem *item2 = [[GLPartitionItem alloc]init];
    item2.ID = @"2";
    item2.image = [UIImage imageNamed:@"hd_home_region_icon_13"];
    item2.name_image = @"番剧";
    
    GLPartitionItem *item3 = [[GLPartitionItem alloc]init];
    item3.ID = @"3";
    item3.image = [UIImage imageNamed:@"hd_home_region_icon_1"];
    item3.name_image = @"动画";
    
    GLPartitionItem *item4 = [[GLPartitionItem alloc]init];
    item4.ID = @"4";
    item4.image = [UIImage imageNamed:@"hd_home_region_icon_3"];
    item4.name_image = @"音乐";
    
    GLPartitionItem *item5 = [[GLPartitionItem alloc]init];
    item5.ID = @"5";
    item5.image = [UIImage imageNamed:@"hd_home_region_icon_129"];
    item5.name_image = @"舞蹈";
    
    GLPartitionItem *item6 = [[GLPartitionItem alloc]init];
    item6.ID = @"6";
    item6.image = [UIImage imageNamed:@"hd_home_region_icon_4"];
    item6.name_image = @"游戏";
    
    GLPartitionItem *item7 = [[GLPartitionItem alloc]init];
    item7.ID = @"7";
    item7.image = [UIImage imageNamed:@"hd_home_region_icon_36"];
    item7.name_image = @"科技";
    
    GLPartitionItem *item8 = [[GLPartitionItem alloc]init];
    item8.ID = @"8";
    item8.image = [UIImage imageNamed:@"hd_home_region_icon_5"];
    item8.name_image = @"娱乐";
    
    GLPartitionItem *item9= [[GLPartitionItem alloc]init];
    item9.ID = @"9";
    item9.image = [UIImage imageNamed:@"hd_home_region_icon_119"];
    item9.name_image = @"鬼畜";
    
    GLPartitionItem *item10 = [[GLPartitionItem alloc]init];
    item10.ID = @"10";
    item10.image = [UIImage imageNamed:@"hd_home_region_icon_23"];
    item10.name_image = @"电影";
    
    GLPartitionItem *item11 = [[GLPartitionItem alloc]init];
    item11.ID = @"11";
    item11.image = [UIImage imageNamed:@"hd_home_region_icon_11"];
    item11.name_image = @"电视剧";
    
    GLPartitionItem *item12 = [[GLPartitionItem alloc]init];
    item12.ID = @"12";
    item12.image = [UIImage imageNamed:@"hd_home_region_icon_155"];
    item12.name_image = @"时尚";
    
    GLPartitionItem *item13 = [[GLPartitionItem alloc]init];
    item13.ID = @"13";
    item13.image = [UIImage imageNamed:@"hd_home_region_gamecenter"];
    item13.name_image = @"游戏中心";
    
    [self.ButtonItem_arr addObjectsFromArray:@[item1,item2,item3,item4,item5,item6,item7,item8,item9,item10,item11,item12,item13]];
    
}
 */


#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.ButtonItem_arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GLPartitionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.item = self.ButtonItem_arr[indexPath.item];
//    cell.backgroundColor = [UIColor purpleColor];
    return cell;
}


#pragma mark - collectionView代理【监听点击】
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GLPartitionItem *item = self.cellItem_arr[indexPath.row];
    
    if ([item.name isEqualToString:@"直播"]) {
//        NSLog(@"%@",self.parentViewController);
//        GLHomeViewController *homeVC = (GLHomeViewController *)self.parentViewController;
//        homeVC.mainSCV.contentOffset = CGPointMake(0, 0);
        self.ClickLiveButton();
    }
    
    
//    GLLog(@"跳转控制器%@",item.Item_VC);
}









/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
