//
//  GLRecommedCell.h
//  revaluation_Bili
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLRecommedCellViewModel;

@interface GLRecommedCell : UITableViewCell

@property (strong, nonatomic) GLRecommedCellViewModel * viewModel;

/** 传递给控制器视频播放需要的数据 */
@property (nonatomic, strong) void((^Videodata)(NSString *aid));

@end
