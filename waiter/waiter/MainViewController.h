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

@property (nonatomic, strong)NSTimer *timer1;//服务时长
@property (nonatomic, assign)NSInteger serviceSecond;

@property (nonatomic, strong)NSTimer *timer2;
@property (nonatomic, assign)NSInteger completeSecond;


//给iPhone5加约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *workTimeViewHeight;//工作时长的view高度 //6p下是70
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *grayLeineViewTop;//灰色横线，6p下是70
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *empNoTop;//工号居上的距离 6p下是19
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameTop;//姓名居上的距离 6p下是19
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *depNameTop;//所属部门居上的距离 6p下是19

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headViewHeight;//状态view 6p下是50
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stateViewHeight;//服务时长view 6p下是50
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *serviceTimeViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stateButtonWidth;//开始接单按钮 6p下是130
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stateButtonHeight;//开始接单按钮 6p下是50

- (void)instantMessageingFormation;
@end
