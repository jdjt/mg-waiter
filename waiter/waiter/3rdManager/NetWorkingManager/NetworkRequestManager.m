//
//  NetworkRequestManager.m
//  waiter
//
//  Created by new on 2017/4/12.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "NetworkRequestManager.h"
#import "NetWorkingMain.h"
#import "DataParser.h"
@interface NetworkRequestManager ()

@property (nonatomic,strong) NSMutableDictionary * managerDictionary;
@property (nonatomic,copy) ResponseSuccess success;
@property (nonatomic,copy) ResponseFailure failure;
@end
@implementation NetworkRequestManager

+ (instancetype)defaultManager {
    static NetworkRequestManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NetworkRequestManager alloc]init];
        manager.managerDictionary = [[NSMutableDictionary alloc]init];
    });
    
    return manager;
}
//根据url取消请求
-(void)cancleRequestWithUrl:(NSString *)url{
    
    if (self.managerDictionary[url]) {
        AFHTTPSessionManager * manager = self.managerDictionary[url];
        [manager.operationQueue cancelAllOperations];
        [self.managerDictionary removeObjectForKey:url];
    }
    

}
// 取消所有请求
-(void)cancleAllRequest{
    for (NSString * key in self.managerDictionary) {
        [self cancleRequestWithUrl:key];
    }
}
// 设置请求头
-(NSDictionary *)getHttpHeader{
    
    NSTimeInterval timestamp = [Util timestamp];
    NSMutableDictionary* header = [[NSMutableDictionary alloc]init];
    [header setObject:@"application/json; charset=utf-8" forKey:@"Content-Type"];
    [header setObject:@"" forKey:@"mymhotel-ticket"];
    [header setObject:@"1001" forKey:@"mymhotel-type"];
    [header setObject:@"1.0" forKey:@"mymhotel-version"];
    [header setObject:@"JSON" forKey:@"mymhotel-dataType"];
    [header setObject:@"JSON" forKey:@"mymhotel-ackDataType"];
    [header setObject:[Util getMacAdd] forKey:@"mymhotel-sourceCode"];
    [header setObject:[NSString stringWithFormat:@"%f",timestamp] forKey:@"mymhotel-dateTime"];
    [header setObject:@"no-cache" forKey:@"Pragma"];
    [header setObject:@"no-cache" forKey:@"Cache-Control"];
    
    return header;
}
//发起网络请求
-(void)POST_UrlHead:(NSString *)urlHeader WithUrl:(NSString *)url Params:(NSDictionary *)params withByUser:(BOOL)byUser Success:(ResponseSuccess)success Failure:(ResponseFailure)failure{
    _success = success;
    _failure = failure;
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@",urlHeader,[MySingleton sharedSingleton].baseInterfaceUrl,url];
    
   AFHTTPSessionManager * manager =  [NetWorkingMain POST_URL:urlString WithHttpHeader:[self getHttpHeader] WithParameters:params WithSuccess:^(id responseObject, NSURLSessionTask *task, NSDictionary *headers) {
       [self resultComplete:responseObject urltask:task URL:url Headers:headers];
    } failure:^(NSError *error, NSURLSessionTask *task, NSDictionary *headers) {
        [self resultComplete:error urltask:task URL:url Headers:headers];
    }];
    
    if ([self.managerDictionary objectForKey:url]) {
        [self cancleRequestWithUrl:url];
    }
    [self.managerDictionary setObject:manager forKey:url];
    
}
- (void)resultComplete:(id)responseObj urltask:(NSURLSessionTask *)task URL:(NSString *)url Headers:(NSDictionary *)headers{
    [self cancleRequestWithUrl:url];

    NSString * status = [headers objectForKey:@"mymhotel-status"];
    NSString * message = [headers objectForKey:@"mymhotel-message"];
    
    /* 无响应：网络连接失败 */
    if (status == NULL)
    {
        self.failure(task, message, status, url);
        return;
    }
     
    
    // 有网络连接
    NSString *unicodeStr = [NSString stringWithCString:[message cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
    //NSLog(@"返回的数据:%@", unicodeStr);
    
    // 解析状态数据
    NSArray* msgs = [unicodeStr componentsSeparatedByString:@"|"];
    
    // 登录失败或者超时的情况，自动登录一次（之前的操作未完成，需要用户重新点击发起操作）
    if ([msgs[0] isEqualToString:@"EBA013"]
        ||[msgs[0] isEqualToString:@"TICKET_ISNULL"]
        ||[msgs[0] isEqualToString:@"TOKEN_INVALID"]
        ||[msgs[0] isEqualToString:@"UNLOGIN"]
        ||[msgs[0] isEqualToString:@"EBF001"]
        ||[msgs[0] isEqualToString:@"ES0003"]
        ||[msgs[0] isEqualToString:@"ES0001"]) {
        
        self.failure(task, msgs[1], status, url);
        return;
    }
    // 返回无数据的状态
    if (msgs != nil && msgs.count > 1) {
        NSRange range = [msgs[1] rangeOfString:@"不存在"];
        if ([status isEqualToString:@"ERR"]
            || [msgs[1]isEqualToString:@"无数据"]
            || [msgs[1]isEqualToString:@"数据空"]
            || range.length > 0) {
            
            self.failure(task, msgs[1], status, url);
            return;
        }
    }else {
        
        self.failure(task, unicodeStr, status, url);
    }
    
    if (responseObj != nil) {
        @try
        {
            
            NSMutableArray *  dataArray = [DataParser parserUrl:url fromData:responseObj];
            // 不需要返回数据的请求
            if (dataArray.count < 1){
               
                self.failure(task, @"", status, url);
                return;
            }
            // 有返回数据的请求
             self.success(task, dataArray, @"", url);
        }
        @catch (NSException *exception){
        }
    }

}

@end
