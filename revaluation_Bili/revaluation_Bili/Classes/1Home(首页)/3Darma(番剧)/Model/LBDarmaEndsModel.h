//
//  LBDarmaEndsModel.h
//  Bili
//
//  Created by 林彬 on 16/5/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBDarmaEndsModel : NSObject
@property(nonatomic ,strong) NSString *cover;

@property(nonatomic ,strong) NSString *last_time;

@property(nonatomic ,strong) NSString *newest_ep_id;

@property(nonatomic ,strong) NSString *newest_ep_index;

@property(nonatomic ,strong) NSString *season_id;

@property(nonatomic ,strong) NSString *title;

@property(nonatomic ,strong) NSString *total_count;

@property(nonatomic ,strong) NSString *watchingCount;

@property(nonatomic , assign) CGFloat cellHeight;
@end
