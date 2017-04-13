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

#define REQUEST_HEAD_NORMAL "http://"
#define REQUEST_HEAD_SCREAT "https://"

// 服务员登录hotelservice
#define URI_WAITER_LOGIN                      "/hotelservice/manage/waiter/login.json"

// 服务员注销登录(下班)
#define URI_WAITER_LOGOUT                     "/hotelservice/manage/waiter/logout.json"



// 服务员信息查询
#define URI_WAITER_CHECKINFO                  "/hotelservice/manage/waiter/waiter_info.json"

// 服务员获取服务请求列表
#define URI_WAITER_GETSERVICELIST             "/hotelservice/checkin/service/task_array.json"

// 服务员抢单请求
#define URI_WAITER_RUSHTASK                   "/hotelservice/checkin/service/accept_task.json"

// 服务员提交完成
#define URI_WAITER_FINISHTASK                 "/hotelservice/checkin/service/finish_task.json"




