//
//  AlterViewController.h
//  bbbb
//
//  Created by new on 2017/4/12.
//  Copyright © 2017年 com.nono. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, AlterViewStype) {
    AlterViewGrabSingle = 0,        /*抢单*/
    AlterViewOthersGrabSingle,      /*已被其他人抢走*/
    AlterViewServiceComplete,       /*服务完成*/
    AlterViewServiceStop,           /*停止接单*/
    AlterViewAdminSendSingle,       /*管理员派单*/
    AlterViewAdminReminder,         /*管理员催单*/
    AlterViewGuestCancel,           /*住客取消*/
    AlterViewGuestComplete,         /*住客确认完成*/
    AlterViewGuestUnfinished,       /*住客确认未完成*/
    AlterViewGuestGiveUp,           /*住客超时未确认*/
    AlterViewLogoOut,               /*退出登录*/
    AlterViewPwdError,              /*工号或者密码错误*/
    alterViewUserIdandPwdNULL,      /*用户名或密码不能为空*/
    AlterViewEvaluation,            /*客人已评价*/
    alterViewNetError               /*网络错误*/
};

/**
 alter提示框回调block

 @param button 点击的button
 @param buttonIndex button的tag值
 */
typedef void (^AlterViewFinis)(UIButton * button , NSInteger buttonIndex);

@interface AlterViewController : UIView

/**
 提示控件

 @param tagret self
 @param alterViewStype 提示框类型、（当 “alterViewStype == AlterViewAdminReminder” 时 ， 需要传入message信息）
 @param messageCount AlterViewAdminReminder时的催单次数
 @return AlterViewController
 */
+(AlterViewController *)alterViewOwner:(id)tagret WithAlterViewStype:(AlterViewStype)alterViewStype WithMessageCount:(NSString *)messageCount WithAlterViewBlock:(AlterViewFinis)alterViewBlock;
@end
