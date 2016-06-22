//
//  WYLHeaderView.m
//  Bili
//
//  Created by 王亚龙 on 16/4/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLHeaderView.h"
#import "MyLayout.h"
#import "WYLButtonItem.h"

@interface WYLHeaderView()<UITextFieldDelegate>

/** 中间collectionView的高度*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;
/** 顶部的view*/
@property (weak, nonatomic) IBOutlet UIView *topView;
/** 底部的view*/
@property (weak, nonatomic) IBOutlet UIView *bottomView;
/** 中间显示标签的view*/
@property (weak, nonatomic) IBOutlet MyFlowLayout *middleView;

@end

//搜索视频、番剧、up主或AV号


@implementation WYLHeaderView

// 快速创建headerView
+(WYLHeaderView *)headerView
{
    return [[NSBundle mainBundle] loadNibNamed:@"WYLHeaderView" owner:nil options:nil][0];
}



-(void)awakeFromNib
{
    self.middleView.showsVerticalScrollIndicator = NO;
    
}


-(void)setItemArray:(NSArray *)itemArray
{
    _itemArray = itemArray;
    for (int i = 0; i < self.itemArray.count; i++) {
        WYLButtonItem *item = self.itemArray[i];
        [self createTagButton:item.keyword];
    }
}


//添加标签
-(void)createTagButton:(NSString*)text
{
    self.middleView.subviewVertMargin = 8;
    self.middleView.subviewHorzMargin = 5;
    
    UIButton *tagButton = [UIButton new];
    [tagButton setTitle:text forState:UIControlStateNormal];
    [tagButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    tagButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [tagButton sizeToFit];
    tagButton.glw_width += 15;
//    tagButton.tag = ;
    
    tagButton.layer.borderWidth = 2;
    tagButton.layer.cornerRadius = 5;
    tagButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    tagButton.layer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor whiteColor]);
    
    [tagButton addTarget:self action:@selector(buttonTagClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.middleView addSubview:tagButton];
    
    self.middleView.contentSize = CGSizeMake(0, 500);
}

#pragma mark - 按钮的点击
//点击了标签按钮
-(void)buttonTagClick:(UIButton *)button
{
    // 模拟获取标签内容
    NSString *string = @"欢乐颂";
    
    // 转码
    NSString *stringURL = [NSString stringWithFormat:@"http://api.bilibili.com/search?access_key=fff31e88a011097d502f65c403a36bac&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3110&device=phone&keyword=%@&main_ver=v3&order=totalrank&page=1&pagesize=30&platform=ios&search_type=all&sign=bc9feed438f9970865e7b0fdb2fec866&source_type=1&ts=1462928420",string];
    stringURL = [stringURL
                 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 发送请求
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr GET:stringURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
         //这里已经请求到数据,但是遇到一个问题,就是每个按钮sign不一样,请求数据的url不相同,待解决
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    // 跳转到搜索界面
    self.searchBlock();
    
}

//扫一扫
- (IBAction)scan:(id)sender {
    NSLog(@"扫描二维码");
    self.valueBlock();
}

//点击查看更多
- (IBAction)moreBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.collectionViewHeight.constant = self.collectionViewHeight.constant == 140 ? 280 : 140;
    
    //headerView的高度
    self.height = self.topView.glh_height + self.bottomView.glh_height + self.collectionViewHeight.constant;
    
    //设置middelView能不能滚动
    self.middleView.scrollEnabled = !self.middleView.scrollEnabled;

    //让middelView回到最顶部
    [UIView animateWithDuration:0.25 animations:^{
        self.middleView.contentOffset = CGPointMake(0, 0);
    }];
#warning 这里还有一个问题要解决,就是计算标签的总高度,用来设置滚动高度
}


// 点击搜索按钮
- (IBAction)searchButtonClick {
    
    // 调用block跳转到搜索控制器
    self.searchBlock();
}



@end
