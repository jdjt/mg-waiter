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
#import "DataBaseManager+Category.h"
#import "JDMBProressHUD.h"
#import "AppDelegate.h"
#import "AlterViewController.h"
#import "LoginViewController.h"
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
    DBDeviceInfo * deviceInfo = [[DataBaseManager defaultInstance] getDeviceInfo];
    NSMutableDictionary* header = [[NSMutableDictionary alloc]init];
    [header setObject:@"application/json; charset=utf-8" forKey:@"Content-Type"];
    [header setObject:[MySingleton sharedSingleton].waiterId forKey:@"mymhotel-ticket"];
    [header setObject:@"1004" forKey:@"mymhotel-type"];
    [header setObject:@"1.0" forKey:@"mymhotel-version"];
    [header setObject:@"JSON" forKey:@"mymhotel-dataType"];
    [header setObject:@"JSON" forKey:@"mymhotel-ackDataType"];
    [header setObject:[NSString stringWithFormat:@"%@|%@",deviceInfo.deviceId,deviceInfo.deviceToken] forKey:@"mymhotel-sourceCode"];
    [header setObject:[NSString stringWithFormat:@"%f",timestamp] forKey:@"mymhotel-dateTime"];
    NSLog(@"httpHeader:```` > %@",header);
    return header;
    
}
//发起网络请求
-(void)POST_Url:(NSString *)url Params:(NSDictionary *)params withByUser:(BOOL)byUser Success:(ResponseSuccess)success Failure:(ResponseFailure)failure{
    if (byUser)[JDMBProressHUD addJdHud];
    _success = success;
    _failure = failure;
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@",REQUEST_HEAD_NORMAL,[MySingleton sharedSingleton].baseInterfaceUrl,url];
    NSLog(@"url:--> %@",urlString);
    NSLog(@"params:~~~> %@",params);
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
    [JDMBProressHUD removeJdHud];
   
    NSString * headerStatus = [headers objectForKey:@"mymhotel-status"];
    NSString * headerMessage = [headers objectForKey:@"mymhotel-message"];
    NSString *unicodeMessage = nil;
     /* 无响应：网络连接失败 */
    if (headerStatus == nil || headerMessage == nil) {
        self.failure(task, headerMessage,nil ,url);
        [AlterViewController alterViewOwner:self WithAlterViewStype:alterViewNetError WithMessageCount:nil WithAlterViewBlock:^(UIButton *button, NSInteger buttonIndex) {
            
        }];
        return;
    }
    
    unicodeMessage = [NSString stringWithCString:[headerMessage cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
    
    NSLog(@"headerStatus:%@ --...--headerMessage:%@ ",headerStatus,unicodeMessage);
    
    NSArray * messageArray = [unicodeMessage componentsSeparatedByString:@"|"];
    
    
    NSString * serverMessage = messageArray.count > 1 ? messageArray[1] : @"";//提示语
    
    /* 网络数据失败 */
    if ([headerStatus isEqualToString:@"ERR"]){
        
         self.failure(task, serverMessage, headerStatus, url);
        if ([messageArray.firstObject isEqualToString:EBCALL002]) {
            //登录失效
            [[NSNotificationCenter defaultCenter] postNotificationName:WAITER_RECEIVED_PUSH object:@{@"messType":EBCALL002} userInfo:@{@"messType":EBCALL002}];
            return;
        }
        return;
    }
    
    
    NSLog(@"responseObj -- > %@",responseObj);
    /* 有数据返回 */
    if (responseObj != nil) {
        @try
        {
            id dataSource = [DataParser parserUrl:url fromData:responseObj];
            // 不需要返回数据的请求
            if ([dataSource isKindOfClass:[NSNumber class]]){
                
                BOOL isSuccess = [dataSource boolValue];
                
                if (isSuccess) {
                    //数据操作成功
                    self.success(task, nil, serverMessage, url);
                }else{
                    //数据操作失败
                    self.failure(task, nil, serverMessage, url);
                }
                
                return;
            }
            // 有返回数据的请求
             self.success(task, dataSource, serverMessage, url);
        }
        @catch (NSException *exception){            
            //数据操作失败
            self.failure(task, nil, serverMessage, url);
        }
    }else{
        // 返回数据为nil
        self.success(task, nil, serverMessage, url);
        
    
    }

}

@end
