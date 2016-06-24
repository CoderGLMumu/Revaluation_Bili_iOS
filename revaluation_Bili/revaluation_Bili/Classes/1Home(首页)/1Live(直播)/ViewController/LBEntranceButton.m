

//
//  LBEntranceButton.m
//  Bili
//
//  Created by 林彬 on 16/4/14.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBEntranceButton.h"
#import "LBEntranceButtonItem.h"

@interface LBEntranceButton()



@end

@implementation LBEntranceButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        
        
    }
    //self.backgroundColor = [UIColor redColor];
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.glcx_centerX = self.glw_width * 0.5;
    self.imageView.gly_y = 0;
    self.imageView.gls_size = CGSizeMake(40, 40);
    // 重新设置imageView的frame,防止在6S-plus的情况下发生图片错位.
    self.imageView.frame = CGRectMake((self.glw_width - 40) * 0.5, 0, 40, 40);
    
    // 根据文字内容计算下label,设置好label尺寸
    [self.titleLabel sizeToFit];
    self.titleLabel.glcx_centerX = self.glw_width * 0.5;
    self.titleLabel.gly_y = self.glh_height - self.titleLabel.glh_height ;
    self.titleLabel.textColor = LBColor(100, 100, 100);
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    // 自适应按钮大小
//    [self sizeToFit];
}

- (void)setButtonItem:(LBEntranceButtonItem *)buttonItem
{
    _buttonItem = buttonItem;
    
    [self setTitle:buttonItem.name forState:UIControlStateNormal];
    NSURL *imageUrl = [NSURL URLWithString:buttonItem.entrance_icon[@"src"]];
    [self sd_setImageWithURL:imageUrl forState:UIControlStateNormal];
}

// 取消高亮状态
- (void)setHighlighted:(BOOL)highlighted
{

}

@end
