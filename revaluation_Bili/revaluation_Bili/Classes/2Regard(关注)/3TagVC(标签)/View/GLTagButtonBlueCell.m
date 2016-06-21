//
//  GLTagButtonCell.m
//  Bili
//
//  Created by mac on 16/4/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "GLTagButtonBlueCell.h"
//#import "UIImage+Color.h"
#import "GLButtonBeautification.h"

@interface GLTagButtonBlueCell ()
@property (weak, nonatomic) IBOutlet UIView *buttonViewTop;
@property (weak, nonatomic) IBOutlet UIView *buttonViewbot;

@end

@implementation GLTagButtonBlueCell

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
    for (UIButton *btn in self.buttonViewbot.subviews) {
        
        [GLButtonBeautification ButtonBeautification:btn AndColor:[UIColor blueColor] AndCornerRadius:btn_cornerRadius Completion:^(UIButton *Beautif_button){
            
            [Beautif_button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            
            [Beautif_button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if (item && (btn_index <= item.count)) {
                if (btn_index >= item.count) {
                    btn_index = 0;
                }
                
                [Beautif_button setTitle:item[btn_index] forState:UIControlStateNormal];
                btn_index++;
            }
        }];
    }
    
    for (UIButton *btn in self.buttonViewTop.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            
            [GLButtonBeautification ButtonBeautification:btn AndColor:[UIColor blueColor] AndCornerRadius:btn_cornerRadius Completion:^(UIButton *Beautif_button){
                
                [Beautif_button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
                
                [Beautif_button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                if (item && (btn_index <= item.count)) {
                    if (btn_index >= item.count) {
                        btn_index = 0;
                    }
                    [Beautif_button setTitle:item[btn_index] forState:UIControlStateNormal];
                    btn_index++;
                    
                }
            }];
        }
    }
}

- (void)btnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
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
