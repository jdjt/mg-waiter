/**
 Copyright (c) 2012 Mangrove. All rights reserved.
 Author:mars
 Date:2014-10-24
 Description: 封装了请求服务器的url
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MySingleton : NSObject
{
    NSString * _waiterId;

}
@property (nonatomic, copy) NSString *waiterId;//服务员ID,登录时赋值
+ (MySingleton *)sharedSingleton;

@property (nonatomic,copy) NSString *sessionId;

@property (nonatomic,readonly,copy) NSString *baseInterfaceUrl;//接口地址根路径

@property (nonatomic,readonly) NSString *weixinInterfaceUrl;



@end
