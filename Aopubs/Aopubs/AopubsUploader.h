//
//  AopubsUploader.h
//  Aopubs
//
//  Created by 小发工作室 on 2017/7/19.
//  Copyright © 2017年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AopubsUploaderMethod) {
    
    AopubsUploaderGetMethod = 1,
    
    AopubsUploaderPostMethod = 2,
};

typedef void(^AopubsUploaderCompletedBlock)(id _Nullable completedBlock);

@interface AopubsUploader : NSObject

+ (_Nonnull instancetype)shareInstance;

- (void)uploadUbsWithMethod:(AopubsUploaderMethod)method
                        URL:(NSString *_Nullable)urlString
                  parameter:(id _Nullable )parameter
             completedBlock:(AopubsUploaderCompletedBlock _Nullable )completedBlock;


@end
