//
//  InterfaceFiles.h
//  waiter
//
//  Created by new on 2017/4/13.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#ifndef InterfaceFiles_h
#define InterfaceFiles_h
#endif /* InterfaceFiles_h */


/* 接口文件 */

#define REQUEST_HEAD_NORMAL @"http://"
#define REQUEST_HEAD_SCREAT @"https://"

// 服务员登录
#define URI_WAITER_Login                      @"/hotelcallservice/waiter/login.json"

// 服务员状态
#define URI_WAITER_AttendStatus               @"/hotelcallservice/waiter/getWaiterAttendStatus.json"

// 服务员修改密码
#define URI_WAITER_UpdatePass                 @"/hotelcallservice/waiter/updatePass.json"

// 	服务员登出
#define URI_WAITER_Logout                     @"/hotelcallservice/waiter/logout.json"

//	获取服务员信息
#define URI_WAITER_WaiterInfoByWaiterId       @"/hotelcallservice/waiter/getWaiterInfoByWaiterId.json"

//	服务员工作状态设置“开始接单”、“停止接单”
#define URI_WAITER_SetWorkStatus              @"/hotelcallservice/waiter/settingWorkingStatus.json"

//	服务员“开始接单”后获取进行中任务列表
#define URI_WAITER_TaskAfterAccept            @"/hotelcallservice/waiter/getTaskInfoAfterAccept.json"












