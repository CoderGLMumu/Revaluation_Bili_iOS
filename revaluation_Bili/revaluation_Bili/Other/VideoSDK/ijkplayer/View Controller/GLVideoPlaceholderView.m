//
//  GLPlaceholderView.m
//  pack_ijkplayer
//
//  Created by mac on 16/6/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLVideoPlaceholderView.h"

@interface GLVideoPlaceholderView ()
@property (weak, nonatomic) IBOutlet UIImageView *PhImageView;
@property (weak, nonatomic) IBOutlet UIButton *sacleBtn;

@end

@implementation GLVideoPlaceholderView

- (void)dealloc
{
    NSLog(@"GLvideo被销毁了");
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUpInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpInit];
}

- (void)setUpInit
{
    self.PhImageView.image = [UIImage imageNamed:@"ani_loading_1.png"];
    NSMutableArray *arrT = [NSMutableArray array];
    int count = 5;
    for (int i = 0; i < count; ++i) {
        NSString *str = [NSString stringWithFormat:@"ani_loading_%d.png",i+1];
        UIImage *image = [UIImage imageNamed:str];
        [arrT addObject:image];
    }
    self.PhImageView.image = [UIImage imageNamed:@"ani_loading_1"];
    self.PhImageView.animationImages = arrT;
    self.PhImageView.animationDuration = 0.25;
    self.PhImageView.animationRepeatCount = 0;
    [self.PhImageView startAnimating];
    
    self.sacleBtn.hidden = YES;
    
}

@end
