//
//  LBLiveViewCell.m
//  Bili
//
//  Created by 林彬 on 16/4/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBLiveViewCell.h"
#import "LBRoomCollectionCell.h"
#import "LBLiveItem.h"      // cell模型
#import "LBRoomItem.h"
#import "LBLiveButton.h"
#import "LBRoomCollectionView.h"

#import "GLLiveRoomViewController.h" //直播房间

#import "GLCellMidView.h"

@interface LBLiveViewCell()<UICollectionViewDataSource,UICollectionViewDelegate>

// 创建UICollectionView全局成员变量
@property(nonatomic , strong)UICollectionView *collectionV;

@property (weak, nonatomic) IBOutlet UIButton *titleButton;

@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIView *middleView;

@property (weak, nonatomic) GLCellMidView *cellmidView;

@property (nonatomic ,strong)NSMutableArray <LBRoomItem *>*tempArr;
@property (nonatomic ,strong)NSMutableArray <LBRoomItem *>*randomArr;
@end

@implementation LBLiveViewCell

static NSString * const ID = @"LBRoomCollectionCell";



// 确定collectionView有多少列
//static NSInteger const cols = 2;

- (void)setCellItem:(LBLiveItem *)cellItem
{
    _cellItem = cellItem;
    [self setUpMiddleView];
 
}

- (void)setUpCellData
{
    NSString *name = self.cellItem.partition[@"name"];
    [self.titleButton setTitle:name forState:UIControlStateNormal];
    NSString *iconURL = self.cellItem.partition[@"sub_icon"][@"src"];
    NSData *iconData = [NSData dataWithContentsOfURL:[NSURL URLWithString:iconURL]];
    UIImage *icon = [[UIImage imageWithData:iconData] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 裁剪图片
    UIImage *newIcon = [UIImage originImage:icon scaleToSize:CGSizeMake(20, 20)];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.titleButton setImage:newIcon forState:UIControlStateNormal];
        [self.titleButton setImage:newIcon forState:UIControlStateHighlighted];
    });
}

- (void)awakeFromNib {
    
}

- (void)setUpMiddleView
{
    self.middleView.glh_height = (self.itemH + 10) * 2;
    
    // 新建collectionView
    LBRoomCollectionView *collectionV = [[LBRoomCollectionView alloc]initWithItem:self.itemW :self.itemH];
    collectionV.frame = self.middleView.bounds;

    self.collectionV = collectionV;
    
    // 让View的中视图是collectionView

    collectionV.dataSource = self;
    collectionV.delegate = self;
    
    // 注册cell
    [collectionV registerNib:[UINib nibWithNibName:@"LBRoomCollectionCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    if (self.middleView.subviews) {
        for (UIView *view in self.middleView.subviews) {
            [view removeFromSuperview];
        }
    }
        [self.middleView addSubview:collectionV];

}

// 多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.roomItemArr.count >=4 ? 4 :self.roomItemArr.count;
}

// cell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LBRoomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.roomItem = self.roomItemArr[indexPath.row];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [cell setData];
    });
    
    return cell;
}

#pragma mark - 点击cell跳转LiveRoom
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 跳转到GLLiveRoomViewController并传递模型数据
    LBRoomItem *roomItem = self.roomItemArr[indexPath.row];
    
    self.didSelectLiveRoom(roomItem);
    // 跳转控制器
    
    //    GLLiveRoomViewController *liveRoomVC = [[GLLiveRoomViewController alloc]init];
    //    self.nav
    
    //    NSLog(@"%@",indexPath);
}

//- (void)setUpCellMidView
//{
//    GLCellMidView *cellmidView = [[NSBundle mainBundle]loadNibNamed:@"GLCellMidView" owner:nil options:nil][0];
//    cellmidView.backgroundColor = [UIColor purpleColor];
//    self.cellmidView = cellmidView;
//    if (self.middleView.subviews) {
//        for (UIView *view in self.middleView.subviews) {
//            [view removeFromSuperview];
//        }
//    }
//    [self.middleView addSubview:cellmidView];
//}
//
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    self.cellmidView.glw_width = self.middleView.glw_width;
//    self.cellmidView.glh_height = self.middleView.glh_height;
//}

- (IBAction)refresh {
    /**
     *  刷新
     */
    
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
}

@end
