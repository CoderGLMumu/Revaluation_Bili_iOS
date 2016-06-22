//
//  LBHeaderView.m
//  Bili
//
//  Created by 林彬 on 16/4/14.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBHeaderView.h"
#import "LBEntranceButton.h"
#import "LBEntranceButtonItem.h"
#import "LBLiveBannerItem.h"
#import "LBScrollingView.h"
#import "LBLiveViewModel.h"

#import <SDCycleScrollView/SDCycleScrollView.h>

@interface LBHeaderView() <SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *middleView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleViewH;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (nonatomic , strong)NSMutableArray *buttonArr;

@property (nonatomic , strong)NSMutableArray *imageArr;

@end

@implementation LBHeaderView

#pragma mark -  提供类方法

+(instancetype)headerViewFromNib
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"LBHeaderView" owner:self options:nil] lastObject];
}

#pragma mark -  懒加载
-(NSMutableArray *)buttonArr
{
    if (_buttonArr == nil) {
        NSMutableArray *buttonArr = [[NSMutableArray alloc] init];
        NSInteger count = self.viewModel.entranceButtomItems.count;
        for (int i = 0; i < count; i ++) {
            LBEntranceButton *enbutton = [[LBEntranceButton alloc] init];
            enbutton.buttonItem = _entranceButtomItems[i];
//            enbutton.tag = i;
            enbutton.tag = self.entranceButtomItems[i].ID.intValue;
            [enbutton addTarget:self action:@selector(enbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [buttonArr addObject:enbutton];
        }
        LBEntranceButton *enbutton = [[LBEntranceButton alloc] init];
        [enbutton setTitle:@"全部直播" forState:UIControlStateNormal];
        [enbutton setImage:[UIImage imageNamed:@"hd_home_region_icon_11"] forState:UIControlStateNormal];
        [enbutton addTarget:self action:@selector(enbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonArr addObject:enbutton];
        _buttonArr = buttonArr;
    }
    return _buttonArr;
}

-(NSMutableArray *)imageArr
{
    if (_imageArr == nil) {
        NSMutableArray *imageArr = [[NSMutableArray alloc] init];
        for (LBLiveBannerItem *item in self.headerBannerArr) {
            NSURL *url = [NSURL URLWithString:item.img];
            [imageArr addObject:url];
        }
        _imageArr = imageArr;
    }
    return _imageArr;
}

-(void)awakeFromNib
{
   
}

#pragma mark -  两个模型数组的set方法
-(void)setEntranceButtomItems:(NSArray<LBEntranceButtonItem *> *)entranceButtomItems
{
    _entranceButtomItems = entranceButtomItems;
    [self setUpButtons];
}

-(void)setHeaderBannerArr:(NSArray *)headerBannerArr{
    _headerBannerArr = headerBannerArr;
    [self setUpScrollView];
}

#pragma mark -  设置topView的图片滚动
-(void)setUpScrollView
{
    // 640 * 220
//     LBScrollingView *scrollingView = [[LBScrollingView alloc] init];
//    scrollingView.images = self.imageArr;
////    scrollingView.frame = CGRectMake(0, 0, self.topView.frame.size.width, ScreenW * 200 / 640);
//    scrollingView.frame = self.topView.bounds;
//    [self layoutIfNeeded];
//    [self.topView addSubview:scrollingView];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//    });
    
//    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.topView.bounds delegate:self placeholderImage:nil];
//    cycleScrollView.imageURLStringsGroup = self.imageArr;
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:self.topView.bounds delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.currentPageDotColor = GLColor(255, 30, 175);
    cycleScrollView2.pageDotColor = GLColor(255, 255, 255);
    // 自定义分页控件小圆标颜色
    [self.topView addSubview:cycleScrollView2];
    
    cycleScrollView2.imageURLStringsGroup = self.imageArr;
    
}

#pragma mark -  设置按钮
- (void)setUpButtons
{
    for (LBEntranceButton *button in self.buttonArr) {
        
        [self.middleView addSubview:button];
        
    }
    [self layoutIfNeeded];
    dispatch_async(dispatch_get_main_queue(), ^{
        
       
    });
}

- (void)enbuttonClick:(LBEntranceButton *)enbutton
{
    if ([self.delegate respondsToSelector:@selector(middleButtonsDidClick:ClickBtnID:ButtonItem:)] ) {
        [self.delegate middleButtonsDidClick:enbutton ClickBtnID:enbutton.buttonItem.ID.intValue ButtonItem:enbutton.buttonItem];
    }
}

#pragma mark -  设置frame
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imageH = GLScreenW * 200 / 640;
    self.topView.frame = CGRectMake(0, 0, GLScreenW, imageH);
    
    CGFloat buttonW = 60;
    CGFloat buttonH = buttonW;
    // 列
    NSInteger col = 4;
    // 列间距
    NSInteger colSpace = ( GLScreenW - buttonW * 4 ) / ( col + 1 );
    // 行间距
    NSInteger rowSpace = 15;
    // 动态计算中间view的高度
    CGFloat middleVH = rowSpace * 3 + buttonH * 2;
    self.middleView.frame = CGRectMake(0, imageH + 10, GLScreenW, middleVH);
    
    self.bottomView.gly_y = CGRectGetMaxY(self.middleView.frame) + 10;
    
    for (int i = 0; i < self.buttonArr.count; ++i) {
        LBEntranceButton *button = self.buttonArr[i];
        CGFloat buttonX = i % col * buttonW + (i % col + 1) * colSpace;
        CGFloat buttonY = i / col * buttonH + (i / col + 1) * rowSpace;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
    
    CGFloat headerViewHeight =  GLScreenW * 200 / 640 + self.middleViewH.constant + 75;
    
    self.frame = CGRectMake(0, 0, GLScreenW, headerViewHeight);
}

- (IBAction)RegardUp:(UIButton *)sender {
    if (self.ClickRegardUpButton) {
        self.ClickRegardUpButton();
    }
}



@end
