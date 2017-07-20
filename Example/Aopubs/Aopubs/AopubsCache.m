//
//  AopubsCache.m
//  Aopubs
//
//  Created by 小发工作室 on 2017/7/19.
//  Copyright © 2017年 wangxiaofa. All rights reserved.
//

#import "AopubsCache.h"

NSString * const AopubsCachePathForRemainFile = @"TempFile";
NSString * const AopubsRemainFileName         = @"remainUbs";

static AopubsCache *_aopubsCache = nil;

@implementation AopubsCache

#pragma mark -Public

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _aopubsCache = [self new];
    });
    return _aopubsCache;
}

- (void)saveRemainUbsWithData:(id)data {

    if (data == nil) {
        return;
    }
    
    NSString *filePath = [self getFullPathForRemainUsbFile];

    NSData *json_data  = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];

    BOOL result        = [json_data writeToFile:filePath atomically:YES];

    if (result) {
        NSLog(@"临时ubs保存成功");
    }
    else {
        NSLog(@"临时ubs保存失败");
    }
}

- (id)readRemainUbsFileFromCache{
    
    NSData *json_data = [NSData dataWithContentsOfFile:[self getFullPathForRemainUsbFile]];

    id data           = [NSJSONSerialization JSONObjectWithData:json_data options:NSJSONReadingMutableContainers error:nil];
    
    return data;
}

- (BOOL)removeRemainUbsFileInCache {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *filePath = [self getFullPathForRemainUsbFile];

    if ([fileManager fileExistsAtPath:filePath]) {
        BOOL flag = [fileManager removeItemAtPath:filePath error:nil];
        return flag;
    }
    
    return NO;
    
}

- (NSString *)getFullPathForRemainUsbFile{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:AopubsCachePathForRemainFile];
    
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }

    NSString *filePath = [path stringByAppendingPathComponent:AopubsRemainFileName];
    
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    return filePath;
    
}

#pragma mark -Private

@end
