//
//  GLPartitionViewController.h
//  Bili
//
//  Created by mac on 16/4/23.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLPartitionViewController : UICollectionViewController

/** 点击直播按钮的消息 */
@property (nonatomic, copy) void(^ClickLiveButton)();

@end
