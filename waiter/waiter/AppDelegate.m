//
//  AppDelegate.m
//  waiter
//
//  Created by liuchao on 2017/4/12.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "AppDelegate.h"
#import "DataBaseManager+Category.h"
#import "UMessage.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //设置 AppKey 及 LaunchOptions
    [UMessage startWithAppkey:@"56f23615e0f55a8fc400053b" launchOptions:launchOptions httpsEnable:YES];
    //注册通知
    [UMessage registerForRemoteNotifications];
    
    
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
        } else {
            //点击不允许
        }
    }];
    
    // 友盟即时通讯sdk初始化
    [[SPKitExample sharedInstance] callThisInDidFinishLaunching];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *device = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""] stringByReplacingOccurrencesOfString: @">" withString: @""] stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    // 保存参数到本地
    DBDeviceInfo * deviceInfo = [[DataBaseManager defaultInstance] getDeviceInfo];
    deviceInfo.deviceToken = device;
    [[DataBaseManager defaultInstance] saveContext];
    [UMessage registerDeviceToken:deviceToken];
    [[[YWAPI sharedInstance] getGlobalPushService] setDeviceToken:deviceToken];
    NSLog(@"deviceToken：--> %@",device);
}
//iOS10以前使用这个方法接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    [UMessage sendClickReportForRemoteNotification:userInfo];
    [UMessage didReceiveRemoteNotification:userInfo];
    [self userPushNotification:userInfo];
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        [UMessage sendClickReportForRemoteNotification:userInfo];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        NSLog(@"%@",userInfo);
        [self userPushNotification:userInfo];
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        [self userPushNotification:userInfo];
    }else{
        //应用处于后台时的本地推送接受
    }
}
-(void)userPushNotification:(NSDictionary *)userInfo{

    [[NSNotificationCenter defaultCenter] postNotificationName:WAITER_RECEIVED_PUSH object:userInfo userInfo:userInfo];

}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    //启动app
    [self userPushNotification:@{@"messType":@"startAPP"}];
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (AppDelegate *)sharedDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

@end
