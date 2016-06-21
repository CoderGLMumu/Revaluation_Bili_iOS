//
//  GLDynamicCell.m
//  Bili
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "GLDynamicCell.h"

#import "GLDynamicCellItem.h"

#import "GLPublishedPassTime.h"

@interface GLDynamicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;

@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *play;
@property (weak, nonatomic) IBOutlet UILabel *create;

@property (weak, nonatomic) IBOutlet UILabel *video_review;
@end

@implementation GLDynamicCell

+ (instancetype)cellWithTableView:(UITableView *)tableView AndIdentifier:(NSString *)ID
{
    GLDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}
/** 头像avatar  用户名author  时间ctime 简缩图片pic  标题title  播放量play
 video_review 弹幕数量    description介绍  create创建时间
 */
- (void)setItem:(GLDynamicCellItem *)item
{

    [self.avatar sd_setImageWithURL:[NSURL URLWithString:item.avatar] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.author.text = item.author;
    
    [self.pic sd_setImageWithURL:[NSURL URLWithString:item.pic] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.title.text = item.title;
    self.play.text = item.play;
    self.video_review.text = item.video_review;
    
//    GLLog(@"%@",item.create);
    //计算发布时间差值
    
    //获得服务器返回时间[发布时间]
//    self.create.text = [GLPublishedPassTime PublishedPassTime:item.create];
    
    /** 
     [[GLPublishedPassTime sharePublishedPassTime] PublishedPassTimeWithTimeNSString:item.create result:^(NSString *passTimes_str) {
     self.create.text = passTimes_str;
     }];
     */
    
    self.create.text = [GLPublishedPassTime sharePublishedPassTime].passTime(item.create).passTimes_str;
    
}
- (IBAction)avatarClick:(UIButton *)sender {
    GLLog(@"通知控制器跳转到用户信息界面");
    //通知控制器跳转到用户信息界面
//    [self.]
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
