//
//  IJKHistory.m
//  pack_ijkplayer
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "IJKHistoryItem.h"

@implementation IJKHistoryItem

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.title forKey:@"isLiveVideo"];
    [aCoder encodeObject:self.title forKey:@"isFullScreen"];
    
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.title = [coder decodeObjectForKey:@"title"];
        self.url = [coder decodeObjectForKey:@"url"];
        self.url = [coder decodeObjectForKey:@"isLiveVideo"];
        self.url = [coder decodeObjectForKey:@"isFullScreen"];
    }
    return self;
}

@end


@interface IJKHistory ()

@end

@implementation IJKHistory {
    NSMutableArray *_list;
}

+ (instancetype)instance {
    static IJKHistory *s_obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_obj = [[IJKHistory alloc] init];
    });
    
    return s_obj;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _list = [NSKeyedUnarchiver unarchiveObjectWithFile:[self dbfilePath]];
        if (nil == _list)
            _list = [NSMutableArray array];
    }
    return self;
}

- (NSString *)dbfilePath {
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSAllDomainsMask, YES) firstObject];
    libraryPath = [libraryPath stringByAppendingPathComponent:@"ijkhistory.plist"];
    
    return libraryPath;
}

- (NSArray *)list {
    return _list;
}

- (void)removeAtIndex:(NSUInteger)index {
    [_list removeObjectAtIndex:index];
    
    [NSKeyedArchiver archiveRootObject:_list toFile:[self dbfilePath]];
}

- (void)add:(IJKHistoryItem *)item {
    __block NSUInteger findIdx = NSNotFound;
    
    [_list enumerateObjectsUsingBlock:^(IJKHistoryItem *enumItem, NSUInteger idx, BOOL *stop) {
        if ([enumItem.url isEqual:item.url]) {
            findIdx = idx;
            *stop = YES;
        }
    }];
    
    if (NSNotFound != findIdx) {
        [_list removeObjectAtIndex:findIdx];
    }
    
    [_list insertObject:item atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_list toFile:[self dbfilePath]];
}

@end