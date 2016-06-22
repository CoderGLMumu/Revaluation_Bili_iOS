//
//  WYLAuthorshipViewController.m
//  Bili
//
//  Created by 王亚龙 on 16/5/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLAuthorshipViewController.h"
#import "WYLAuthorViewController.h"
#import "WYLNewtieViewController.h"
#import "WYLNewSweetsopViewController.h"

@interface WYLAuthorshipViewController ()<UIScrollViewDelegate>
/** 标题的view*/
@property (nonatomic ,strong) UIView *titleView;
/** 选中按钮*/
@property (nonatomic ,weak) UIButton *selectButton;
/** 中间滚动内容的view*/
@property (nonatomic ,weak) UIScrollView *contentScrollView;
/** 标题按钮*/
@property (nonatomic ,strong) NSMutableArray *titleButtons;

@end

@implementation WYLAuthorshipViewController

/** 懒加载按钮数组*/
-(NSMutableArray *)titleButtons
{
    if (_titleButtons == nil) {
        _titleButtons = [NSMutableArray array];
    }
    
    return _titleButtons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加所有的子控制器
    [self setupAllChildViewController];
    
    // 添加标题vew
    [self setUpTitleView];
    
    //添加所有子控制器的view
    [self setUpAllChildView];
    
}

#pragma mark - 初始化
//添加所有子控制器的view
-(void)setUpAllChildView
{
    // 添加中间滚动的view
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    contentScrollView.frame = CGRectMake(0, self.titleView.glh_height + 20, GLScreenW, GLScreenH - self.titleView.glh_height - 20);
    [self.view addSubview:contentScrollView];
    self.contentScrollView = contentScrollView;
    
    // 添加子控制器的view
    NSInteger count = self.childViewControllers.count;
    for (int i = 0; i < count; i++) {
        
        UIViewController *tableVc = self.childViewControllers[i];
        CGFloat x = i * GLScreenW;
        // 设置vc的view的位置
        
        //不能用屏幕宽度?
        tableVc.view.frame = CGRectMake(x, 0, contentScrollView.bounds.size.width, contentScrollView.bounds.size.height);
        
        [contentScrollView addSubview:tableVc.view];
    }
    
    // 设置scrollView的属性
    contentScrollView.delegate = self;
    contentScrollView.contentSize = CGSizeMake(count * GLScreenW, 0);
    contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    
}

//添加所有的子控制器
-(void)setupAllChildViewController
{
    //原创
    WYLAuthorViewController *authorVc = [[WYLAuthorViewController alloc] init];
    authorVc.title = @"原创";
    [self addChildViewController:authorVc];
    
    
    //全站
    WYLNewtieViewController *newtieVc = [[WYLNewtieViewController alloc] init];
    newtieVc.title = @"全站";
    [self addChildViewController:newtieVc];
    
    //新番
    WYLNewSweetsopViewController *newSweepsopVc = [[WYLNewSweetsopViewController alloc] init];
    newSweepsopVc.title = @"新帖";
    [self addChildViewController:newSweepsopVc];
    
}

// 添加标题view
-(void)setUpTitleView
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, GLScreenW, 35)];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    // 设置所有的标题按钮
    [self setupAllTitleButton];
}

//设置所有的标题
- (void)setupAllTitleButton
{
    // 添加返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"icnav_back_dark"] forState:UIControlStateNormal];
    [backButton sizeToFit];
    CGFloat backButtonY = (self.titleView.glh_height - backButton.glh_height) * 0.5;
    backButton.frame = CGRectMake(10, backButtonY, 20, 20);
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:backButton];
    
    
    // 添加标题按钮
    NSInteger count = self.childViewControllers.count;
    CGFloat btnW = 70;
    CGFloat btnH = 35;
//    CGFloat btnX = self.titleView.size.width * 0.5- btnW * 2 - btnW * 0.5;
    CGFloat btnX = self.titleView.glw_width * 0.5- btnW * 2 - btnW * 0.5;
    CGFloat btnY = 0;
    
    for (int i = 0; i < count; i++) {
        // 创建按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btnX += btnW;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.titleView addSubview:btn];
        
        // 监听按钮的点击
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 默认选中第一个
        if (i == 0) {
            [self titleClick:btn];
        }
        
        [self.titleButtons addObject:btn];
        
    }
}


#pragma mark - 按钮的点击事件
// 点击返回按钮
-(void)backButtonClick
{
    // 返回上一个控制器
    [self.navigationController popViewControllerAnimated:YES];
}

//点击标题时调用
-(void)titleClick:(UIButton *)button
{
    //设置选中按钮
    [self setselectBtn:button];

    //让scrollView滚动对应位置
    [self setUpChildViewWithButton:button];

}

//设置选中按钮
-(void)setselectBtn:(UIButton *)button
{
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
}

//让scrollView滚动对应位置
-(void)setUpChildViewWithButton:(UIButton *)button
{
    NSInteger i = button.tag;
    CGFloat x = i * 375;
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
}


#pragma mark - scrollView代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取角标
    NSInteger i = (NSInteger)scrollView.contentOffset.x / GLScreenW;
    
    //获取按钮
    UIButton *button = self.titleButtons[i];
    
    //设置选中标题
    [self setselectBtn:button];
    
    //添加对应的view
    [self setUpChildViewWithButton:button];
    
}


@end
