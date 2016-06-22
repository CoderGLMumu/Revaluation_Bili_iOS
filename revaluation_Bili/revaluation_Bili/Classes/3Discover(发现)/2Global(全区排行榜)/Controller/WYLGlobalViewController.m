//
//  WYLGlobalViewController.m
//  Bili
//
//  Created by 王亚龙 on 16/4/3.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLGlobalViewController.h"
#import "WYLSweetsopTableViewController.h"
#import "WYLAnimateTableViewController.h"
#import "WYLMusicTableViewController.h"
#import "WYLDanceTableViewController.h"
#import "WYLGameTableViewController.h"
#import "WYLScienceTableViewController.h"
#import "WYLAmusementTableViewController.h"
#import "WYLGhostTableViewController.h"
#import "WYLFilmTableViewController.h"
#import "WYLTeleplayTableViewController.h"
#import "WYLFashionTableViewController.h"


#define WYLScreenW [UIScreen mainScreen].bounds.size.width
#define WYLScreenH [UIScreen mainScreen].bounds.size.height

@interface WYLGlobalViewController ()<UIScrollViewDelegate>
/** 标题*/
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
/** 内容*/
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
/** 标题按钮*/
@property (nonatomic ,strong) NSMutableArray *titleButtons;
/** 选中按钮*/
@property (nonatomic ,weak) UIButton *selectButton;
/** 下划线*/
@property (nonatomic ,weak) UIView *titleUnderLine;

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation WYLGlobalViewController

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
    
    //设置内容的代理
    self.contentScrollView.delegate = self;
    
    //添加所有子控制器
    [self setupAllChildViewController];
    
    //设置所有标题
    [self setupAllTitleButton];
    
    //iOS7之后,导航控制器中的scrollView默认顶部会添加额外滚动区域64
    //内容无缘无故往下面走64 -> 有没有导航控制器
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加所有子控制器的view
    [self setUpAllChildView];
}


//添加所有子控制器的view
-(void)setUpAllChildView
{
    NSInteger count = self.childViewControllers.count;
    for (int i = 0; i < count; i++) {
        
        UIViewController *tableVc = self.childViewControllers[i];
        CGFloat x = i * WYLScreenW;
        // 设置vc的view的位置

        //不能用屏幕宽度?
        tableVc.view.frame = CGRectMake(x, 0, self.contentScrollView.bounds.size.width, self.contentScrollView.bounds.size.height);

        tableVc.view.frame = CGRectMake(x, 0, WYLScreenW , self.contentScrollView.bounds.size.height);

        [self.contentScrollView addSubview:tableVc.view];
    }
}

//添加所有的子控制器
-(void)setupAllChildViewController
{
    //番剧
    WYLSweetsopTableViewController *sweetsopVc = [[WYLSweetsopTableViewController alloc] init];
    sweetsopVc.title = @"番剧";
    [self addChildViewController:sweetsopVc];

    
    //动画
    WYLAnimateTableViewController *animateVc = [[WYLAnimateTableViewController alloc] init];
    animateVc.title = @"动画";
    [self addChildViewController:animateVc];

    //音乐
    WYLMusicTableViewController *musicVc = [[WYLMusicTableViewController alloc] init];
    musicVc.title = @"音乐";
    [self addChildViewController:musicVc];
    
    //舞蹈
    WYLDanceTableViewController *danceVc = [[WYLDanceTableViewController alloc] init];
    danceVc.title = @"舞蹈";
    [self addChildViewController:danceVc];
    
    //游戏
    WYLGameTableViewController *gameVc = [[WYLGameTableViewController alloc] init];
    gameVc.title = @"游戏";
    [self addChildViewController:gameVc];
    
    //科技
    WYLScienceTableViewController *scienceVc = [[WYLScienceTableViewController alloc] init];
    scienceVc.title = @"科技";
    [self addChildViewController:scienceVc];
    
    //娱乐
    WYLAmusementTableViewController *amusementVc = [[WYLAmusementTableViewController alloc] init];
    amusementVc.title = @"娱乐";
    [self addChildViewController:amusementVc];
    
    //鬼畜
    WYLGhostTableViewController *ghostVc = [[WYLGhostTableViewController alloc] init];
    ghostVc.title = @"鬼畜";
    [self addChildViewController:ghostVc];
    
    //电影
    WYLFilmTableViewController *filmVc = [[WYLFilmTableViewController alloc] init];
    filmVc.title = @"电影";
    [self addChildViewController:filmVc];
    
    //电视剧
    WYLTeleplayTableViewController *teleplayVc = [[WYLTeleplayTableViewController alloc] init];
    teleplayVc.title = @"电视剧";
    [self addChildViewController:teleplayVc];
    
    //时尚
    WYLFashionTableViewController *fashionVc = [[WYLFashionTableViewController alloc] init];
    fashionVc.title = @"时尚";
    [self addChildViewController:fashionVc];
    
}

//设置所有的标题
- (void)setupAllTitleButton
{
    NSInteger count = self.childViewControllers.count;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = 70;
    CGFloat btnH = 35;
    
    for (int i = 0; i < count; i++) {
        // 创建按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btnX = i * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleScrollView addSubview:btn];
        
        //默认选中第一个
        if (i == 0) {
            [self titleClick:btn];
        }
        
        [self.titleButtons addObject:btn];
        
    }
    
    // 设置titleScrollView滚动范围
    CGFloat contentW = count * btnW;
    self.titleScrollView.contentSize = CGSizeMake(contentW, 0);
    // 清空水平指示条
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    
    //设置contentView的滚动范围
    self.contentScrollView.contentSize = CGSizeMake(count * WYLScreenW, 0);
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    
    //添加下划线
//    [self setUpTitleUnderLine];
}

//设置下划线
-(void)setUpTitleUnderLine
{

    UIView *titleUnderLine = [[UIView alloc] init];
    self.titleUnderLine = titleUnderLine;
    CGFloat titleUnderLineH = 2;
    CGFloat titleUnderLineY = self.titleScrollView.bounds.size.height - titleUnderLineH;
    titleUnderLine.frame = CGRectMake(0, titleUnderLineY, 50, titleUnderLineH);
    
    titleUnderLine.backgroundColor = [UIColor redColor];
    [self.titleScrollView addSubview:titleUnderLine];
    
    
}

//点击标题时调用
-(void)titleClick:(UIButton *)button
{
    //设置选中按钮
    [self setselectBtn:button];
    
    //让scrollView滚动对应位置
    [self setUpChildViewWithButton:button];
    
    [UIView animateWithDuration:0.25 animations:^{
        //设置下划线
//        self.titleUnderLine.
    }];
}

//设置选中按钮
-(void)setselectBtn:(UIButton *)button
{
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
    
    // 标题居中显示:本质就是设置偏移量
//    CGFloat offsetX = button.center.x - (WYLScreenW - self.backButton.size.width) * 0.5;
    CGFloat offsetX = button.center.x - (WYLScreenW - self.backButton.glw_width) * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    // 处理最大偏移量
//    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - (WYLScreenW - self.backButton.size.width);
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - (WYLScreenW - self.backButton.glw_width);
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

//让scrollView滚动对应位置
-(void)setUpChildViewWithButton:(UIButton *)button
{
    NSInteger i = button.tag;
    CGFloat x = i * WYLScreenW;
    
    // 让scrollView滚动对应位置
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
}

//点击返回按钮
- (IBAction)back:(UIButton *)sender {
    sender.titleLabel.font = [UIFont systemFontOfSize:14];
    [sender setTintColor:[UIColor lightGrayColor]];
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
//    NSLog(@"%@",self.titleButtons);
    //获取角标
    NSInteger i = (NSInteger)scrollView.contentOffset.x / WYLScreenW;
    
    //获取按钮
    UIButton *button = self.titleButtons[i];
    
    //设置选中标题
    [self setselectBtn:button];
    
    //添加对应的view
    [self setUpChildViewWithButton:button];
    
}




@end
