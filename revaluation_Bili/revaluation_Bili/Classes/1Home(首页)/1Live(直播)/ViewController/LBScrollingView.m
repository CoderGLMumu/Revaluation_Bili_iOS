//
//  scrollingView.m
//  scrollingImage
//
//  Created by 林彬 on 16/4/22.
//  Copyright © 2016年 linbin. All rights reserved.
//

#import "LBScrollingView.h"

#pragma mark -  LBImageCell
@interface LBImageCell : UICollectionViewCell
@property (weak, nonatomic) UIImageView *imageView;

@end

@implementation LBImageCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        [self.contentView addSubview:imageView];
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}
@end

#pragma mark -  scrollingView
@interface LBScrollingView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic , weak)UICollectionView *collectionV;
@property(nonatomic ,weak)NSTimer *timer;
@end

@implementation LBScrollingView
/** 注册的cell */
static NSString * const ID = @"LBImageCell";
/** item的个数 */
static NSInteger const itemCount = 20;

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc] init];
        flowL.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 170);
        // 水平滚动
        flowL.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 如果是水平滚动,那么是设置minimumLineSpacing来使得item之间没有间距.
        // 如果是垂直滚动,那么是设置minimumInteritemSpacing来设置列之间的间距
        flowL.minimumLineSpacing = 0;
        
        UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 170) collectionViewLayout:flowL];
        
        collectionV.pagingEnabled = YES;
        collectionV.showsHorizontalScrollIndicator = NO;
        collectionV.showsVerticalScrollIndicator = NO;
        
        // 设置数据源和代理
        collectionV.dataSource = self;
        collectionV.delegate = self;
        _collectionV = collectionV;
        [self addSubview: collectionV];
        
        // 注册cell
        [collectionV registerClass:[LBImageCell class] forCellWithReuseIdentifier:ID];
        // 默认属性值
        _placeholderImage = [UIImage imageNamed:@"LBScrollingView.bundle/placeholderImage1"];

        
    }
    return self;
}

-(void)setImages:(NSArray *)images
{
    _images = images;
    
    // 如果就一张图片,不让滚动
    _collectionV.scrollEnabled = (self.images.count != 1);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 一开始默认滚到中间的item
        [self.collectionV scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(itemCount * self.images.count / 2) inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    });
    
    // 如果传进来的只有一张图片,不让它开启定时器
    // 开启定时器
    if (images.count != 1) [self startTimer];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionV.frame = self.bounds;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionV.collectionViewLayout;
    layout.itemSize = self.bounds.size;
}

- (void)startTimer
{
    if (self.images.count == 1) return;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(scrollingImage) userInfo:nil repeats:YES];
    _timer = timer;
    // 把定时器添加到当前的RunLoop
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}


- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark -  翻页
- (void)scrollingImage
{
    CGPoint offset = self.collectionV.contentOffset;
    offset.x += self.collectionV.frame.size.width;
    [self.collectionV setContentOffset:offset animated:YES];
}

#pragma mark -  重置cell的位置
- (void)resetPosition
{
    // 跳转到距离中间位置最近的相同图片
    // 原理是触发这方法的时候,跳转到离25最近的和当前显示相同数据的cell
    NSInteger oldItem = self.collectionV.contentOffset.x / self.collectionV.frame.size.width;
    NSInteger newItem = (itemCount * self.images.count/ 2 )+ (oldItem % self.images.count);
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:newItem inSection:0];
    [self.collectionV scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];  // 不要加上动画
}

#pragma mark -  数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    return self.imageArr.count;
    return itemCount * self.images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LBImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    id data = self.images[indexPath.item % self.images.count];
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
    if ([data isKindOfClass:[UIImage class]]) {
        cell.imageView.image = data;
    } else if ([data isKindOfClass:[NSURL class]]) {
        [cell.imageView sd_setImageWithURL:data placeholderImage:self.placeholderImage];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(infiniteScrollView:didClickImageAtIndex:)]) {
        [self.delegate infiniteScrollView:self didClickImageAtIndex:indexPath.item % self.images.count];
    }
}


/**
 *  当人为拖拽结束的时候,开启计时器
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    [self startTimer];
}

/**
 *  当人为开始拖拽的时候,停止计时
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

/**
 *  scrollView滚动完毕的时候调用（通过setContentOffset:animated:滚动）
 */
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 切换下一页
    [self resetPosition];
}

/**
 *  scrollView滚动完毕的时候调用（人为拖拽滚动）
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 切换下一页
    [self resetPosition];
}

@end
