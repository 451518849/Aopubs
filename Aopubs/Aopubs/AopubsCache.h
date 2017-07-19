//
//  AopubsCache.h
//  Aopubs
//
//  Created by 小发工作室 on 2017/7/19.
//  Copyright © 2017年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AopubsCache : NSObject

+ (_Nonnull instancetype)shareInstance;

- (NSString *_Nullable)getFullPathForRemainUsbFile;

- (void)saveRemainUbsWithData:(id _Nonnull)data;

- (id _Nullable )readRemainUbsFileFromCache;

- (BOOL)removeRemainUbsFileInCache;

@end
