//
//  GLMotiveSealCell.m
//  Bili
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "GLMotiveSealCell.h"
#import "GLMotiveSealCellItem.h"

@interface GLMotiveSealCell ()
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *last_ep_index;
@property (weak, nonatomic) IBOutlet UILabel *total_count;


@end

@implementation GLMotiveSealCell

+ (instancetype)cellWithTableView:(UITableView *)tableView AndIdentifier:(NSString *)ID
{
    GLMotiveSealCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}
/** 看到第 last_ep_index 话/total_count话全  title番剧名称  cover图片*/
- (void)setItem:(GLMotiveSealCellItem *)item
{
    [self.cover sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.title.text = item.title;
    
    self.total_count.text = [NSString stringWithFormat:@"%@话全",item.total_count];
    
    if ([item.last_ep_index isEqualToString:@"0"]) {
        self.last_ep_index.text = @"尚未观看";
    }else{
        self.last_ep_index.text =[NSString stringWithFormat:@"观看到%@话",item.last_ep_index];
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
