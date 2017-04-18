//
//  DataParser.m
//  waiter
//
//  Created by new on 2017/4/13.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "DataParser.h"
#import "DataBaseManager+Category.h"
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
    
    
    if ([dataSource isKindOfClass:[NSManagedObject class]]) {
        [[DataBaseManager defaultInstance] saveContext];
    }
    
    return dataSource;

}
//服务员登录
+(DBLogInInfo *)parsingWaiterLogIn:(id)dict{
    
    NSDictionary * responseObject = dict;
    
    DBLogInInfo * logindb = [[DataBaseManager defaultInstance] getLogInInfo];
    
    [logindb setValuesForKeysWithDictionary:responseObject];
    
    NSDictionary * waiterInfoDic = responseObject[@"waiterInfo"];
    
    [logindb.waiterInfo setValuesForKeysWithDictionary:waiterInfoDic];
        
    return logindb;

}
//服务员状态
+(DBWaiterInfo *)parsingWaiterAttendStatus:(id)dict{

    NSDictionary * responseObject = dict;
    
    DBLogInInfo * logindb = [[DataBaseManager defaultInstance] getLogInInfo];
    logindb.waiterInfo.workStatus = responseObject[@"workStatus"];
    logindb.waiterInfo.attendStatus = responseObject[@"attendStatus"];
    return logindb.waiterInfo;

}

//服务员修改密码
+(id)parsingWaiterUpdatePass:(id)dict{
    return nil;
}

//服务员登出
+(id)parsingWaiterLogout:(id)dict{
    return nil;
}
//获取服务员信息
+(DBWaiterInfo *)parsingWaiterInfoByWaiterId:(id)dict{
    NSDictionary * responseObject = dict;
    
    DBLogInInfo * logindb = [[DataBaseManager defaultInstance] getLogInInfo];
    [logindb.waiterInfo setValuesForKeysWithDictionary:responseObject];
    return logindb.waiterInfo;
}
//服务员工作状态设置“开始接单”、“停止接单”
+(id)parsingWaiterSetWorkStatus:(id)dict{
    return nil;
}
//服务员“开始接单”后获取进行中任务列表
+(NSMutableArray *)parsingWaiterTaskAfterAccept:(id)dict{
    NSMutableArray * dataArray = [[NSMutableArray alloc]init];
    
    
    
    return dataArray;
}
@end
