//
//  JDMBProressHUD.m
//  waiter
//
//  Created by new on 2017/4/17.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "JDMBProressHUD.h"
#import "AppDelegate.h"
static BOOL isShow = NO;
MBProgressHUD * hud;
@implementation JDMBProressHUD

+(void)addJdHud{

    if (isShow == NO) {
        isShow = YES;
        hud = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].delegate.window];
        [[UIApplication sharedApplication].delegate.window addSubview:hud];
        hud.labelText = @"正在加载";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hide:NO];
            [hud show:YES];
        });
        
        
    }

}
+(void)removeJdHud{
    
    if (isShow){
        isShow = NO;
        [hud hide:YES];
        [hud removeFromSuperview];
        hud = nil;
        
    }

}
@end
