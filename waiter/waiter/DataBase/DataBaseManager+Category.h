//
//  DataBaseManager+Category.h
//  waiter
//
//  Created by new on 2017/4/18.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "DataBaseManager.h"
#import "DBDeviceInfo+CoreDataClass.h"
#import "DBWaiterInfo+CoreDataClass.h"
#import "TaskList+CoreDataClass.h"
@interface DataBaseManager (Category)


/**
 * @abstract 获取设备参数表
 */
- (DBDeviceInfo *)getDeviceInfo;


/**
 获取Waiter参数表
 
 @param waiterId waiterId
 */
- (DBWaiterInfo *)getWaiterInfo:(NSString *)waiterId;

/**
 获取任务参数表
 @param taskCode 任务编号
 */
- (TaskList *)getTask:(NSString *)taskCode;

@end
