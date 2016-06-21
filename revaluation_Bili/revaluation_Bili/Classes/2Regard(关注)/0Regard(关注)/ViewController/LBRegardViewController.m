//
//  LBRegardViewController.m
//  Bili
//
//  Created by 林彬 on 16/3/31.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBRegardViewController.h"

#import "LBColorScale.h"

#import "GLRegardTitleButton.h"

#import "GLTagViewController.h"
#import "GLMotiveSealViewController.h"
#import "GLDynamicViewController.h"

#import "UIView+GLExtension.h"

#define TitleScrollViewH 44

#define GLScreenB [UIScreen mainScreen].bounds

@interface LBRegardViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *TitleScrollV;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollV;

/** selTitleBtn */
@property (nonatomic, weak) UIButton *selTitlebtn;

/** btnView */
@property (nonatomic, weak) UIView *titleBtnView;

/** 标题按钮数组 */
@property (nonatomic, strong) NSMutableArray<UIButton *> *titleButton_Arr;
@property (nonatomic, weak) UIView *underLineView;

@end

@implementation LBRegardViewController

- (NSMutableArray *)titleButton_Arr
{
    if (_titleButton_Arr == nil) {
        _titleButton_Arr = [NSMutableArray array];
    }
    return _titleButton_Arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = GLScreenB;
    
    self.TitleScrollV.glw_width = self.view.glw_width;
    
    self.contentScrollV.glw_width = self.view.glw_width;
    
    self.navigationController.navigationBarHidden = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupChildViewController];
    
    self.contentScrollV.contentSize = CGSizeMake(GLScreenW * self.childViewControllers.count, 0);
    
    self.contentScrollV.pagingEnabled = YES;
    
    [self setupTitleScrollView];
}

- (void)setupChildViewController
{
    //01追番
    GLMotiveSealViewController *glmotivesealVc = [[GLMotiveSealViewController alloc]init];
    
    glmotivesealVc.title = @"追番";
    [self addChildViewController:glmotivesealVc];
    
    //02动态
    GLDynamicViewController *glDynamicVc = [[GLDynamicViewController alloc]init];
    
    glDynamicVc.title = @"动态";
    
    [self addChildViewController:glDynamicVc];
    
    
    //03标签
    GLTagViewController *glTagVc = [[GLTagViewController alloc]init];
    
    glTagVc.title = @"标签";
    
    [self addChildViewController:glTagVc];
}

#pragma mark - 【设置】标题按钮
- (void)setupTitleScrollView
{
    
    UIView *titleBtnView = [[UIView alloc]init];
    self.titleBtnView = titleBtnView;
    titleBtnView.frame = CGRectMake(0, 0, self.TitleScrollV.glw_width - GLScreenB.size.width * 0.3, self.TitleScrollV.glh_height);
    [self.TitleScrollV addSubview:titleBtnView];
    
    NSInteger count = self.childViewControllers.count;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = titleBtnView.glw_width / 3;  // 暂时就3个.由于平分,暂时没有滚动效果.
    CGFloat btnH = TitleScrollViewH;
    
    for (int i = 0; i < count; ++i) {
        UIViewController *vc = self.childViewControllers[i];
        
        GLRegardTitleButton *btn = [GLRegardTitleButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitleColor:[UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];

        btn.tag = i;
        
        [btn setTitle:vc.title forState:UIControlStateNormal];
        
        btnX = i * btnW;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);

        [btn addTarget:self action:@selector(clickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [titleBtnView addSubview:btn];
        
        [self.titleButton_Arr addObject:btn];
        
        titleBtnView.glcx_centerX = self.TitleScrollV.glcx_centerX;
        
        if (i == 0) {
            [self clickTitleBtn:btn];
            btn.transform = CGAffineTransformMakeScale(1.3, 1.3);
        }
    }
    
    [self setUpUnderLine];
}

#pragma mark - 【点击】标题按钮
- (void)clickTitleBtn:(UIButton *)btn
{
    if (btn.selected) {
        //拿到对应的tableView并且设置contentOffset为0,0
        
    }
    
    if (btn == self.selTitlebtn) return;
    
    self.selTitlebtn.transform = CGAffineTransformIdentity;
    
    [self changeBtnColor:btn];
    
    self.selTitlebtn = btn;
    
    // 角标最好从tag取,性能好过遍历数组
    NSInteger index = btn.tag;
    
    [UIView animateWithDuration:0.25 animations:^{
        // 按钮点击的时候,下划线位移
        // 做下划线的滑动动画
        self.underLineView.glw_width = btn.titleLabel.glw_width + 10;

        // 让内容滚动条滚动对应位置,就是"直播"出现在第一个位置
        CGFloat x = index * GLScreenW;
        // 获得偏移量
        self.contentScrollV.contentOffset = CGPointMake(x, 0);
        
    } completion:^(BOOL finished) {
        // 动画结束的时候,加载控制器(方便实现懒加载)
        [self setOneChildView:btn.tag];
    }];

    
}

- (void)changeBtnColor:(UIButton *)btn
{
    [self.selTitlebtn setTitleColor:[UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor colorWithRed:223/255.0 green:104/255.0 blue:137/255.0 alpha:1] forState:UIControlStateNormal];
}

#pragma mark -  设置下划线
- (void)setUpUnderLine
{
    // 获取第一个按钮.因为一开始就是选中的第一个按钮.要的是这个按钮的颜色,文字宽度
    UIButton *firstButton = self.titleButton_Arr[0];
    
    UIView *underLineView = [[UIView alloc] init];
    CGFloat underLineH = 2;
    CGFloat underLineY = self.TitleScrollV.glh_height - underLineH;
    underLineView.frame = CGRectMake(0, underLineY, 0, underLineH);
    underLineView.backgroundColor = [firstButton titleColorForState:UIControlStateNormal];
    [self.TitleScrollV addSubview:underLineView];
    self.underLineView = underLineView;
    
    // 下划线
    [firstButton.titleLabel sizeToFit];
    self.underLineView.glw_width = firstButton.titleLabel.glw_width + 10;
    self.underLineView.glcx_centerX = firstButton.glcx_centerX + self.titleBtnView.glx_x;
}


- (void)setOneChildView:(NSInteger)i
{
    UIViewController *vc = self.childViewControllers[i];
    [self.contentScrollV addSubview:vc.view];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = GLScreenW;
    CGFloat h = self.contentScrollV.glh_height;
    
    x = GLScreenW * i;
    
    vc.view.frame = CGRectMake(x, y, w, h);
    
    self.contentScrollV.contentOffset = CGPointMake(x, 0);
    
    self.contentScrollV.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark -  内容左右滚动,对按钮文字进行缩放,对颜色进行渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 对字体和颜色进行渐变
    [LBColorScale scaleColor:scrollView withButtonArray:self.titleButton_Arr];
    [LBColorScale scaleTitle:scrollView withButtonArray:self.titleButton_Arr];
    
    CGFloat offset = scrollView.contentOffset.x / GLScreenW;
    
    UIButton *btn = self.titleButton_Arr[0];
    
    self.underLineView.transform = CGAffineTransformMakeTranslation(offset * btn.glw_width, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.glw_width;

    UIButton *btn = self.titleBtnView.subviews[index];
    
    [self clickTitleBtn:btn];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
