//
//  NetworkRequestManager.h
//  waiter
//
//  Created by new on 2017/4/12.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef  void (^ResponseSuccess)(NSURLSessionTask * task,id dataSource,NSString * message,NSString * url);  //请求成功block
typedef  void (^ResponseFailure)(NSURLSessionTask * task,NSString * message,NSString * status,NSString * url);    //请求失败block


@interface NetworkRequestManager : NSObject
+ (instancetype)defaultManager;

/**
 http请求

 @param url url
 @param params 入参
 @param byUser 是否用户手动发起
 @param success 成功block
 @param failure 失败block
 */
-(void)POST_Url:(NSString *)url Params:(NSDictionary *)params withByUser:(BOOL)byUser Success:(ResponseSuccess)success Failure:(ResponseFailure)failure;


// 取消所有请求
-(void)cancleAllRequest;

/**
 根据url取消请求

 @param url (不包含url头部)
 */
-(void)cancleRequestWithUrl:(NSString *)url;
@end
