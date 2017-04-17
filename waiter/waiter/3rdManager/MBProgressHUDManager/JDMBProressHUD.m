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
        hud = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].delegate.window];
        [[UIApplication sharedApplication].delegate.window addSubview:hud];
        hud.labelText = @"正在加载";
        [hud hide:NO];
        [hud show:YES];
        isShow = YES;        
    }

}
+(void)removeJdHud{
    
    if (isShow){
        [hud hide:YES];
        [hud removeFromSuperview];
        hud = nil;
        isShow = NO;
    }

}
@end
