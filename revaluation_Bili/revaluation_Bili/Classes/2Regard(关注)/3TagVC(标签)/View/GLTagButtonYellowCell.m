//
//  GLTagButtonCell.m
//  Bili
//
//  Created by mac on 16/4/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "GLTagButtonYellowCell.h"
#import "GLButtonBeautification.h"

@interface GLTagButtonYellowCell ()
@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet UIView *btnViewbot;

@end

static int const btn_cornerRadius = 16;

@implementation GLTagButtonYellowCell

- (void)awakeFromNib {

    for (UIButton *btn in self.btnViewbot.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            [GLButtonBeautification ButtonBeautification:btn AndColor:[UIColor yellowColor] AndCornerRadius:btn_cornerRadius Completion:^(UIButton *Beautif_button){
                
                [Beautif_button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
                
                [Beautif_button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            }];
        }
    }
    
    for (UIButton *btn in self.btnView.subviews) {

        [GLButtonBeautification ButtonBeautification:btn AndColor:[UIColor yellowColor] AndCornerRadius:btn_cornerRadius Completion:^(UIButton *Beautif_button){
            
            [Beautif_button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            
            [Beautif_button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }];
    }
}

- (void)btnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
}

@end
