//
//  DataParser.m
//  waiter
//
//  Created by new on 2017/4/13.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "DataParser.h"
#import "DataBaseManager+Category.h"
#import "TaskList+CoreDataProperties.h"
#import "DBWaiterInfo+CoreDataClass.h"
#import "HistoricalStatistics+CoreDataClass.h"
#import "NSString+Addtions.h"
@implementation DataParser
+(id)parserUrl:(NSString*)ident fromData:(id)dict{

    id dataSource = nil;
    
    if ([ident isEqualToString:URI_WAITER_Login]) {
      dataSource =  [DataParser parsingWaiterLogIn:dict];/* 服务员登录 */
    }
    if ([ident isEqualToString:URI_WAITER_AttendStatus]) {
        dataSource =  [DataParser parsingWaiterAttendStatus:dict];/* 服务员状态 */
    }
    if ([ident isEqualToString:URI_WAITER_UpdatePass]) {
        dataSource =  [DataParser parsingWaiterUpdatePass:dict];/* 服务员修改密码 */
    }
    
    if ([ident isEqualToString:URI_WAITER_Logout]) {
        dataSource =  [DataParser parsingWaiterLogout:dict];/* 服务员登出 */
    }
    
    if ([ident isEqualToString:URI_WAITER_WaiterInfoByWaiterId]) {
        dataSource =  [DataParser parsingWaiterInfoByWaiterId:dict];/* 获取服务员信息 */
    }
    
    if ([ident isEqualToString:URI_WAITER_SetWorkStatus]) {
        dataSource =  [DataParser parsingWaiterSetWorkStatus:dict];/* 服务员工作状态设置“开始接单”、“停止接单” */
    }
    
    if ([ident isEqualToString:URI_WAITER_TaskAfterAccept]) {
        dataSource =  [DataParser parsingWaiterTaskAfterAccept:dict];/* 服务员“开始接单”后获取进行中任务列表 */
    }
    
    
    if ([ident isEqualToString:URI_WAITER_UpdateMapInfo]) {
        dataSource =  [DataParser parsingWaiterUpdateMapInfo:dict];/* 服务员上传位置信息 */
    }
    
    if ([ident isEqualToString:URI_WAITER_AcceptTask]) {
        dataSource =  [DataParser parsingWaiterAcceptTask:dict];/* 服务员“抢单” */
    }
    
    if ([ident isEqualToString:URI_WAITER_ConfirmTask]) {
        dataSource =  [DataParser parsingWaiterConfirmTask:dict];/* 服务员“确认”完成呼叫任务 */
    }
    
    if ([ident isEqualToString:URI_WAITER_GetTaskInfo]) {
        dataSource =  [DataParser parsingWaiterGetTaskInfo:dict];/* 服务员获取任务信息 */
    }
    
    if ([ident isEqualToString:URI_WAITER_GetTaskInfoByTaskCode]) {
        dataSource =  [DataParser parsingWaiterGetTaskInfoByTaskCode:dict];/* 服务员根据任务号获取任务信息 */
    }
    
    if ([ident isEqualToString:URI_WAITER_GetTaskInfoStatic]) {
        dataSource =  [DataParser parsingWaiterGetTaskInfoStatic:dict];/* 服务员查询"历史任务统计" */
    }
    
    if ([ident isEqualToString:URI_WAITER_GetMessageByTaskCode]) {
        dataSource =  [DataParser parsingWaiterGetMessageByTaskCode:dict];/* 服务员根据任务号获取聊天信息 */
    }
    
    if ([dataSource isKindOfClass:[NSManagedObject class]]) {
        [[DataBaseManager defaultInstance] saveContext];
    }
    
    return dataSource;

}
//解析RetOk
+(BOOL)parsingRetOk:(id)dict{
    NSDictionary * responseObject = dict;
    if ([responseObject[@"retOk"] isEqualToString:@"0"]) {
        return YES;
    }
    return NO;

}

//服务员登录
+(id)parsingWaiterLogIn:(id)dict{
    
    
    if (![self parsingRetOk:dict]) {
         return [NSNumber numberWithBool:NO];
    }
    
    NSDictionary * responseObject = dict;
    
    NSString * waterId = responseObject[@"waiterId"];
    
    [MySingleton sharedSingleton].waiterId = waterId;
    DBWaiterInfo * waiterInfo = [[DataBaseManager defaultInstance] getWaiterInfo:waterId];
    
    waiterInfo.waiterId = waterId;
    [waiterInfo setValuesForKeysWithDictionary:responseObject];
    NSDictionary * waiterInfoDic = responseObject[@"waiterInfo"];
    [waiterInfo setValuesForKeysWithDictionary:waiterInfoDic];
    
    NSLog(@"waiterInfo --- > %@",waiterInfo);
    
    return waiterInfo;

}
//服务员状态
+(DBWaiterInfo *)parsingWaiterAttendStatus:(id)dict{

    NSDictionary * responseObject = dict;
    
    DBWaiterInfo * waiterInfo = [[DataBaseManager defaultInstance] getWaiterInfo:[MySingleton sharedSingleton].waiterId];
    waiterInfo.workStatus = responseObject[@"workStatus"];
    waiterInfo.attendStatus = responseObject[@"attendStatus"];
    return waiterInfo;

}

//服务员修改密码
+(NSNumber *)parsingWaiterUpdatePass:(id)dict{
    NSNumber * value = [NSNumber numberWithBool:[DataParser parsingRetOk:dict]];
    return value;
}

//服务员登出
+(NSNumber *)parsingWaiterLogout:(id)dict{
   NSNumber * value = [NSNumber numberWithBool:[DataParser parsingRetOk:dict]];
    return value;
}
//获取服务员信息
+(DBWaiterInfo *)parsingWaiterInfoByWaiterId:(id)dict{
    NSDictionary * responseObject = dict;
    
   DBWaiterInfo * waiterInfo = [[DataBaseManager defaultInstance] getWaiterInfo:[MySingleton sharedSingleton].waiterId];
    
    [waiterInfo setValuesForKeysWithDictionary:responseObject];
    return waiterInfo;
}
//服务员工作状态设置“开始接单”、“停止接单”
+(NSNumber *)parsingWaiterSetWorkStatus:(id)dict{
    NSNumber * value = [NSNumber numberWithBool:[DataParser parsingRetOk:dict]];
    
    return value;
}
//服务员“开始接单”后获取进行中任务列表
+(NSMutableArray *)parsingWaiterTaskAfterAccept:(id)dict{
    NSMutableArray * dataArray = [[NSMutableArray alloc]init];
    
//#warning 服务员“开始接单”后获取进行中任务列表
  //  NSDictionary * responseObject = dict;
    
    NSArray * responseArray = dict;//[@"taskInfoList"];
    if (![responseArray isKindOfClass:[NSArray class]]) {
        return dataArray;
    }
    DBWaiterInfo * waiterInfo = [[DataBaseManager defaultInstance] getWaiterInfo:nil];
    for (NSDictionary * dic in responseArray) {
        TaskList * taskModel = [DataParser getTaskListOrResponseDic:dic];        
        taskModel.belongWaiterInfor = waiterInfo;
        [waiterInfo addHasTaskListObject:taskModel];
        [dataArray addObject:taskModel];
        
    }
 
    
    return dataArray;
}
//获取单个任务model,并判断数据库中是否存在
+(TaskList *)getTaskListOrResponseDic:(NSDictionary *)dic{

    TaskList * taskModel = [[DataBaseManager defaultInstance] getTask:dic[@"taskCode"]];
    if (taskModel == nil) {
        taskModel = (TaskList *)[[DataBaseManager defaultInstance] insertIntoCoreData:@"TaskList"];
    }
    
    [taskModel setValuesForKeysWithDictionary:dic];
    
    
    if ([[dic objectForKey:@"cancelDetail"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary * canDic = [dic objectForKey:@"cancelDetail"];
            [taskModel setValuesForKeysWithDictionary:canDic];
    }
    if ([[dic objectForKey:@"scoreDesc"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary * canDic = [dic objectForKey:@"scoreDesc"];
        [taskModel setValuesForKeysWithDictionary:canDic];
    }
    
    taskModel.isAnOpen = NO;
    UIFont * font = [UIFont systemFontOfSize:15];
    if (IS_LESS5) {
        font = [UIFont systemFontOfSize:13];
    }
    CGFloat taskContentHerght = [NSString heightFromString:taskModel.taskContent withFont:font constraintToWidth:kScreenWidth - 107];
    taskModel.callContentHeight = taskContentHerght <= 15 ? 15 : ceil(taskContentHerght) ;
    NSLog(@"taskContentHerght---> %f",taskContentHerght);
    NSLog(@"taskModel.callContentHeight---> %f",taskModel.callContentHeight);
    
    return taskModel;

}
//服务员上传位置信息
+(NSNumber *)parsingWaiterUpdateMapInfo:(id)dict{
    NSNumber * value = [NSNumber numberWithBool:[DataParser parsingRetOk:dict]];
    return value;
}
//服务员“抢单”
+(NSNumber *)parsingWaiterAcceptTask:(id)dict{
    NSNumber * value = [NSNumber numberWithBool:[DataParser parsingRetOk:dict]];
    return value;
}
//服务员“确认”完成呼叫任务
+(NSNumber *)parsingWaiterConfirmTask:(id)dict{
    NSNumber * value = [NSNumber numberWithBool:[DataParser parsingRetOk:dict]];
    return value;
}
//服务员获取任务信息
+(NSMutableArray *)parsingWaiterGetTaskInfo:(id)dict{
    NSMutableArray * dataArray = [[NSMutableArray alloc]init];
    
//#warning 服务员获取任务信息
    
    
    NSArray * responseArray = dict;
    if (![responseArray isKindOfClass:[NSArray class]]) {
        return dataArray;
    }
    for (NSDictionary * dic in responseArray) {
        [dataArray addObject:[DataParser getTaskListOrResponseDic:dic]];
    }
    return dataArray;
}
//服务员根据任务号获取任务信息
+(TaskList *)parsingWaiterGetTaskInfoByTaskCode:(id)dict{
    TaskList * taskListModel = [DataParser getTaskListOrResponseDic:dict];
 //#warning TaskList
    
    return taskListModel;
}
//服务员查询"历史任务统计"
+(NSMutableArray *)parsingWaiterGetTaskInfoStatic:(id)dict{
    NSMutableArray * dataArray = [[NSMutableArray alloc]init];
    NSDictionary * responseObject = dict;
    DBWaiterInfo * waiterinfo = [[DataBaseManager defaultInstance] getWaiterInfo:nil];
    if (waiterinfo.hasHistoriceStatiscs == nil) {
        waiterinfo.hasHistoriceStatiscs = (HistoricalStatistics *)[[DataBaseManager defaultInstance]insertIntoCoreData:@"HistoricalStatistics"];
    }
    HistoricalStatistics * hStatistics = waiterinfo.hasHistoriceStatiscs;
    [hStatistics setValuesForKeysWithDictionary:responseObject];
    
    NSArray * responseArray = responseObject[@"taskInfoList"];
    if (![responseArray isKindOfClass:[NSArray class]]) {
       return dataArray;
    }
    [hStatistics removeHasHisStaTaskList:hStatistics.hasHisStaTaskList];
    for (NSDictionary * dic in responseArray) {
        TaskList * taskModel = [DataParser getTaskListOrResponseDic:dic];
        taskModel.belongWaiterInfor = waiterinfo;
        taskModel.belongHistoricalStatics = hStatistics;
        [hStatistics addHasHisStaTaskListObject:taskModel];
        [dataArray addObject:taskModel];
    }
    
    return dataArray;
}
//服务员根据任务号获取聊天信息
+(NSMutableArray *)parsingWaiterGetMessageByTaskCode:(id)dict{
    NSMutableArray * dataArray = [[NSMutableArray alloc]init];
    
#warning 服务员根据任务号获取聊天信息
    
    return dataArray;
}
@end
