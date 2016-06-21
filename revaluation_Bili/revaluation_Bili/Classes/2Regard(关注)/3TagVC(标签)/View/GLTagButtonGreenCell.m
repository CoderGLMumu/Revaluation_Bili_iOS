//
//  GLTagButtonCell.m
//  Bili
//
//  Created by mac on 16/4/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "GLTagButtonGreenCell.h"
#import "GLButtonBeautification.h"

@interface GLTagButtonGreenCell ()
@property (weak, nonatomic) IBOutlet UIView *buttonViewTop;
@property (weak, nonatomic) IBOutlet UIView *buttonViewMid;
@property (weak, nonatomic) IBOutlet UIView *buttonViewBot;

@end

@implementation GLTagButtonGreenCell

static int const btn_cornerRadius = 16;

static int btn_index = 0;

- (void)awakeFromNib {

    
}

- (void)setItem:(NSArray *)item
{
    _item = item;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setupButtonItem:item];
    });

}

- (void)setupButtonItem:(NSArray *)item
{
    for (UIButton *btn in self.buttonViewTop.subviews) {
        
        [GLButtonBeautification ButtonBeautification:btn AndColor:[UIColor greenColor] AndCornerRadius:btn_cornerRadius Completion:^(UIButton *Beautif_button){
            
            [Beautif_button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            
            [Beautif_button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if (item && (btn_index <= item.count)) {
                [Beautif_button setTitle:item[btn_index] forState:UIControlStateNormal];
                btn_index++;
                if (btn_index > item.count) {
                    btn_index = 0;
                }
            }
        }];
        
    }
    for (UIButton *btn in self.buttonViewMid.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            [GLButtonBeautification ButtonBeautification:btn AndColor:[UIColor greenColor] AndCornerRadius:btn_cornerRadius Completion:^(UIButton *Beautif_button){
                
                [Beautif_button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
                
                [Beautif_button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                if (item && (btn_index <= item.count)) {
                    [Beautif_button setTitle:item[btn_index] forState:UIControlStateNormal];
                    btn_index++;
                    if (btn_index > item.count) {
                        btn_index = 0;
                    }
                }
            }];
        }
    }
    for (UIButton *btn in self.buttonViewBot.subviews) {
        
        [GLButtonBeautification ButtonBeautification:btn AndColor:[UIColor greenColor] AndCornerRadius:btn_cornerRadius Completion:^(UIButton *Beautif_button){
            
            [Beautif_button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            
            [Beautif_button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if (item && (btn_index <= item.count)) {
                [Beautif_button setTitle:item[btn_index] forState:UIControlStateNormal];
                btn_index++;
                if (btn_index > item.count) {
                    btn_index = 0;
                }
            }
        }];
    }
}

- (void)btnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
}

@end
