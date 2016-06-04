

#import "GLDIYHeader.h"
#import "UIView+GLExtension.h"

@interface GLDIYHeader()
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UISwitch *s;
@property (weak, nonatomic) UIImageView *logo;
@property (weak, nonatomic) UIActivityIndicatorView *loading;
@end

@implementation GLDIYHeader
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 100;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    // 打酱油的开关
//    UISwitch *s = [[UISwitch alloc] init];
//    [self addSubview:s];
//    self.s = s;
    
    const int total_Image = 4;
    
    NSMutableArray *image_arr = [NSMutableArray array];
    
    for (int i = 0; i < total_Image; ++i) {
        NSString *image_name = [NSString stringWithFormat:@"pullRefresh_gif_%d.png",i + 1];
        
        UIImage *image = [UIImage imageNamed:image_name];
        
        [image_arr addObject:image];
    }
    
    // logo
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pullRefresh_gif_1.png"]];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logo];
    self.logo = logo;
    
    self.logo.animationImages = image_arr;
    self.logo.animationDuration = 0.1;
    
    // loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];

    self.label.frame = CGRectMake(0, self.bounds.size.height * 0.7, self.bounds.size.width, self.bounds.size.height * 0.3);
    
    self.logo.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height * 0.75);
    
    self.loading.center = CGPointMake(self.label.glx_x + 50, self.glh_height * 0.5);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];

}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];

}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;

    switch (state) {
        case MJRefreshStateIdle:
            [self.loading stopAnimating];
            [self.s setOn:NO animated:YES];
            self.label.text = @"放开本宝宝";
            [self.logo stopAnimating];
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
            [self.logo stopAnimating];
            [self.s setOn:YES animated:YES];
            self.label.text = @"再不放程序就要蹦了";
            break;
        case MJRefreshStateRefreshing:
            [self.s setOn:YES animated:YES];
            self.label.text = @"刷呀刷呀,好累啊,喵⊙﹏⊙‖∣";
            [self.loading startAnimating];
            [self.logo startAnimating];
            break;
        case MJRefreshStateWillRefresh:
            [self.s setOn:YES animated:YES];
            self.label.text = @"我还会回来哒";
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
    CGFloat red = 1.0 - pullingPercent * 0.5;
    CGFloat green = 0.5 - 0.5 * pullingPercent;
    CGFloat blue = 0.5 * pullingPercent;
    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
