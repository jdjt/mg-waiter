//
//  NetWorkingMain.m
//  waiter
//
//  Created by new on 2017/4/12.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "NetWorkingMain.h"

@implementation NetWorkingMain

+(AFHTTPSessionManager *)POST_URL:(NSString *)url WithHttpHeader:(NSDictionary *)httpHeader WithParameters:(NSDictionary *)parameters WithSuccess:(NetWokingSuccess)success failure:(NetWokingFailure)failure{
    
    AFHTTPSessionManager * session = [NetWorkingMain managerHeader:httpHeader];
   // AFHTTPSessionManager * session = [AFHTTPSessionManager manager];

    [session POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
        success(responseObject,task,response.allHeaderFields);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
        failure(error,task,response.allHeaderFields);
    }];
    
    return session;

}
// 设置请求对象参数
+(AFHTTPSessionManager *)managerHeader:(NSDictionary *)header{
    
     AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
        session.requestSerializer.timeoutInterval = 15;
        session.requestSerializer = [AFJSONRequestSerializer serializer];
        for (NSString * key in header) {
            [session.requestSerializer setValue:header[key] forHTTPHeaderField:key];
        }
    session.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    
    return session;;
    
}

@end
