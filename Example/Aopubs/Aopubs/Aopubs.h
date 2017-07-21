//
//  Aopubs.h
//  Aopubs
//
//  Created by 小发工作室 on 2017/7/18.
//  Copyright © 2017年 wangxiaofa. All rights reserved.
//


// the full name of ubs here we call is ‘user behavior statistics’(用户行为统计)

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

// the dictionary for which usb should be monitor
@property (nonatomic, nullable, readonly) NSDictionary   *configDic;

// the event of usb that have been monitor
@property (nonatomic, nullable          ) NSMutableArray *eventArr;

// the delegate you mybe implement to customly upload data
@property (nonatomic, nullable          ) id <AopubsDelegate> delegate;

// the web url
@property (nonatomic, nullable          ) NSString       *uploadURL;

// the enough count for ubs to upload, default count is 10
@property (nonatomic, assign            ) int            maxCountOfUploadEvent;

+ (instancetype _Nullable )shareInstance;

/**
 * the default configuration if you dont need to customly configurate
 * here add button event, single gesture event, tableview cell event
 */
- (void)defaultConfig;

/**
 *  to init configDic with AopusbConfig.plist, this is necessary
 */
- (void)configureDicWithPlistFile:(NSString *_Nullable)name;

/**
 *  @praram controllerState the state of controller load state
 *  to add what controller state you want to monitor, which will be composede of ubs
 */
- (void)addUbsForControllerWithState:(AopubsControllerState)controllerState;

/**
 * to add what button event you want to monitor, which will be composede of ubs
 */
- (void)addUbsForButtonEvent;

/**
 * to add what single gesture event you want to monitor, which will be composede of ubs
 */
- (void)addUbsForSingleGestureSingleTap;

/**
 *  @praram tableViewCellstate the state of tableView cell select state
s */
- (void)addUbsForTableViewCellSelectWithState:(AopubsTableViewCellSelectState)tableViewCellstate;

@end
