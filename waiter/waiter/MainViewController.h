//
//  MainViewController.h
//  waiter
//
//  Created by sjlh on 2017/4/13.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, assign)NSInteger second;
@property (nonatomic, assign)NSInteger minute;
@property (nonatomic, assign)NSInteger hour;
@property (nonatomic, strong)NSString * secondString;
@property (nonatomic, strong)NSString * minuteString;
@property (nonatomic, strong)NSString * hourString;

@property (nonatomic, strong)NSTimer *timer1;
@property (nonatomic, assign)NSInteger serviceSecond;
@property (nonatomic, assign)NSInteger serviceMinute;
@property (nonatomic, assign)NSInteger serviceHour;
@property (nonatomic, strong)NSString * serviceSecondString;
@property (nonatomic, strong)NSString * serviceMinuteString;
@property (nonatomic, strong)NSString * serviceHourString;
@end
