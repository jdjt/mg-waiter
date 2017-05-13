//
//  MapViewController.h
//  mgservice
//
//  Created by liuchao on 2016/11/3.
//  Copyright © 2016年 Suzic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "TaskList+CoreDataClass.h"

@interface MapViewController : UIViewController

@property (strong, nonatomic) MainViewController * mainVC;
@property (strong, nonatomic) TaskList *currentTask;

@end
