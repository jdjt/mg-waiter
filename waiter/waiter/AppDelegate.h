//
//  AppDelegate.h
//  waiter
//
//  Created by liuchao on 2017/4/12.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)sharedDelegate;

@end

