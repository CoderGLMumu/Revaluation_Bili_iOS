//
//  GLPlaceholderView.m
//  revaluation_Bili
//
//  Created by mac on 16/5/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLPlaceholderView.h"

@interface GLPlaceholderView ()

/** 占位视图 */
@property (nonatomic, weak) UIImageView *placeholderView;

/** 占位文本 */
@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation GLPlaceholderView

#pragma mark - 占位视图-快交作业
/** 初始化,占位视图-快交作业 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        
        self.backgroundColor = GLColor(245, 246, 247);
        
        UIImageView *placeholderView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"empty_list_search_1"]];
        
        [self addSubview:placeholderView];
        self.placeholderView = placeholderView;
        
        placeholderView.contentMode = UIViewContentModeScaleAspectFill;
        NSString *filenamePrefix = @"empty_list_search";
       
        [self playAnima:filenamePrefix count:2 animationRepeatCount:0];
        
        [placeholderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@50);
            make.right.equalTo(@-50);
            make.top.equalTo(@10);
            make.height.equalTo(placeholderView.mas_width);
        }];
        
        UILabel *placeholderLabel = [UILabel new];
        placeholderLabel.text = @"正在拼命加载数据";
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        [placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(placeholderView.mas_bottom).offset(5);
            make.centerX.equalTo(placeholderView);
        }];
        
    }
    return self;
}

#pragma mark - 占位视图-网络不通
/** 初始化,占位视图-电波无法到达哟 */
- (void)netWorkNotReachableisTimeOut:(BOOL)isTimeOut
{
    if (isTimeOut) {
        self.placeholderView.image = [UIImage imageNamed:@"empty_list_no_network_4.jpg"];
        
        self.placeholderLabel.text = @"电波无法传达,请检查你的女朋友是否连接好";
    }else{
        self.placeholderView.image = [UIImage imageNamed:@"empty_list_no_network_4.jpg"];
        
        self.placeholderLabel.text = @"电波无法传达,请检查你的女朋友是否连接好";
        
        NSString *filenamePrefix = @"empty_list_no_network";
        
        [self playAnima:filenamePrefix count:2 animationRepeatCount:2];
    }
}

#pragma mark - 占位视图-服务器返回的数据为空
/** 初始化,占位视图-没有返回数据 */
- (void)netWorkNotData
{
    self.placeholderView.image = [UIImage imageNamed:@"empty_list_not_found"];
    
    self.placeholderLabel.text = @"没有找到你想要的东西";
}


- (void)playAnima:(NSString *)filenamePrefix count:(int)count animationRepeatCount:(NSInteger)animationRepeatCount
{
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i<=count; i++) {
        NSString *filename = [NSString stringWithFormat:@"%@_%d", filenamePrefix, i];
        NSString *file = [[NSBundle mainBundle] pathForResource:filename ofType:@"jpg"];
        UIImage *image = [UIImage imageWithContentsOfFile:file];
        [images addObject:image];
    }
    // 设置动画图片
    self.placeholderView.animationImages = images;
    self.placeholderView.animationDuration = 1;
    
    // 设置播放次数
    self.placeholderView.animationRepeatCount = animationRepeatCount;
    
    // 开始动画
    [self.placeholderView startAnimating];
    
}

static GLPlaceholderView *_instance;

//类方法，返回一个单例对象
+ (instancetype)sharePlaceholderView
{
    //注意：这里建议使用self,而不是直接使用类名Tools（考虑继承）
    
    return [[self alloc]init];
}

//保证永远只分配一次存储空间
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    //    使用GCD中的一次性代码
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });

    return _instance;
}

@end
