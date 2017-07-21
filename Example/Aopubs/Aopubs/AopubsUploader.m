//
//  AopubsUploader.m
//  Aopubs
//
//  Created by 小发工作室 on 2017/7/19.
//  Copyright © 2017年 wangxiaofa. All rights reserved.
//

#import "AopubsUploader.h"

static AopubsUploader *_aopubsUploader = nil;

@implementation AopubsUploader

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _aopubsUploader = [self new];
    });
    return _aopubsUploader;
}

- (void)uploadUbsWithMethod:(AopubsUploaderMethod)method
                        URL:(NSString *)urlString
                  parameter:(id)parameter
             completedBlock:(AopubsUploaderCompletedBlock)completedBlock
                      error:(AopubsUploaderError)errorBlock{
    
    
    if (urlString.length == 0) {
        
        NSLog(@"url is null, please check it out ");
        
        return;
    }
    
    if (method == AopubsUploaderGetMethod) {
        
        NSLog(@"get method uploader does not write");
    }
    else if (method == AopubsUploaderPostMethod) {
        
        [self postUploadUbsWithURL:urlString parameter:parameter completedBlock:completedBlock error:errorBlock];
        
    }
    else {
        NSLog(@"uploader method is error");
    }
    
}

- (void)postUploadUbsWithURL:(NSString *)urlString
                   parameter:(id)parameter
              completedBlock:(AopubsUploaderCompletedBlock)completedBlock
                       error:(AopubsUploaderError)errorBlock{
    
    NSURLSession *session        = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.HTTPMethod           = @"POST";
    
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:parameter
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSURLSessionTask *uploadTask = [session dataTaskWithRequest:request
                                              completionHandler:^(NSData * _Nullable data,
                                                                  NSURLResponse * _Nullable response,
                                                                  NSError * _Nullable error) {
                                                  
                                                  if (error) {
                                                      
                                                      errorBlock(error);
                                                  }
                                                  else {
                                                      
                                                      completedBlock(data);
                                                  }
    }];
    
    [uploadTask resume];
}
@end
