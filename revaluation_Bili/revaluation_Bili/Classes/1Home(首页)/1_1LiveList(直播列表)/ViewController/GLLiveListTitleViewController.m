//
//  BiLiBaseScrollViewController.m
//  BiLiBil 二级展示界面
//
//  Created by sunny on 16/4/7.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import "GLLiveListTitleViewController.h"
#import "GLLiveListTitleViewModel.h"

#import "GLLiveContentShowViewController.h"

#import "GLButton.h"

#define scrollViewH 50

#warning 关于网络优化,每新增个网络请求时 取消前面的网络请求
#warning scrollView 高度 contentSize 依赖于 lastSelectBtn按钮状态

#define contextSort_h @"hottest"
#define contextSort_l @"latest"

@interface GLLiveListTitleViewController () <UIScrollViewDelegate>

/** viewModel */
@property (nonatomic, strong) GLLiveListTitleViewModel *glLiveListTitleViewModel;

@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UIScrollView *dropDownscrollView;

@property (weak, nonatomic) UIView *contenView;

@property (nonatomic,strong)NSMutableArray *buttonsArray;
/** scroll中上一个被选中的按钮 */
@property (nonatomic,strong)UIButton *lastSelectBtn;

/** 下拉后的scroll中上一个添加的按钮 */
@property (nonatomic,strong)UIButton *preAddBtn;

@property (nonatomic,strong)UIButton *floatRightBtn;

@property (nonatomic,assign)BOOL isInitial;

@property (nonatomic,assign)BOOL isBest_hot;

/** tapdisposable */
@property (nonatomic, strong) RACDisposable *tapdisposable;

//@property (nonatomic, strong) RACDisposable *dropDownListbtndisposable;
/** tapdisposable */
@property (nonatomic,strong) NSMutableArray<RACDisposable *> *dropDownListbtndisposable;

/** floatBtncommand */
@property (nonatomic, strong) RACCommand *floatBtncommand;

/** TitleBtncommand */
@property (nonatomic, strong) RACCommand *TitleBtncommand;

/** 列表内容控制器 */
@property (nonatomic, weak) GLLiveContentShowViewController *liveContentShowViewController;

@end

@implementation GLLiveListTitleViewController

static CGFloat margin = 20;

- (GLLiveListTitleViewModel *)glLiveListTitleViewModel
{
    if (_glLiveListTitleViewModel == nil) {
        _glLiveListTitleViewModel = [GLLiveListTitleViewModel viewModel];
    }
    
    return _glLiveListTitleViewModel;
    
}

//- (GLLiveContentShowViewController *)liveContentShowViewController
//{
//    if (_liveContentShowViewController == nil) {
//        [self addChildViewController: [[GLLiveContentShowViewController alloc] init]];
//    }
//    return _liveContentShowViewController;
//}

- (NSMutableArray<RACDisposable *> *)dropDownListbtndisposable
{
    if (_dropDownListbtndisposable == nil) {
        _dropDownListbtndisposable = [NSMutableArray array];
    }
    return _dropDownListbtndisposable;
}

#pragma mark - 懒加载buttonsArray
- (NSMutableArray *)buttonsArray
{
    if (_buttonsArray == nil) {
        _buttonsArray = [NSMutableArray array];
    }
    return _buttonsArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    /** 网络不好的占位视图 */
    self.view.backgroundColor = [UIColor whiteColor];
    
    /** 加载contentView排序默认值 */
    self.glLiveListTitleViewModel.sort_value = contextSort_h;
    
}


#warning 不执行viewWillAppear 是为什么

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

#warning 根据标题tag动态添加子控制器
#pragma mark - 添加子控制器
- (void)setupListView
{
    for (int i = 0; i < self.btn_Titles.count; ++i) {
        GLLiveContentShowViewController *vc = [GLLiveContentShowViewController viewController];
        vc.title = self.btn_Titles[i];
        [self addChildViewController:vc];
    }
    
    //    创建顶部的文本scrollView
    [self setupScrollView];
    self.scrollView.delegate = self;
    //    创建下面的占位视图
    [self setupContenView];
    
    //    创建右上角的按钮
    [self setupTopRightButton];
    
    
    
    //    2添加按钮
    if (_isInitial == NO) {
        
        [self addButtons];
        
        _isInitial = YES;
    }
}

#pragma mark - 创建顶部文本的scrollView
- (void)setupScrollView
{
    CGFloat y = self.navigationController.navigationBarHidden ? 20 : 64;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, y, GLScreenW - scrollViewH,scrollViewH);
    
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.view.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    _scrollView = scrollView;

}

#pragma mark - 创建下面的占位视图
- (void)setupContenView
{
    CGFloat y = CGRectGetMaxY(_scrollView.frame);
    UIView *contenView = [[UIView alloc] initWithFrame:CGRectMake(0, y, GLScreenW, GLScreenH - y)];
    [self.view addSubview:contenView];
    _contenView = contenView;
}

#pragma mark - 创建右上角的按钮
- (void)setupTopRightButton
{
    self.isBest_hot = YES;
    
    CGFloat btnW = scrollViewH;
    /** 下拉右边按钮创建 */
    UIButton *floatRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    floatRightBtn.frame = CGRectMake(GLScreenW - btnW, _scrollView.gly_y, btnW, _scrollView.glh_height);
    [floatRightBtn setBackgroundImage:[UIImage imageNamed:@"下拉.jpg"] forState:UIControlStateNormal];
    [floatRightBtn setImage:[UIImage imageNamed:@"上拉.jpg"] forState:UIControlStateSelected];
    
    [self.view addSubview:floatRightBtn];
    
    [floatRightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
//        make.top.bottom.equalTo(self.scrollView);
        make.top.equalTo(@64);
        make.width.height.equalTo(@(scrollViewH));
    }];

    
    self.floatRightBtn = floatRightBtn;
    floatRightBtn.backgroundColor = [UIColor orangeColor];
    
    UIView *cover = [UIView new];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    
    /** 下拉右边按钮监听 */
    [[floatRightBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *clickBtn) {
        floatRightBtn.selected = !floatRightBtn.selected;
        
        if (floatRightBtn.selected) {
            
            [UIView animateWithDuration:0.5 animations:^{
                self.scrollView.alpha = 0;
            }];

            cover.frame = self.view.frame;
            cover.backgroundColor = [UIColor colorWithRed:55/255.0 green:55/255.0 blue:55/255.0 alpha:0.2];
            [self.view addSubview:cover];
            
            [cover addGestureRecognizer:tap];

            UIScrollView *dropDownscrollView = [[UIScrollView alloc] init];
            
            int rowNum = 0;
            int colsNum = 0;
            
            self.preAddBtn = nil;
            
            /** 初始化下拉后的按钮Title */
            for (int i = 0; i < self.buttonsArray.count; ++i) {
                UIButton *dropDownListbtn = self.buttonsArray[i];
                
                rowNum++;
                
                CGFloat x = 0;
                
                CGFloat y = 0;
                
                x = self.preAddBtn.glx_x + self.preAddBtn.glw_width + margin;
                
                if (x + dropDownListbtn.glw_width  > cover.glw_width) {
                    x = 0 + margin;
                    colsNum++;
                }
                
                y = colsNum * dropDownListbtn.glh_height;
                
                /** 这里没有用masonry */
                dropDownListbtn.frame = CGRectMake(x, y, dropDownListbtn.glw_width, dropDownListbtn.glh_height);
                [dropDownscrollView addSubview:dropDownListbtn];
                
                self.preAddBtn = dropDownListbtn;

                /** 下拉后scrollView里的按钮信号 */
                RACDisposable *disposable
                 = [[dropDownListbtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *ClickBtn) {
                     
                     self.glLiveListTitleViewModel.sort_value = contextSort_h;
                     
                    [self.floatBtncommand execute:ClickBtn];
                }];
                
                /** 按钮取消添加进数组 */
                [self.dropDownListbtndisposable addObject:disposable];
                
                /** 其他的初始化 */
                if (i == self.buttonsArray.count -1) {
                    
                    CGFloat height = dropDownListbtn.glh_height * (colsNum + 1);
                  
                    [self.view addSubview:dropDownscrollView];
                    [dropDownscrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.width.equalTo(self.view);
                        make.top.equalTo(self.scrollView);
                    }];
                    
                    /** 下拉View【添加和约束】 */
                    UIView *dropDwonView = [UIView new];
                    
                    [self.view addSubview:dropDwonView];
                    [dropDwonView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(dropDownscrollView.mas_bottom);
                        make.left.right.equalTo(dropDownscrollView);
                        make.height.equalTo(@scrollViewH);
                    }];
                    dropDwonView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
                    
                     /** 下拉View的分割线【添加和约束】 */
                    UIImageView *dropDwon_topLineView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"分割线.jpg"]];
                    [dropDwonView addSubview:dropDwon_topLineView];
                    [dropDwon_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(dropDwonView.mas_top);
                        make.left.equalTo(dropDwonView).offset(25);
                        make.right.equalTo(dropDwonView).offset(-25);
                        make.height.equalTo(@2);
                    }];
                    
                    /** 最热按钮【添加和约束】 */
                    GLButton *best_hot = [GLButton buttonWithType:UIButtonTypeCustom];
                    
                    if (self.isBest_hot) {
                        best_hot.selected = YES;
                    }else{
                        best_hot.selected = NO;
                    }

                    [dropDwonView addSubview:best_hot];
                    
                    self.dropDownscrollView = dropDownscrollView;
                    dropDownscrollView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:0.75];
                    
                    
                    /** 上下的滚动条 无法显示 */
                    dropDownscrollView.contentSize = CGSizeMake(dropDownscrollView.glw_width, dropDownscrollView.glh_height + 1);
                    
                    [best_hot mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.top.bottom.equalTo(dropDwonView);
                        make.width.equalTo(@scrollViewH);
                    }];
                    [best_hot setBackgroundImage:[UIImage imageNamed:@"最热_白.jpg"] forState:UIControlStateNormal];
                    [best_hot setBackgroundImage:[UIImage imageNamed:@"最热_红.jpg"] forState:UIControlStateSelected];
            
                    /** 最新按钮【添加和约束】 */
                    GLButton *best_new = [GLButton buttonWithType:UIButtonTypeCustom];
                    if (self.isBest_hot) {
                        best_new.selected = NO;
                    }else{
                        best_new.selected = YES;
                    }
                    
                    [dropDwonView addSubview:best_new];
                    [best_new mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.bottom.equalTo(dropDwonView);
                        make.left.equalTo(best_hot.mas_right);
                        make.width.equalTo(@scrollViewH);
                    }];
                    [best_new setBackgroundImage:[UIImage imageNamed:@"最新_白色.jpg"] forState:UIControlStateNormal];
                    [best_new setBackgroundImage:[UIImage imageNamed:@"最新_红.jpg"] forState:UIControlStateSelected];
                    
                    /** 下拉处理右边按钮 */
                    // 告诉self.view约束需要更新
                    [dropDwonView addSubview:self.floatRightBtn];
                    [self.floatRightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.bottom.right.equalTo(dropDwonView);
                        make.width.equalTo(@(scrollViewH));

                    }];
                    
                    // 【上拉】处理信号best_hot best_new cover的tap被点击业务逻辑
                    self.floatBtncommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                        
                        [self.tapdisposable dispose];
//                        [self.dropDownListbtndisposable dispose];
                        [self.dropDownListbtndisposable.rac_sequence.signal subscribeNext:^(RACCompoundDisposable * com_disposable) {
                            [com_disposable dispose];
                        }];
                        
                        if (input == best_hot && !best_hot.selected) {
                            best_hot.selected = !best_hot.selected;
                            best_new.selected = !best_new.selected;
                            self.isBest_hot = YES;
                            self.glLiveListTitleViewModel.sort_value = contextSort_h;
                            GLLiveContentShowViewController *vc = self.childViewControllers[self.lastSelectBtn.tag];
                            vc.sort = self.glLiveListTitleViewModel.sort_value;
                            [vc loadData];
                            //contentVC发送网络请求,刷新数据
                        }
                        if (input == best_new && !best_new.selected) {
                            best_hot.selected = !best_hot.selected;
                            best_new.selected = !best_new.selected;
                            self.isBest_hot = NO;
                            self.glLiveListTitleViewModel.sort_value = contextSort_l;
                            
                            GLLiveContentShowViewController *vc = self.childViewControllers[self.lastSelectBtn.tag];
                            vc.sort = self.glLiveListTitleViewModel.sort_value;
                            [vc loadData];
                            //contentVC发送网络请求,刷新数据
                        }
                        
//                        if (input == dropDownbtn) {
//                            NSLog(@"%@",dropDownbtn);
//                        }
                        
                        if (self.scrollView.subviews.count == 1) {
                            [self addButtons];
                        }
                        
                        self.floatRightBtn.alpha = 0;
                        [UIView animateWithDuration:0.25 animations:^{
                            self.dropDownscrollView.alpha = 0;
                            [self.dropDownscrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                                make.height.equalTo(@(0));
                            }];
                            [self.view layoutIfNeeded];
                            
                        }completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.3 animations:^{
                                
                                self.scrollView.alpha = 1;
                                self.floatRightBtn.alpha = 1;
                            }];
                            [cover removeGestureRecognizer:tap];
                            [cover removeFromSuperview];
                            [dropDwonView removeFromSuperview];
                            [self.dropDownscrollView removeFromSuperview];
                            floatRightBtn.selected = NO;
                        }];
                        
                        [self.view addSubview:self.floatRightBtn];
                        [self.floatRightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.right.equalTo(self.view);
                            make.top.bottom.equalTo(self.scrollView);
                            make.width.equalTo(@(btnW));
                        }];
                        
                        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                                [subscriber sendNext:nil];
                                [subscriber sendCompleted];
                            return nil;
                        }];
                        
                    }];
                    /** 最热按钮点击信号 */
                    [[best_hot rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *ClickBtn) {
                        [self.floatBtncommand execute:ClickBtn];
                    }];
                    /** 最新按钮点击信号 */
                    [[best_new rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *ClickBtn) {

                        [self.floatBtncommand execute:ClickBtn];
                    }];
                    /** cover的tap点击信号 */
                    self.tapdisposable = [[tap rac_gestureSignal]subscribeNext:^(id x) {
                        [self.floatBtncommand execute:x];
                    }];
                    
                    [self.view layoutIfNeeded];
                    
                    [UIView animateWithDuration:0.25 animations:^{
                        
                        [dropDownscrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.height.equalTo(@(height));
                        }];
                        [self.view layoutIfNeeded];
                    }];
                    [self.view layoutIfNeeded];
                     // 【上拉】点击业务逻辑结束
                }
            }
        }else{
            [self.floatBtncommand execute:clickBtn];
        }
    }];
}


#pragma mark - 添加所有的按钮
- (void)addButtons
{
    self.preAddBtn = nil;
    
    NSInteger count = self.btn_Titles.count;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat h = self.scrollView.glh_height;
    
    if (self.buttonsArray.count == 0) {
        
        for (int i = 0; i < count; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [btn setTitle:self.btn_Titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            //        绑定标识
            btn.tag = i;
            
            // scrollView的 按钮监听的点击
            [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *clickBtn) {
                // 执行被点击的操作
                [self.TitleBtncommand execute:clickBtn];
                
            }];
            
            self.TitleBtncommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(UIButton *clickBtn) {
                // 发送网络请求 更新 页面;
    //            NSLog(@"发送网络请求 更新 页面%@",clickBtn);
    #warning 问题············
                //        选中按钮
                [self selectBtn:clickBtn];
                
                NSInteger i = clickBtn.tag;
                //    将对应子控制器的view添加上去
                [self setupOneChildViewController:clickBtn];
                
                return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                    return nil;
                }];
            }];
            [btn sizeToFit];
            
            x = self.preAddBtn.glx_x + self.preAddBtn.glw_width + margin;
            
            btn.frame = CGRectMake(x, y, btn.glw_width, h);
            
            self.preAddBtn = btn;
            
            [self.scrollView addSubview:btn];
            
            if (i == 0) {
                [self.TitleBtncommand execute:btn];
    //            [self btnClick:btn];
            }
            
            if (self.buttonsArray.count < count ) {
                [self.buttonsArray addObject:btn];
            }
            
            if (i == count -1) {
                //    设置scrollView的滚动范围
                self.scrollView.contentSize = CGSizeMake(x + btn.glw_width+ margin, 0);
            }
        }
    }else{
        self.preAddBtn = nil;
        for (int i = 0; i < self.buttonsArray.count; ++i) {
            UIButton *titleListBtn = self.buttonsArray[i];
            x = self.preAddBtn.glx_x + self.preAddBtn.glw_width + margin;
            titleListBtn.frame = CGRectMake(x, y, titleListBtn.glw_width, h);
            [self.scrollView addSubview:titleListBtn];
            self.preAddBtn = titleListBtn;
        }
        
    }
}

/** 
 #pragma mark - 监听按钮的点击
 - (void)btnClick:(UIButton *)btn
 {
 //        选中按钮
 [self selectBtn:btn];
 
 //    移除其他的控制器的view
 for (UIView *view in self.contenView.subviews) {
 [view removeFromSuperview];
 }
 
 NSInteger i = btn.tag;
 //    将对应子控制器的view添加上去
 [self setupOneChildViewController:i];
 
 }
 */

#pragma mark -把子控制器的view添加
- (void)setupOneChildViewController:(UIButton *)clickBtn
{
    GLLiveContentShowViewController *vc = self.childViewControllers[clickBtn.tag];
    
    vc.tag = self.childViewControllers[clickBtn.tag].title;
    vc.area_id = self.area_id;
    vc.sort = self.glLiveListTitleViewModel.sort_value;
    // 设置vc的view的位置
    vc.view.frame = self.contenView.bounds;
    

    //    移除其他的控制器的view
    for (UIView *view in self.contenView.subviews) {
        [view removeFromSuperview];
    }
    
    if (clickBtn != self.lastSelectBtn) {
        [vc loadData];
    }
    
    self.lastSelectBtn.selected = NO;
    clickBtn.selected = YES;
    self.lastSelectBtn = clickBtn;
    self.lastSelectBtn.tag = clickBtn.tag;

    [self.contenView addSubview:vc.view];
    
}

- (void)selectBtn:(UIButton *)btn
{
    
    CGFloat max = self.scrollView.contentSize.width - self.scrollView.glw_width;
    
    if (btn.glx_x >= max && max > 0) {
        
        [self.scrollView setContentOffset:CGPointMake(max, 0) animated:YES];
        
        return;
    }
    
    [self.scrollView setContentOffset:CGPointMake(btn.glx_x - margin, 0) animated:YES];
}

@end
