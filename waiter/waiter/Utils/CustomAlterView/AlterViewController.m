//
//  AlterViewController.m
//  bbbb
//
//  Created by new on 2017/4/12.
//  Copyright © 2017年 com.nono. All rights reserved.
//

#import "AlterViewController.h"
#import "AlterViewSystem.h"
#import "AlterViewCustom.h"
#import "AppDelegate.h"
@interface AlterViewController ()
@property(nonatomic,copy)AlterViewFinis alterViewBlock;

@end

@implementation AlterViewController
-(instancetype)initWithOwner:(id)tagret{

    
    self = [super init];
    
    if (self) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        //tagret 预留字段
        UIImage * backImage = [self screenView:app.window];
        imageView.image = backImage;
        [self.view addSubview:imageView];
        
        UIView * backView = [[UIView alloc]initWithFrame:self.view.bounds];
        backView.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.8];
        [self.view addSubview:backView];
        
        
    }
    return self;

}
- (UIImage*)screenView:(UIView *)view{
    CGRect rect = view.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(AlterViewController *)alterViewOwner:(id)tagret WithAlterViewStype:(AlterViewStype)alterViewStype WithMessageCount:(NSString *)messageCount WithAlterViewBlock:(AlterViewFinis)alterViewBlock{
    AlterViewController * alVc = [[AlterViewController alloc]initWithOwner:tagret];
    alVc.alterViewBlock = alterViewBlock;
    [alVc creatAlterView:alterViewStype WithSubMessage:messageCount];
    return alVc;
}
-(void)creatAlterView:(AlterViewStype)alterViewStype WithSubMessage:(NSString *)subMessage{

    /*
     
    AlterViewGrabSingle = 0,        抢单
    AlterViewServiceComplete,       服务完成
    AlterViewServiceStop,           停止接单
    AlterViewAdminSendSingle,       管理员派单
    AlterViewAdminReminder,         管理员催单
    AlterViewGuestCancel,           住客取消
    AlterViewGuestComplete,         住客确认完成
    AlterViewGuestUnfinished,       住客确认未完成
    AlterViewGuestGiveUp,           住客超时未确认
    AlterViewLogoOut,               退出登录
     
     
     */
    
    
    UIView * view = nil;
    
    switch (alterViewStype) {
        case AlterViewGrabSingle:
            view = [self creatSystemStyleMessage:@"请确认抢单?" leftTitle:@"放弃" rightTitle:@"确认"];
            break;
        case AlterViewServiceComplete:
            view = [self creatSystemStyleMessage:@"请确认已完成当前任务" leftTitle:@"取消" rightTitle:@"确认"];
            break;
        case AlterViewServiceStop:
            view = [self creatSystemStyleMessage:@"请确认停止接单" leftTitle:@"取消" rightTitle:@"确认"];
            break;
        case AlterViewAdminSendSingle:
            view = [self creatCustomStyleMessage:@"管理员给您派送了一个呼叫任务,\n请及时处理!" Title:@"确认"];
            break;
        case AlterViewAdminReminder:
            
             view = [self creatCustomStyleMessage:[NSString stringWithFormat:@"当前任务已超时,管理员给您发送了（%@）次催单,请尽快完成!",subMessage] Title:@"确认"];
            break;
        case AlterViewGuestCancel:
            view = [self creatCustomStyleMessage:@"住客已取消此次呼叫服务!" Title:@"确认"];
            break;
        case AlterViewGuestComplete:
            view = [self creatCustomStyleMessage:@"住客已确认服务完成!" Title:@"确认"];
            break;
        case AlterViewGuestUnfinished:
            view = [self creatCustomStyleMessage:@"住客取消了服务完成确认,请您及时与住客联系!" Title:@"继续服务"];
            break;
        case AlterViewGuestGiveUp:
            view = [self creatCustomStyleMessage:@"住客超时未确认,系统默认服务完成!" Title:@"确认"];
            break;
            
        default:
            view = [self creatSystemStyleMessage:@"您确认下班?" leftTitle:@"还要继续" rightTitle:@"我要下班"];
            break;
    }

    view.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [self.view addSubview:view];
    

}
#pragma mark -  SystemStyle

-(UIView *)creatSystemStyleMessage:(NSString *)message leftTitle:(NSString *)leftCurrentTitle rightTitle:(NSString *)rightCurrentTitle{

    AlterViewSystem * view = [[[NSBundle mainBundle] loadNibNamed:@"AlterViewSystem" owner:self options:nil] lastObject];
    view.frame = CGRectMake(0, 0, self.view.bounds.size.width - 70, 158);
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 7;
    view.messageLabel.text = message;
    [view.leftButton setTitle:leftCurrentTitle forState:UIControlStateNormal];
    [view.rightButton setTitle:rightCurrentTitle forState:UIControlStateNormal];
    [view.leftButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view.rightButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    return view;
    

}
#pragma mark -  CustomStyle

-(UIView *)creatCustomStyleMessage:(NSString *)message Title:(NSString *)currentTitle {
    
    AlterViewCustom * view = [[[NSBundle mainBundle] loadNibNamed:@"AlterViewCustom" owner:self options:nil] lastObject];
    view.frame = CGRectMake(0, 0, self.view.bounds.size.width - 58, 188);
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 7;
    view.messageLabel.text = message;
    [view.button setTitle:currentTitle forState:UIControlStateNormal];
    [view.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    return view;
    
    
}
-(void)buttonClick:(UIButton *)button{
    self.alterViewBlock(button, button.tag);
    [self dismissViewControllerAnimated:NO completion:nil];

}

@end
