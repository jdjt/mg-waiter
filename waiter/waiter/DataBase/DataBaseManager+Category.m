//
//  DataBaseManager+Category.m
//  waiter
//
//  Created by new on 2017/4/18.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "DataBaseManager+Category.h"
#import "PDKeyChain.h"
@implementation DataBaseManager (Category)
- (DBDeviceInfo *)getDeviceInfo{
    
    DBDeviceInfo * deviceInfo = nil;
    NSArray *result = [self arrayFromCoreData:@"DBDeviceInfo" predicate:nil limit:NSIntegerMax offset:0 orderBy:nil];
    if (result.count<= 0 || result == nil)
    {
        deviceInfo = (DBDeviceInfo *)[self insertIntoCoreData:@"DBDeviceInfo"];
        NSString * deviceId = @"";
                if (![PDKeyChain keyChainLoad])
                {
                    deviceId = [Util getUUID];
                    [PDKeyChain keyChainSave:deviceId];
                }else
                {
                    deviceId = [PDKeyChain keyChainLoad];
                }
        deviceInfo.deviceId = deviceId;
        deviceInfo.deviceToken = @"1";
    }
    else
        deviceInfo = result.firstObject;
    return deviceInfo;
    
}
/**
 * @abstract 获取登录者的参数表
 */
- (DBLogInInfo *)getLogInInfo;{
    
    DBLogInInfo * logInfo = nil;
    NSArray *result = [self arrayFromCoreData:@"DBLogInInfo" predicate:nil limit:NSIntegerMax offset:0 orderBy:nil];
    if (result.count<= 0 || result == nil)
    {
        logInfo = (DBLogInInfo *)[self insertIntoCoreData:@"DBLogInInfo"];
        logInfo.waiterInfo = (DBWaiterInfo *)[self insertIntoCoreData:@"DBWaiterInfo"];
    }
    else
        logInfo = result.firstObject;
    return logInfo;
    
}
/**
 * @abstract 获取Waiter参数表
 */
- (DBWaiterInfo *)getWaiterInfo{

    DBLogInInfo * logInfo = [self getLogInInfo];
    
    return logInfo.waiterInfo;

}

@end
