//
//  GLConvertNSStringToInt.m
//  revaluation_Bili
//
//  Created by mac on 16/6/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLConvertNSStringToInt.h"

@implementation GLConvertNSStringToInt

+ (int)convertToInt:(NSString*)strtemp {
    
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength + 1) / 2;
    
}

@end
