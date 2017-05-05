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


/* http 接口文件 */

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

//	服务员上传位置信息
#define URI_WAITER_UpdateMapInfo            @"/hotelcallservice/waiter/updateMapInfo.json"

//	服务员“抢单”
#define URI_WAITER_AcceptTask            @"/hotelcallservice/waiter/acceptTask.json"

//	服务员“确认”完成呼叫任务
#define URI_WAITER_ConfirmTask            @"/hotelcallservice/waiter/confirmTask.json"

//	服务员获取任务信息
#define URI_WAITER_GetTaskInfo            @"/hotelcallservice/waiter/getTaskInfo.json"

//	服务员根据任务号获取任务信息
#define URI_WAITER_GetTaskInfoByTaskCode            @"/hotelcallservice/waiter/getTaskInfoByTaskCode.json"

//	服务员查询"历史任务统计"
#define URI_WAITER_GetTaskInfoStatic            @"/hotelcallservice/waiter/getTaskInfoStatic.json"

//  服务员根据任务号获取聊天信息
#define URI_WAITER_GetMessageByTaskCode            @"/hotelcallservice/waiter/getMessageByTaskCode.json"






/* push 接口文件 */

//  收到推送通知Name
#define WAITER_RECEIVED_PUSH            @"waiterReceivedPush"

//  登录失效
#define EBCALL002                       @"EBCALL002"

//  启动app
#define startAPP                        @"startAPP"
//  入住客人发送任务
#define CusAddTaskK                     @"CusAddTask"
//  入住客人取消任务
#define CusCancelTask                   @"CusCancelTask"
//  入住客人确认任务 （完成)
#define CusConfirmTaskComplete          @"CusConfirmTaskComplete"
//  入住客人确认任务 (未完成)
#define CusConfirmTaskUnComplete        @"CusConfirmTaskUnComplete"
//  入住客人评价任务 (不要了)
#define CusScoreTask                    @"CusScoreTask"
//  服务员点击完成后，客人在超过规定时间范围后，还没有点击确认(认可，不认可)的情况下，系统自动客人确认认可,推送给服务员
#define SystemAutoConfirmTaskToWaiter   @"SystemAutoConfirmTaskToWaiter"
//  服务员接受任务（不用）
#define WaiterAcceptTask                @"WaiterAcceptTask"
//  服务员确认完成服务（不用）
#define WaiterConfirmTaskComplete       @"WaiterConfirmTaskComplete"
//  管理员派单
#define ManagerSendTask                 @"ManagerSendTask"
//  管理员催单
#define ManagerRemindeTask              @"ManagerRemindeTask"

