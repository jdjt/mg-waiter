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


/**
 系统提示框 （只做提示作用，没有事件响应）

 @param message 提示信息
 @param owner 传UIViewController对象（默认self）
 */
+(void)systemAlterViewOwner:(id)owner WithMessage:(NSString *)message;

@end
