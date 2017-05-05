//
//  MySingleton.m
//  BeautyDiary
//
//  Created by 王 玲玲 on 13-8-5.
//  Copyright (c) 2013年 王 玲玲. All rights reserved.
//

#import "MySingleton.h"

@implementation MySingleton

@synthesize sessionId;
@synthesize baseInterfaceUrl = _baseInterfaceUrl;
@synthesize weixinInterfaceUrl=_weixinInterfaceUrl;

+ (MySingleton *)sharedSingleton
{
    static MySingleton *sharedSingleton=nil;
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[MySingleton alloc] init];
        
        return sharedSingleton;
    }
}

//基础地址要改为
-(id)init
{
    self = [super init];
    if (self)
    {
        //_baseInterfaceUrl = @"mws.mymhotel.com";
        _baseInterfaceUrl = @"rc-ws.mymhotel.com";
//        _baseInterfaceUrl = @"192.168.1.45:8181";
//        _baseInterfaceUrl = @"192.168.10.56:8080";//王达本机
       // _baseInterfaceUrl = @"192.168.10.56:8080";
    }
    
    return self;
}

-(void)setWaiterId:(NSString *)waiterId{
    _waiterId = waiterId;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:waiterId forKey:@"waiterId"];
    [user synchronize];
}
-(NSString *)waiterId{
    if (_waiterId == nil) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        _waiterId = @"";
        if ([ user objectForKey:@"waiterId"]) {
            _waiterId = [ user objectForKey:@"waiterId"];
        }
    } 
    return _waiterId;
}


+(void)systemAlterViewOwner:(id)owner WithMessage:(NSString *)message{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action];
    if ([owner isKindOfClass:[UIViewController class]]) {
        UIViewController * vc = owner;
        [vc presentViewController:alert animated:YES completion:nil];
    }
      
}



@end
