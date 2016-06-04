
//
//  LBEndsCell.m
//  Bili
//
//  Created by 林彬 on 16/5/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBEndsCell.h"
#import "LBDarmaEndsModel.h"
#import "LBEndsCollectionViewCell.h"

@interface LBEndsCell()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *middleView;

@property (nonatomic ,strong)UICollectionView *collectionV;
@end

@implementation LBEndsCell

static NSString * const ID = @"LBEndsCollectionViewCell";

- (IBAction)btnClick:(id)sender {
    
//    NSLog(@"%@",self.models.season_id);
}

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModels:(NSMutableArray *)models{
    _models = models;
    [self setUpMiddleView];
}

- (void)setUpMiddleView{
    // 新建流水布局
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc] init];
    
    // 计算尺寸
    CGFloat itemW = GLScreenW / 3 ;
    CGFloat itemH = itemW * 4 / 3 + 45;
    
    // 设置尺寸
    flowL.itemSize = CGSizeMake(itemW, itemH);
    
    // 设置最小列间距和行间距
    flowL.minimumInteritemSpacing = 10;
    flowL.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    self.middleView.glh_height = itemH + 45;
    
    // 新建collectionView
    UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, GLScreenW - 20, self.middleView.glh_height) collectionViewLayout:flowL];
    
    collectionV.backgroundColor = [UIColor whiteColor];
    collectionV.scrollsToTop = NO;
    collectionV.showsVerticalScrollIndicator = NO;
    collectionV.bounces = NO;
    self.collectionV = collectionV;
    
    // 让View的中视图是collectionView
    
    collectionV.dataSource = self;
    //collectionV.delegate = self;
    
    // 注册cell
    [collectionV registerNib:[UINib nibWithNibName:@"LBEndsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    if (self.middleView.subviews) {
        for (UIView *view in self.middleView.subviews) {
            [view removeFromSuperview];
        }
    }
    [self.middleView addSubview:collectionV];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.glh_height = GLScreenW / 3 * 4 / 3 + 140;
}

// 多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.models.count;
}


// cell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LBEndsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.model = self.models[indexPath.item];
    
    return cell;
}



-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
}


@end
