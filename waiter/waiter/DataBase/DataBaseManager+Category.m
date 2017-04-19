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

    DBWaiterInfo * waiterInfo = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"waiterId = %@", waiterId];
    NSArray *result = [self arrayFromCoreData:@"DBWaiterInfo" predicate:predicate limit:NSIntegerMax offset:0 orderBy:nil];
    if (result.count<= 0 || result == nil)
    {
        waiterInfo = (DBWaiterInfo *)[self insertIntoCoreData:@"DBWaiterInfo"];
        waiterInfo.taskList = [[NSOrderedSet alloc]init];
        
    }
    else
        waiterInfo = result.firstObject;
    return waiterInfo;

}
/**
 获取任务参数表
 @param waiterId waiterId
 @param taskCode 任务编号
 */
- (TaskList *)getTaskInfoWaiterId:(NSString *)waiterId TaskCode:(NSString *)taskCode{
    DBWaiterInfo * waiterInfo = [self getWaiterInfo:waiterId];
    
    NSArray * taskListArray = [waiterInfo.taskList array];
    TaskList * taskList = nil;
    for (TaskList * taskListModel in taskListArray) {
        if ([taskListModel.taskCode isEqualToString:taskCode]) {
            taskList = taskListModel;
            break;
        }
    }
    
    return taskList;
    
}

@end
