//
//  Aopubs.m
//  Aopubs
//
//  Created by 小发工作室 on 2017/7/18.
//  Copyright © 2017年 wangxiaofa. All rights reserved.
//

#import "Aopubs.h"
#import "objc/runtime.h"
#import "AopubsUploader.h"
#import "AopubsCache.h"

// key for ubs
static const NSString * ControllerUbsKey       = @"controller_ubs";
static const NSString * ButtonEventUbsKey      = @"button_ubs";
static const NSString * TableViewCellUbsKey    = @"tableviewcell_ubs";
static const NSString * SingleGestureTapUbsKey = @"single_gesture_tap_ubs";

//policy for upload ubs data
// maxumin count
static const int MaxUploadCount                = 10;

// single ton
static Aopubs * _AopubsInstance                = nil;

@implementation Aopubs
{
    NSArray *_uploadArr;
}

- (NSMutableArray *)eventArr {
    if (_eventArr == nil) {
        
        NSArray *ubsRemainArr = [[AopubsCache shareInstance] readRemainUbsFileFromCache];

        _eventArr             = [[NSMutableArray alloc] initWithArray:ubsRemainArr];
        
        [[AopubsCache shareInstance] removeRemainUbsFileInCache];

    }
    return _eventArr;
}

+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _AopubsInstance = [self new];
    });
    
    return _AopubsInstance;
}

#pragma mark -Public

- (void)defaultConfig {
    
    [self configureDicWithPlistFile:@"AopusbConfig"];
    [self addUbsForControllerWithState:AopubsControllerWillAppearState|AopubsControllerDidAppearState];
    [self addUbsForButtonEvent];
    [self addUbsForTableViewCellSelectWithState:AopubsTableViewCellDidSelectState];
    [self addUbsForSingleGestureSingleTap];
}

- (void)configureDicWithPlistFile:(NSString *)name {
    
    NSDictionary *configDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name
                                                                                                         ofType:@"plist"]];
    if (configDic != nil) {
        _configDic = [configDic copy];
    
    }
    else {
        NSLog(@"the config dic is nil");
        return;
    }
}


#pragma mark -Add Ubs

- (void)addUbsForControllerWithState:(AopubsControllerState)controllerState {
    
    AopubsControllerState state = 0;
    
    if (controllerState & AopubsControllerNoState) {
        NSLog(@"dont need to set ubs for controller");
        return;
    }
    if (controllerState & AopubsControllerWillAppearState) {
        state |= AopubsControllerWillAppearState;
    }
    if (controllerState & AopubsControllerDidAppearState) {
        state |= AopubsControllerDidAppearState;
    }
    if (controllerState & AopubsControllerWillDisappearState) {
        state |= AopubsControllerWillDisappearState;
    }
    if (controllerState & AopubsControllerDidDisappearState) {
        state |= AopubsControllerDidDisappearState;
    }
    
    [self addUbsFromDicForControllerWith:state];
}

- (void)addUbsForButtonEvent{
    
    [self addUbsFromDicForButtonEvent];

}

- (void)addUbsForTableViewCellSelectWithState:(AopubsTableViewCellSelectState)tableViewCellstate {
    
    AopubsTableViewCellSelectState state = 0;
    
    if (tableViewCellstate & AopubsTableViewCellSelectNoState) {
        NSLog(@"dont need to set ubs for tableView select");
        return;
    }
    
    if (tableViewCellstate & AopubsTableViewCellWillSelectState) {
        state |= AopubsTableViewCellWillSelectState;
    }
    if (tableViewCellstate & AopubsTableViewCellDidSelectState) {
        state |= AopubsTableViewCellDidSelectState;
    }
    
    [self addUbsFromDicForTableViewCellSelectWithState:state];
    
}

- (void)addUbsForSingleGestureSingleTap {
    
    [self addUbsFromDicForSingleGestureTap];
    
}


#pragma mark -Private

- (void)addUbsFromDicForControllerWith:(AopubsControllerState)state {
    
    
    [self addUbsForClassWithUbsKey:ControllerUbsKey state:state];
    
}

- (void)addUbsFromDicForButtonEvent {
    
    [self addUbsForClassWithUbsKey:ButtonEventUbsKey state:0];

}

- (void)addUbsFromDicForTableViewCellSelectWithState:(AopubsTableViewCellSelectState)state {
    
    [self addUbsForClassWithUbsKey:TableViewCellUbsKey state:state];
    
}

- (void)addUbsFromDicForSingleGestureTap{
    
    [self addUbsForClassWithUbsKey:SingleGestureTapUbsKey state:0];
    
}

- (void)addUbsForClassWithUbsKey:(const NSString *)key state:(int)state{
    
    if (key == ControllerUbsKey) {
        
        for (NSString *controller_name in _configDic[key]) {
            
            Class target = NSClassFromString(controller_name);
            
            
            id controller = [target new];
            
            if (controller == nil) {
                
                NSLog(@"%@ is not found for controller ubs", controller_name);
                
                return;
            }
            
            if (state & AopubsControllerWillAppearState) {
                
                [self targetControllerClass:target aspect_hookSelectorString:@"viewWillAppear:"];
                
            }
            if (state & AopubsControllerDidAppearState) {
                
                [self targetControllerClass:target aspect_hookSelectorString:@"viewDidAppear:"];
                
            }
            if (state & AopubsControllerWillDisappearState) {
                
                [self targetControllerClass:target aspect_hookSelectorString:@"viewWillDisappear:"];
                
            }
            if (state & AopubsControllerDidDisappearState) {
                [self targetControllerClass:target aspect_hookSelectorString:@"viewDidDisappear:"];
            }
            
        }

        
    }
    else if (key == TableViewCellUbsKey) {
        
        for (NSString *controller_name in _configDic[key]) {
            
            Class target = NSClassFromString(controller_name);
            
            
            id controller = [target new];
            
            if (controller == nil) {
                
                NSLog(@"%@ is not found for tableView cell select ubs", controller_name);
                
                return;
            }
            
            if (state & AopubsTableViewCellWillSelectState) {
                
                [self targetControllerClass:target aspect_hookSelectorString:@"tableView:willSelectRowAtIndexPath:"];
                
            }
            if (state & AopubsTableViewCellDidSelectState) {
                
                [self targetControllerClass:target aspect_hookSelectorString:@"tableView:didSelectRowAtIndexPath:"];
                
            }
            
        }

    }
    else if (key == ButtonEventUbsKey) {
        
        for (NSString *controller_name in _configDic[key]) {
            
            Class controller_class = NSClassFromString(controller_name);
            
            id controller          = [controller_class new];
            
            if (controller) {
                
                for (NSString *selector in _configDic[ButtonEventUbsKey][controller_name]) {
                    
                    [self targetControllerClass:controller_class aspect_hookSelectorString:selector];
                    
                }
                
            }
            else
            {
                NSLog(@"controller %@ is not found for ubs with key %@", controller_name, key);
            }
        }

    }
    else if (key == SingleGestureTapUbsKey) {
        
        for (NSString *controller_name in _configDic[key]) {
            
            Class controller_class = NSClassFromString(controller_name);
            
            id controller          = [controller_class new];
            
            if (controller) {
                
                for (NSString *selector in _configDic[SingleGestureTapUbsKey][controller_name]) {
                    
                    [self targetControllerClass:controller_class aspect_hookSelectorString:selector];
                    
                }
                
            }
            else
            {
                NSLog(@"controller %@ is not found for ubs with key %@", controller_name, key);
            }
        }
        
    }
    

}

- (void)targetControllerClass:(Class)controllerClass aspect_hookSelectorString:(NSString *)selectorString {
    
    [controllerClass aspect_hookSelector:NSSelectorFromString(selectorString)
                             withOptions:AspectPositionAfter
                              usingBlock:^(id data) {
                                  
                                  if (_delegate) {
                                      
                                      [_delegate handlUbsEventWithData:data];
                                  }
                                  else
                                  {
                                      // default handle if delegate is nil
                                      [self defaultHandlUbsEventWithData:data];
                                  }
                                  
    }error:NULL];
    
}

#pragma mark -Default Handle Event

- (void)defaultHandlUbsEventWithData:(id <AspectInfo>)data  {
    
    NSString *controller_name = NSStringFromClass([[data instance] class]);
    
    NSString *selectorString = [NSStringFromSelector([data originalInvocation].selector) substringFromIndex:9];
    NSLog(@"controller is :%@, method is:%@", controller_name, selectorString);

    // current time
    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime        = [formatter stringFromDate:[NSDate date]];
    
    // parameter
    NSDictionary *ubs_data = @{@"event_id":selectorString,@"user_id":@"1",@"time":dateTime};
    
    [self.eventArr addObject:ubs_data];
    
    if ([self.eventArr count] >= MaxUploadCount) {
        
        id parameter = [self.eventArr subarrayWithRange:NSMakeRange(0, 10)];
        _uploadArr   = [parameter copy];
        
        [[AopubsUploader shareInstance] uploadUbsWithMethod:AopubsUploaderPostMethod
                                                        URL:_uploadURL
                                                  parameter:parameter
                                             completedBlock:^(id  _Nullable completedBlock){
                                                 
                                                 NSLog(@"success upload ubs");
                                                 [self.eventArr removeObjectsInArray:_uploadArr];
            
        } error:^(id  _Nullable errorBlock) {
            
            NSLog(@"fail to  upload ubs");
            
        }];
        
        
        
    }
    
   // NSLog(@"%d", self.eventArr.count);

}


@end
