/**
 Copyright (c) 2012 Mangrove. All rights reserved.
 Author:mars
 Date:2014-10-24
 Description: 工具
 */
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <UIKit/UIKit.h>

@interface Util : NSObject

/**
 * @abstract 获取uuid
 */
+ (NSString*)getUUID;

+ (NSString*) macaddress;

/**
 * @abstract 获取当前时间戳
 */
+ (NSTimeInterval)timestamp;

/**
 * @abstract 判断邮箱
 */
+(BOOL)isValidateEmail:(NSString *)email;

/**
 * @abstract 判断手机号
 */
+(BOOL) isMobileNumber:(NSString *)mobileNum;
+(NSString *)EncodeUTF8Str:(NSString *)encodeStr;

/**
 * @abstract 获取mac地址
 */
+ (NSString*) getMacAdd;

/**
 * @abstract 根据三色值生成图片
 */
+ (UIImage *) createImageWithColor: (UIColor *) color;

/**
 * @abstract 判断字符床是否为空
 */
+(Boolean) isEmptyOrNull:(NSString *) str;

/**
 * @abstract 判断当前是否有网络
 */
+ (BOOL) isConnectionAvailable;

/**
 * @abstract 替换服务器
 */
+ (BOOL)SelectTheServerUrl;

/**
 * @abstract 计算明天的日期
 */
+ (NSDate *)startDate:(NSDate *)date offsetDay:(int)numDays;

/**
 * @abstract 判断最新消息
 */
- (BOOL)LatestNews:(NSString *)messageCode;

/**
 * @abstract 当前消息是否阅读
 */
- (void)WhetherOrNotToread:(NSString *)messageCode isRead:(NSString *)isread;

/**
 * @abstract 判断是否有未读消息
 */
- (BOOL)UnreadMessage;

/**
 * @abstract 获取本地呼叫json字典
 */
+ (NSDictionary *)getCallJsonDic;

/**
 * @abstract 获取当前网络状态
 */
+ (int)getCurrentNetworkStatus;
/**
 * @abstract 获取当前时间
 */
+(NSString *)getTimeNow;
/**
 * @abstract 获取属性字符串
 */
+(NSMutableAttributedString *)aVarietyOfColorFonts:(NSString *)text WithComPer:(NSString *)comStr WithColor:(UIColor *)color;
/**
 * @abstract 时间戳转为日期格式
 */
+(NSString *)timeStampConversionStandardTime:(NSString *)timeStamp WithFormatter:(NSString *)formatter;
/**
 * @abstract 日期格式转为时间戳
 */
+(NSString *)standardTimeConversionTimeStamp:(NSString *)standardTime WithFormatter:(NSString *)formatter;

/**
 * @abstract 2个时间戳的差值
 */
+(NSString *)timeStampsLongTime:(NSString *)longTime nowTime:(NSString *)nowTime;

/**
 * @abstract 秒转换成时分秒
 */
+ (NSString *)timeFormatted:(int)totalSeconds;
//时分秒转为秒数
+ (NSTimeInterval)stringFormattedSeconds:(NSString *)formattedString;
@end
