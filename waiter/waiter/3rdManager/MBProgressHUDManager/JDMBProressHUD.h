//
//  JDMBProressHUD.h
//  waiter
//
//  Created by new on 2017/4/17.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
@interface JDMBProressHUD : NSObject
@property(nonatomic,strong)MBProgressHUD * hud;

/**
 显示加载等待
 */
+(void)addJdHud;
/**
 隐藏加载等待
 */
+(void)removeJdHud;
@end
