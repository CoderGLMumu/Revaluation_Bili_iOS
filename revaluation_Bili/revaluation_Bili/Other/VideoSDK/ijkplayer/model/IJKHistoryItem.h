//
//  IJKHistory.h
//  pack_ijkplayer
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IJKHistoryItem : NSObject

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSURL *url;
@property(nonatomic,assign) BOOL isLiveVideo;
@property(nonatomic,assign) BOOL isFullScreen;

@end

@interface IJKHistory : NSObject

+ (instancetype)instance;

@property(nonatomic,strong,readonly) NSArray *list;

- (void)removeAtIndex:(NSUInteger)index;
- (void)add:(IJKHistoryItem *)item;

@end
