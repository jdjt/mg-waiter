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

//  获取Waiter参数表
- (DBWaiterInfo *)getWaiterInfo:(NSString *)waiterId{

    NSString * waiteridString = waiterId;
    if (waiteridString == nil) {
        waiteridString = [MySingleton sharedSingleton].waiterId;
    }
    
    DBWaiterInfo * waiterInfo = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"waiterId = %@", waiteridString];
    NSArray *result = [self arrayFromCoreData:@"DBWaiterInfo" predicate:predicate limit:NSIntegerMax offset:0 orderBy:nil];
    if (result.count<= 0 || result == nil){
        waiterInfo = (DBWaiterInfo *)[self insertIntoCoreData:@"DBWaiterInfo"];
    }
    else
        waiterInfo = result.firstObject;
    return waiterInfo;

}
/**
 获取任务参数表
 @param taskCode 任务编号
 */
- (TaskList *)getTask:(NSString *)taskCode{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"taskCode = %@", taskCode];
    NSArray *result = [self arrayFromCoreData:@"TaskList" predicate:predicate limit:NSIntegerMax offset:0 orderBy:nil];
    TaskList * taskModel = nil;
    if (result.count > 0) {
        return result.firstObject;
    }
    return taskModel;
    
}

@end
