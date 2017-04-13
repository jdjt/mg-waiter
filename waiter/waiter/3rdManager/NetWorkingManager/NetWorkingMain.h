//
//  NetWorkingMain.h
//  waiter
//
//  Created by new on 2017/4/12.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "AFNetworking.h"
typedef  void (^NetWokingSuccess)(id responseObject,NSURLSessionTask * task,NSDictionary * headers);  //请求成功block
typedef  void (^NetWokingFailure)(NSError * error,NSURLSessionTask * task,NSDictionary * headers);    //请求失败block
@interface NetWorkingMain : NSObject
+(AFHTTPSessionManager *)POST_URL:(NSString *)url WithHttpHeader:(NSDictionary *)httpHeader WithParameters:(NSDictionary *)parameters WithSuccess:(NetWokingSuccess)success failure:(NetWokingFailure)failure;

@end
