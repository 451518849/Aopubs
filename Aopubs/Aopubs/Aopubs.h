//
//  Aopubs.h
//  Aopubs
//
//  Created by 小发工作室 on 2017/7/18.
//  Copyright © 2017年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Aspects.h"

typedef NS_OPTIONS(NSInteger, AopubsControllerState) {
    
    // dont set ubs for controller
    AopubsControllerNoState             = 1 << 0,
    
    //set ubs for controller when it will appear
    AopubsControllerWillAppearState     = 1 << 1,
    
    //set ubs for controller when it  appeared
    AopubsControllerDidAppearState      = 1 << 2,

    //set ubs for controller when it will disappear
    AopubsControllerWillDisappearState  = 1 << 3,

    //set ubs for controller when it disappeared
    AopubsControllerDidDisappearState   = 1 << 4,

};

typedef NS_OPTIONS(NSInteger, AopubsTableViewCellSelectState) {
    
    //dont set ubs for tableView cell select
    AopubsTableViewCellSelectNoState =  1 << 0,
    
    //set ubs for tableView cell when it will select
    AopubsTableViewCellWillSelectState = 1 << 1,
    
    //set ubs for tableView cell when it selected
    AopubsTableViewCellDidSelectState = 1 << 2,

};


@protocol AopubsDelegate <NSObject>

@optional

- (void)handlUbsEventWithData:(_Nullable id<AspectInfo>)data;

@end

@interface Aopubs : NSObject

@property (nonatomic, nullable, readonly) NSDictionary   *configDic;

@property (nonatomic, nullable          ) NSMutableArray *eventArr;

@property (nonatomic, nullable          ) id <AopubsDelegate> delegate;

@property (nonatomic, nullable          ) NSString       *uploadURL;


+ (instancetype _Nullable )shareInstance;

- (void)defaultConfig;

- (void)configureDicWithPlistFile:(NSString *_Nullable)name;

- (void)addUbsForControllerWithState:(AopubsControllerState)controllerState;

- (void)addUbsForButtonEvent;

- (void)addUbsForSingleGestureSingleTap;

- (void)addUbsForTableViewCellSelectWithState:(AopubsTableViewCellSelectState)tableViewCellstate;

@end
