//
//  GLLiveRoomCell.m
//  revaluation_Bili
//
//  Created by mac on 16/5/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLLiveRoomCell.h"

@interface GLLiveRoomCell ()

/** 装载tag_btn数组 */
@property (nonatomic, strong) NSMutableArray *tag_btns;

@property (weak, nonatomic) IBOutlet UILabel *TagLabel;

@property (weak, nonatomic)  UIButton *preAddBtn;

@property (assign, nonatomic)  BOOL test;

@end

@implementation GLLiveRoomCell

- (NSMutableArray *)tag_btns
{
    if (_tag_btns == nil) {
        _tag_btns = [NSMutableArray array];
    }
    return _tag_btns;
}

- (void)setItem:(GLLiveRoomModel *)item
{
    // 创建按钮
    /** 模型数据的总数 */
    for (int i = 0; i < item.tags.count; ++i) {
        UIButton *tag_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        tag_btn.tag = i;
        [self addSubview:tag_btn];
        
        [[tag_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            // 跳转 对应的 控制器 搜索
            NSLog(@"跳转%@控制器 搜索",tag_btn.titleLabel.text);
        }];
        [tag_btn setBackgroundColor:GLColor(222, 222, 222)];
        
        NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
        dictM[NSFontAttributeName] = [UIFont systemFontOfSize:15];
        dictM[NSForegroundColorAttributeName] = GLColor(207, 110, 140);
        
        NSAttributedString *attrTitle = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",item.tags[i]] attributes:dictM];
        
        [tag_btn setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
        
        [tag_btn setAttributedTitle:attrTitle forState:UIControlStateNormal];
        
        [self.tag_btns addObject:tag_btn];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)layoutSubviews
{
    // 按钮布局
    for (int i = 0; i < self.tag_btns.count; ++i) {
        UIButton *tag_btn = self.tag_btns[i];
        [tag_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.TagLabel);
//            make.width.equalTo(@(self.glw_width * 0.14));
            if (tag_btn.tag == 0) {
                make.left.equalTo(self.TagLabel.mas_right).offset(10);
            }else{
                make.left.equalTo(self.preAddBtn.mas_right).offset(10);
            }
            self.preAddBtn = tag_btn;
        }];
    }
}








- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
