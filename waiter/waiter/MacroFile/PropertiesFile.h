//
//  PropertiesFile.h
//  waiter
//
//  Created by new on 2017/4/13.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#ifndef PropertiesFile_h
#define PropertiesFile_h
#endif /* PropertiesFile_h */

/* 宏文件 */

#define kScreenHeight   ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth    ([UIScreen mainScreen].bounds.size.width)

//根据6注释，等比例缩放
#define kAdapterWith(x) kScreenWidth/375*x
#define kAdapterheight(y) kScreenHeight/667*y

#define RGBA(x,y,z,a) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:a];

//判断iPhone5的代码
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iPhone4/5的代码
#define IS_LESS4 kScreenWidth<= 320 ? YES : NO

//判断retain屏的
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define isNormalScreen ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(768, 1024), [[UIScreen mainScreen] currentMode].size)) : NO)

//Documents 文件目录
#define Documents() [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

//设置RGB颜色
#define UIColorFromRGB(rgbValue,rgbalpha) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:rgbalpha]


#define ISIOS7 ([[UIDevice currentDevice].systemVersion intValue] == 7)





